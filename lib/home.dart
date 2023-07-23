import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

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
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        
      },
      child: IconButton(onPressed: (){}, icon: Icon(Icons.travel_explore)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        inactiveColor: Colors.white10,
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