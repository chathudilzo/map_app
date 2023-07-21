# map_app

A new Flutter project.

## Getting Started
import 'dart:async';
import 'dart:math';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
These lines import the required packages and libraries for the Flutter app:

dart:async is for working with asynchronous programming.
dart:math provides mathematical functions.
flutter_dotenv is used to access environment variables defined in the .env file.
flutter/material.dart provides Flutter widgets and material design components.
flutter_polyline_points is used to fetch the polyline points between two locations.
geocoding is used for geocoding, i.e., converting addresses to latitude and longitude coordinates.
google_maps_flutter is for displaying Google Maps in the app.


..........................................................................................................................................................................
class MyAppPage extends StatefulWidget {
  const MyAppPage({super.key});

  @override
  State<MyAppPage> createState() => _MyAppPageState();
}
This class defines the MyAppPage widget, which is a stateful widget. It has a single method createState() that returns the _MyAppPageState object, which holds the state for the widget.


class _MyAppPageState extends State<MyAppPage> {
This class represents the state for the MyAppPage widget. It extends the State class and provides the implementation for building the UI and handling the user interactions.

..........................................................................................................................................................................
late GoogleMapController mapController;
String? apiKey;
final Completer<GoogleMapController> _controller = Completer();

final LatLng _destination = const LatLng(6.1667, 80.7500);
LatLng? _userLocation;
double distance = 0;
TextEditingController _userLocationController = TextEditingController();
List<LatLng> polylineCoordinates = [];
Set<Polyline> _polylines = {};
These are the member variables of the _MyAppPageState class:

mapController is used to control the GoogleMap widget.
apiKey is used to store the API key retrieved from the environment variables in .env.
_controller is a completer to handle asynchronous operations related to GoogleMapController.
_destination is a constant LatLng object representing the destination location.
_userLocation is a nullable LatLng object representing the user's selected location.
distance stores the calculated distance between the destination and the user's location.
_userLocationController is a TextEditingController for the user location input field.
polylineCoordinates stores the list of LatLng objects representing the polyline points for the route.
_polylines is a set of Polyline objects to draw the polylines on the map.


..........................................................................................................................................................................
@override
void initState() {
  super.initState();
  loadApi();
}
This is the initState() method, which is called when the widget is created. It calls the loadApi() method to retrieve the API key from the environment variables.

dart
Copy code
void loadApi() async {
  await dotenv.load();
  apiKey = dotenv.env['GOOGLE_MAPS_API_KEY'].toString();
  print("apikey" + apiKey.toString());
}
The loadApi() method loads the environment variables defined in the .env file and retrieves the GOOGLE_MAPS_API_KEY from it.

..........................................................................................................................................................................
Future<void> _convertAddressToLatLng(String address) async {
  try {
    List<Location> location = await locationFromAddress(address);

    if (location.isNotEmpty) {
      setState(() {
        _userLocation = LatLng(location.first.latitude, location.first.longitude);
      });
      getPolyPoints();
    }
  } catch (e) {
    print(e.toString());
  }
}
The _convertAddressToLatLng() method takes an address as input and converts it to latitude and longitude coordinates using the geocoding package. If the location is found, it sets the _userLocation variable with the obtained coordinates and calls the getPolyPoints() method.

..........................................................................................................................................................................
double calculateDistance(lat1, long1, lat2, long2) {
  var p = 0.017453292519943295;
  var a = 0.5 - cos((lat2 - lat1) * p) / 2 +
      cos(lat1 * p) * cos(lat2 * p) * (1 - cos((long2 - long1) * p)) / 2;
  return 12742 * asin(sqrt(a));
}
This calculateDistance() function calculates the distance between two latitude and longitude coordinates using the Haversine formula.

..........................................................................................................................................................................
void _onMapCreated(GoogleMapController controller) {
  mapController = controller;
}
This method is called when the GoogleMap widget is created, and it assigns the controller to mapController.

..........................................................................................................................................................................
void getPolyPoints() async {
  if (mapController != null && _userLocation != null) {
    PolylinePoints polylinePoints = PolylinePoints();
    polylineCoordinates.clear();

    loadApi();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      apiKey.toString(),
      PointLatLng(_destination.latitude, _destination.longitude),
      PointLatLng(_userLocation!.latitude, _userLocation!.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      double totalDistance = 0;
      for (var i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        distance = totalDistance;
      });
    }
  }
}
The getPolyPoints() method calculates the polyline points between the destination and the user's location using the flutter_polyline_points package. It retrieves the polyline points, calculates the total distance, and updates the distance variable accordingly.

..........................................................................................................................................................................
@override
Widget build(BuildContext context) {
  return MaterialApp(
    // ...
  );
}
This is the build() method, which returns the MaterialApp widget, and the app's UI is built inside it.

..........................................................................................................................................................................
body: Stack(
  children: [
    // GoogleMap widget with markers and polylines
    // Positioned widgets for user location input and distance display
  ],
),
The Stack widget is used to stack multiple widgets on top of each other. In this case, it contains a GoogleMap widget for displaying the map with markers and polylines, as well as Positioned widgets for the user location input field and the distance display.

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
