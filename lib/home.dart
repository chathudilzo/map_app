import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:map_app/controllers/news_controller.dart';
import 'package:map_app/controllers/weather_controller.dart';
import 'package:map_app/weather_page.dart';
import 'package:map_app/widgets/bottom_nav_bar.dart';
import 'package:map_app/widgets/floating_action_button.dart';
import 'package:map_app/widgets/news_box.dart';
import 'package:map_app/widgets/news_list.dart';
import 'package:map_app/widgets/places_box.dart';
import 'package:map_app/widgets/wallpaper_box.dart';
import 'package:map_app/widgets/weather_box.dart';

import 'classes/weather.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherController weatherController = Get.put(WeatherController());
final NewsController newsController=Get.put(NewsController());
  
  WeatherController Wcontroller=Get.find<WeatherController>();

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      body: Container(
        height:height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/plant.jpg'), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                 SizedBox(
                   width: MediaQuery.of(context).size.width ,
                   height: MediaQuery.of(context).size.height * 0.2,
                   child:Obx((){
                    if (Wcontroller.clwIsLoading.value) {
                       return LoadingAnimationWidget.beat(color: Colors.blue, size: 30);
                     } else {
                       Weather? weather = Wcontroller.currentWeather;
                       if (weather != null) {
                         return GestureDetector(
                          onTap: () {
                            Get.to(()=>WeatherPage(weather: weather));
                          },
                           child: SingleChildScrollView(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(weather.city.toString(), style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.bold)),
                                 Text(weather.weatherIcon.toString(), style: TextStyle(fontSize: 40)),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   children: [
                                     Text(weather.temperature?.toStringAsFixed(0) ?? 'N/A', style: TextStyle(color:weather.temperature!>30?Color.fromARGB(255, 228, 150, 6):weather.temperature!<20?Color.fromARGB(255, 13, 228, 228):Color.fromARGB(255, 19, 231, 26),fontSize: 30,fontWeight: FontWeight.bold)),
                                     Text('°C',style: TextStyle(color:Colors.white,fontSize: 25))
                                   ],
                                 ),
                                 Text(weather.condition.toString(), style: TextStyle(color: Colors.white)),
                                 Text(weather.message.toString(), style: TextStyle(color: Colors.white)),
                               ],
                             ),
                           ),
                         );
                       } else {
                         return Text(
                           'Weather data not available.',
                           style: TextStyle(color: Colors.white),
                         );
                       }
                     }
                   })
                     
                   ),
                 
                 // This will take up the available space
                SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      PlacesBox(title: "WallPapers", wid: WallpaperBox(), icon: Icons.image),
                      PlacesBox(title: 'Weather', wid: WeatherBox(), icon: Icons.cloud),
                      PlacesBox(title: "News", wid: NewsBox(), icon: Icons.newspaper),
                      //PlacesBox(),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Center(
                    child: SizedBox(
                     height: height*0.9,
                      child:NewsList()),
                  )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:BottomNavBar() ,
    );
  }
}
