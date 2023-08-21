import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_app/home.dart';
import 'package:map_app/tracking_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
Future<void> main() async {
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: InternetConnectionWid(),
      ),
    );
  }
}

class InternetConnectionWid extends StatefulWidget {
  const InternetConnectionWid({super.key});

  @override
  State<InternetConnectionWid> createState() => _InternetConnectionWidState();
}

class _InternetConnectionWidState extends State<InternetConnectionWid> {
  bool _isConnected=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkInternetConnection();
    Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);
  }


  Future<void>_checkInternetConnection()async{
    var connectivityResult=await (Connectivity().checkConnectivity());
    setState(() {
      _isConnected=(connectivityResult!=ConnectivityResult.none);
    });
  }

  void _updateConnectionStatus(ConnectivityResult result){
    setState(() {
      _isConnected=(result!=ConnectivityResult.none);
    });
  }
  @override
  Widget build(BuildContext context) {
    return _isConnected?HomePage():HomePage();
  }
}


//Center(child: Text('Check Your Internet Connection'))