import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:map_app/home.dart';

class SpashScreen extends StatefulWidget {
  const SpashScreen({super.key});

  @override
  State<SpashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SpashScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.8,
           child: AnimatedSplashScreen(
      backgroundColor: Color.fromARGB(255, 4, 1, 27),
      splash: 'assets/splash.png',
splashIconSize: 80,
      nextScreen: HomePage(),
      curve: Curves.easeInOutCubicEmphasized,
      duration: 10000,
      splashTransition: SplashTransition.rotationTransition,
      animationDuration: Duration(seconds: 5),
      //pageTransitionType: PageTransitionType.scale,

    ),
         ),
    Container(
         width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.2,
        color:Color.fromARGB(255, 4, 1, 27) ,
        child: Center(child: Text('BongooS',style: TextStyle(decoration: TextDecoration.none,color: Colors.white,fontSize: 20,fontStyle: FontStyle.normal),)),
      
    )
      ],
    );
  }
}