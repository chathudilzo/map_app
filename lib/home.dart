import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:map_app/widgets/places_box.dart';
import 'package:map_app/widgets/weather_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //backgroundColor: Colors.black,
    extendBody: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/plant.jpg',),fit: BoxFit.cover
        ),

      ),
      child: Padding(
        padding: const EdgeInsets.only(left:8.0),
        child: Column(
          children: [
            Expanded(child: Container()),
            SizedBox(
              width: MediaQuery.of(context).size.width ,
              height: MediaQuery.of(context).size.width * 0.4,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  PlacesBox(title: "WallPapers",wid: WeatherBox(),),
                  
                  //PlacesBox(),
                 // PlacesBox(),
                  //PlacesBox(),
                ],
              ),
            ),
            SizedBox(height:MediaQuery.of(context).size.height*0.08,)
          ],
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
        
      },
      child: Container(
  // width: MediaQuery.of(context).size.width * 0.5,
  // height: MediaQuery.of(context).size.width * 0.5,
  child: ClipOval(
    child: Image(
      image: AssetImage('assets/icon.jpg'),
      fit: BoxFit.cover,
    ),
  ),
  padding: EdgeInsets.all(2),
  decoration: BoxDecoration(
    boxShadow: [BoxShadow(
      blurRadius: 3,
      spreadRadius: 3,
      color: Color.fromARGB(255, 10, 62, 175)
    )],
    border: Border.all(color: Color.fromARGB(255, 3, 10, 70), width: 4),
    borderRadius: BorderRadius.circular(50),
  ),
)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        inactiveColor: Color.fromARGB(230, 160, 160, 161),
        activeColor: Colors.blueAccent,
        backgroundColor: Colors.black,
        onTap: (index) {
          setState(() {
            _bottomNavIndex=index;
          });
        },
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        icons: [(Icons.home),(Icons.newspaper),(Icons.map),(Icons.apps),],
      activeIndex: 0,),

    
    );
  }
}