import 'dart:async';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_app/widgets/bottom_nav_bar.dart';
import 'package:map_app/widgets/floating_action_button.dart';
///import 'package:location/location.dart';






class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {


String? apiKey;

late GoogleMapController mapController;

LatLng _destination = const LatLng(6.1667, 80.7500);

   LatLng? _userLocation;

  double distance=0;
  TextEditingController _destinationAddressController=TextEditingController();

TextEditingController _userLocationController=TextEditingController();

 List<LatLng> polylineCoordinates=[];

 Set<Polyline> _polylines={};

 //LocationData? currentLocation;

@override
  void initState() {
    
    super.initState();
    loadApi();
    //getCurrentLocation();
  }

void loadApi()async{
   await dotenv.load();
    apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'].toString();
    
}




Future<void> _convertAddressToLatLng(List<Map<String,String>> addresses)async{
  try{
    
    addresses.forEach((mapAddress) async {
      String? address=mapAddress['address'];
      String? type=mapAddress['type'];

        List<Location> location=await locationFromAddress(address!);
    
    if(location.isNotEmpty){
      setState(() {
        if(type=='user'){
          _userLocation=LatLng(location.first.latitude, location.first.longitude);
           print(_userLocation);
          print(_destination);
        }else{
           print(_userLocation);
          print(_destination);
          _destination=LatLng(location.first.latitude, location.first.longitude);
        }

      });

    }});



    getPolyPoints();

    
  }catch(e){
    print(e.toString());
  }
}


  double calculateDistance(lat1,long1,lat2,long2){
    var p=0.017453292519943295;
    var a = 0.5 - cos((lat2 - lat1) * p)/2 + 
          cos(lat1 * p) * cos(lat2 * p) * 
          (1 - cos((long2 - long1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  // void getCurrentLocation()async{
  //   Location location=Location();

  //   location.getLocation().then((location){
  //     currentLocation=location;
  //   });

  //   GoogleMapController googleMapController=await _controller.future;
  //   location.onLocationChanged.listen((newLocation) {
  //     currentLocation=newLocation;
  //     googleMapController.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: LatLng(newLocation.latitude!,newLocation.longitude!),zoom: 13.5)
  //       )
  //     );
  //    });

  // }

  void _onMapCreated(GoogleMapController controller) {
    
    mapController = controller;
  }



  void getPolyPoints()async{
     print(distance);
   if(mapController!=null&& _userLocation!=null){
     PolylinePoints polylinePoints=PolylinePoints();
     polylineCoordinates.clear();

    loadApi();
    PolylineResult result=await polylinePoints.getRouteBetweenCoordinates(apiKey.toString(), PointLatLng(_destination.latitude, _destination.longitude), PointLatLng(_userLocation!.latitude, _userLocation!.longitude));
    print(result.points);
    if(result.points.isNotEmpty){
      print(result.points);
      result.points.forEach(
        (PointLatLng point)=>polylineCoordinates.add(
          LatLng(point.latitude, point.longitude)
      ),
      );
       double totalDistance=0;
       for(var i=0;i<polylineCoordinates.length-1;i++){
        totalDistance += calculateDistance(
                polylineCoordinates[i].latitude, 
                polylineCoordinates[i].longitude, 
                polylineCoordinates[i+1].latitude, 
                polylineCoordinates[i+1].longitude);
       }
      setState(() {
       distance=totalDistance;
        print(distance);
      });
    }
   }
  }
  
  @override
  
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return  Scaffold(
        extendBody: true,
        body: Stack(
  children: [
    GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _destination,
        zoom: 11.0,
      ),
      markers: {
        Marker(markerId: MarkerId("source"), position: _destination),
        if(_userLocation!=null) Marker(markerId: MarkerId("destination"), position: _userLocation!),
      },
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: polylineCoordinates,
          color: Color.fromARGB(255, 54, 73, 244),
          width: 6,
        ),
      },
    ),
    Positioned(
      bottom: 200,
      right: 20,
      child:ClipOval(
  child: Material(
    color: Colors.orange.shade100, // button color
    child: InkWell(
      splashColor: Colors.orange, // inkwell color
      child: SizedBox(
        width: 56,
        height: 56,
        child: Icon(Icons.my_location),
      ),
      onTap: () {
        // TODO: Add the operation to be performed
        // on button tap
      },
    ),
  ),
), ),
    Positioned(
      bottom: 100,
      left: 20,
      child: Container(
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Total Distance " + distance.toStringAsFixed(2) + "KM",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
    ),
    Positioned(
            top: 40,
            left: 16,
            right: 16,
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  
                  controller: _userLocationController,
                  decoration: InputDecoration(
                    prefixText: '1 ',
                    hintText: 'Enter a location',
                    suffixIcon: Icon(Icons.location_on)
                  ),
                ),
              ),
            ),
    ),
    Positioned(
            top: 120,
            left: 16,
            right: 16,
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _destinationAddressController,
                  decoration: InputDecoration(
                    prefixText: '2 ',
                    hintText: 'Enter a location',
                    suffixIcon: Icon(Icons.location_city_rounded),
                  ),
                ),
              ),
            ),
    ),
    Positioned(
      top: 210,
      left: 100,
      right: 100,
      child: GestureDetector(
        onTap: () {
          String address = _destinationAddressController.text;
      String address1 = _userLocationController.text;

      if(address.isNotEmpty && address1.isNotEmpty){
        List<Map<String,String>> addresses=[];
      addresses.add({'address':address,'type':'user'});
      addresses.add({'address':address1,'type':'destination'});
                 _convertAddressToLatLng(addresses);
      }
      

        },
        child: Container(
        width:width*0.2 ,
        height: 50,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 3,spreadRadius: 2,offset: Offset(1,2))],
          borderRadius: BorderRadius.circular(20),
          color: Colors.orange
        ),
        child: Center(child: Text('Show Route',style: TextStyle(fontWeight: FontWeight.bold),),),
          ),
      ))
  ],
),floatingActionButton: FloatingActionBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:BottomNavBar(index: 2,) );
  }
}

   



//import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MapPage extends StatefulWidget {
//   const MapPage({super.key});

//   @override
//   State<MapPage> createState() => _MapPageState();
// }

// class _MapPageState extends State<MapPage> {

// CameraPosition _initialLocation=CameraPosition(target: LatLng(0.0,0.0),zoom: 11);

// late GoogleMapController mapController;




//   @override
//   Widget build(BuildContext context) {
//     double width=MediaQuery.of(context).size.width;
//     double height=MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Container(
//         height: height,
//         width: width,
//         child: Stack(
//           children: [
//             GoogleMap(
//             initialCameraPosition: _initialLocation,
            
//             myLocationEnabled: true,
//             myLocationButtonEnabled: false,
//             mapType: MapType.normal,
//             zoomGesturesEnabled: true,
//             zoomControlsEnabled: false,
//             onMapCreated: (GoogleMapController controller) {
//               mapController = controller;
//             },
//             ),
//             Positioned(
//               bottom: 50,
//               right: 20,
//               child: ClipOval(
//               child: Material(
//                 color: Colors.orange.shade100, // button color
//                 child: InkWell(
//                   splashColor: Colors.orange, // inkwell color
//                   child: SizedBox(
//                     width: 56,
//                     height: 56,
//                     child: Icon(Icons.my_location),
//                   ),
//                   onTap: () {
//                     // TODO: Add the operation to be performed
//                     // on button tap
//                   },
//                 ),
//               ),
//             ),)
//           ],
//         ),
//       ),
//     );
//   }
// }