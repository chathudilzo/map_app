import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:map_app/home.dart';
import 'package:map_app/news_list_page.dart';
import 'package:map_app/tracking_page.dart';

class BottomNavBar extends StatefulWidget {
   BottomNavBar({super.key,required this.index});
  final index;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _bottomNavIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    _bottomNavIndex=widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar(
        inactiveColor: Color.fromARGB(230, 160, 160, 161),
        activeColor: Colors.blueAccent,
        backgroundColor: Colors.black,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            _bottomNavIndex==0?Get.to(()=>HomePage()):_bottomNavIndex==1?Get.to(()=>NewsListPage()):_bottomNavIndex==2?Get.to(()=>MapPage()):Get.to(()=>NewsListPage());

          });
        },
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 20,
        rightCornerRadius: 20,
        icons: [(Icons.home), (Icons.newspaper), (Icons.map), (Icons.apps)],
        activeIndex: _bottomNavIndex,
      );
  }
}