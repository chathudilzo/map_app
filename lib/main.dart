import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
