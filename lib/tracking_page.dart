import 'dart:async';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
///import 'package:location/location.dart';






class MyAppPage extends StatefulWidget {
  const MyAppPage({super.key});

  @override
  State<MyAppPage> createState() => _MyAppPageState();
}

class _MyAppPageState extends State<MyAppPage> {

late GoogleMapController mapController;
String? apiKey;
final Completer<GoogleMapController> _controller = Completer();

  final LatLng _destination = const LatLng(6.1667, 80.7500);

   LatLng? _userLocation;

  double distance=0;
TextEditingController _userLocationController=TextEditingController();

 List<LatLng> polylineCoordinates=[];

 Set<Polyline> _polylines={};

 // LocationData? currentLocation;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadApi();
    //getCurrentLocation();
  }

void loadApi()async{
   await dotenv.load();
    apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'].toString();
    print("apikey"+apiKey.toString());
}




Future<void> _convertAddressToLatLng(String address)async{
  try{
    List<Location> location=await locationFromAddress(address);

    if(location.isNotEmpty){
      setState(() {
        _userLocation=LatLng(location.first.latitude, location.first.longitude);

      });
      getPolyPoints();

    }
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
   if(mapController!=null&& _userLocation!=null){
     PolylinePoints polylinePoints=PolylinePoints();
     polylineCoordinates.clear();

    loadApi();
    PolylineResult result=await polylinePoints.getRouteBetweenCoordinates(apiKey.toString(), PointLatLng(_destination.latitude, _destination.longitude), PointLatLng(_userLocation!.latitude, _userLocation!.longitude));

    if(result.points.isNotEmpty){
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

      });
    }
   }
  }
  
  @override
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green[700],
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Maps Sample App'),
          elevation: 2,
        ),
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
          color: Colors.red,
          width: 6,
        ),
      },
    ),
    Positioned(
      bottom: 200,
      left: 50,
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
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: _userLocationController,
                  decoration: InputDecoration(
                    hintText: 'Enter a location',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        String address = _userLocationController.text;
                        _convertAddressToLatLng(address);
                      },
                    ),
                  ),
                ),
              ),
            ),
    )
  ],
),

      ),
    );
  }
}