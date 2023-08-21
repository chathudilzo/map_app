import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:map_app/classes/weather.dart';
import 'package:map_app/controllers/weather_controller.dart';
import 'package:map_app/widgets/bottom_nav_bar.dart';
import 'package:map_app/widgets/floating_action_button.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key,required this.weather});
  final Weather weather;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

WeatherController controller=Get.find<WeatherController>();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getSortedWeather(widget.weather.lat!, widget.weather.long!);
  }


  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      extendBody: true,
      
      body: SingleChildScrollView(
        child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 34, 34, 34)
        ),
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.weather.city??'',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey),),
                  Text(' - (Sri Lanka) ',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.grey),
                  )
                ],
              ),
SizedBox(height: 10,),
              Container(
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 3,
                    color: Color.fromARGB(255, 0, 0, 0)
                  )],
                  color: Color.fromARGB(255, 21, 4, 49)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                  children: [
                    
              Row(
                  
                  children: [
                  Column(
                    children: [
                      Row(children: [
                        Text(widget.weather.weatherIcon??'',style: TextStyle(fontSize: 73),),
                  Text(widget.weather.temperature?.toStringAsFixed(0) ?? 'N/A', style: TextStyle(color:widget.weather.temperature!>30?Color.fromARGB(255, 228, 150, 6):widget.weather.temperature!<20?Color.fromARGB(255, 13, 228, 228):Color.fromARGB(255, 19, 231, 26),fontSize: 50,fontWeight: FontWeight.bold)),
                                     Text('°C',style: TextStyle(color:Color.fromARGB(255, 236, 234, 234),fontSize: 25))
                      ],)
                    ],
                  ),
                  Expanded(child: Container()),
                  Column(
                    children: [
                      Row(
                        children: [Text(widget.weather.minTemp!.toStringAsFixed(2),style: TextStyle(fontSize: 20,color: Colors.greenAccent),),
                      Text('|',style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 3, 3, 3))),
                      Text(widget.weather.maxTemp!.toStringAsFixed(2),style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 247, 140, 18)))],
                      )
                    ],
                  ),
                  SizedBox(width: 20,)
              ],),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(widget.weather.condition??'',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white)),
                    
                        Text('Feels Like ${widget.weather.feelsLike!.toStringAsFixed(2)}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),)
                      
                    
                  ],
              )

                  ],
              ),
                ),
              ),
              SizedBox(height: 20,),
              Text(widget.weather.message??'',style: TextStyle(color: Colors.white,fontSize: 20),),
            //Expanded(child: Container())
            Container(
              
              width: width,
              height: height*0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Obx((){
                  
                  if(controller.sortedWIsLoading.value){
                    return  LoadingAnimationWidget.beat(color: Colors.blue, size: 30);
                  }else{
                    return ListView.builder(
                      
                      physics: BouncingScrollPhysics(),
                itemCount: controller.sortedWeatherData.length,
                itemBuilder:(context,index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: width*0.6,
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Colors.black,Color.fromARGB(255, 43, 42, 42),Colors.black]),
                        boxShadow: [BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 3,
                          offset: Offset(2,3),
                          color: Color.fromARGB(255, 0, 0, 0)
                        )]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                              Text('Date: ${DateFormat('MM-dd').format(controller.sortedWeatherData[index].dateTime)}',style: TextStyle(color: Color.fromARGB(255, 238, 168, 16),fontSize: 15),),
                                                      Row(
                                                        children: [
                                                          Text('Hour: ',style: TextStyle(color: Color.fromARGB(255, 206, 197, 183),fontSize: 20,fontWeight: FontWeight.bold),),
                                                      Text(DateFormat('HH:mm').format(controller.sortedWeatherData[index].dateTime)
                                                      ,textAlign:TextAlign.center
                                                      ,style: TextStyle(color: Color.fromARGB(255, 232, 232, 236),fontSize: 20),)
                                                        ],
                                                      ),

                            ],),
                            Text(controller.sortedWeatherData[index].temp.toStringAsFixed(2),style: TextStyle(color: Colors.amberAccent,fontSize: 40,fontWeight: FontWeight.bold),),
                            Text(controller.sortedWeatherData[index].icon.toString(),style: TextStyle(fontSize: 50),),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            
                  
            
                );
                }
                }
                ),
              ),

              
            ),


            ],
          ),
        ),
      )
      ),
      floatingActionButton: FloatingActionBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:BottomNavBar() ,
    );
  }
}