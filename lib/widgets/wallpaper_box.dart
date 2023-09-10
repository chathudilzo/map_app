 import 'dart:convert';

 import 'package:carousel_slider/carousel_options.dart';
 import 'package:carousel_slider/carousel_slider.dart';
 import 'package:flutter/material.dart';
 import 'package:flutter/src/widgets/container.dart';
 import 'package:flutter/src/widgets/framework.dart';
 import 'package:flutter_dotenv/flutter_dotenv.dart';
 import 'package:get/get.dart';
 import 'package:get/get_core/src/get_main.dart';
 import 'package:http/http.dart' as http;
 import 'package:loading_animation_widget/loading_animation_widget.dart';
 import 'package:map_app/wallpaper_page.dart';
 class WallpaperBox extends StatefulWidget {
   const WallpaperBox({super.key});

   @override
   State<WallpaperBox> createState() => _WallpaperBoxState();
 }

 class _WallpaperBoxState extends State<WallpaperBox> {
 String apiKey='';
  String apiUrl="";

 List<String> wallpapers=[];
 bool _isLoading=true;

   @override
   void initState() {
     // TODO: implement initState
     super.initState();
    
     getImages();
   }

    void getImages()async{
 await dotenv.load();
 apiKey=dotenv.env['PIXA_API'].toString();
 apiUrl="https://pixabay.com/api/?key=$apiKey&q=wallpaper&image_type=photo";
      try{
        final response=await http.get(Uri.parse(apiUrl));
        print('response${response.body}');
        if(response.statusCode==200){
          final data=json.decode(response.body);
          print(data);
          if(data['hits']!=null){
            print('response${data['hits']}');
            setState(() {
              wallpapers=List<String>.from(data['hits'].map((wallpaper)=>wallpaper['largeImageURL']??""));
              _isLoading=false;
              print('WALLS$wallpapers');
            });
          }else{
            setState(() {
              _isLoading=true;
            });
          }
        }
      }catch(e){
        print(e.toString());
      
      }
    }

  // getImages()async{
  //   try{
  //     PixabayMediaProvider api=PixabayMediaProvider(apiKey:apiKey,language: 'en');
  //     PixabayResponse? response=await api.requestImages(resultsPerPage: 20,category: Category.backgrounds);
  //     if(response!=null){
      
  //       response.hits!.forEach((f){
  //         print(f);
  //       });
  //       setState(() {
  //         _isLoading=false;
  //       });
  //     }
  //   }catch(e){
  //     print(e);
  //   }
  // }

   @override
   Widget build(BuildContext context) {
     return Container(
       child:_isLoading?LoadingAnimationWidget.beat(color: Colors.blue,size: 30):
        CarouselSlider.builder(

         itemCount: wallpapers.length,
          itemBuilder: (BuildContext context,index,ind) {
            return GestureDetector(
             onTap: () {
               print(wallpapers[index]);
               Get.to(()=>WallpaperPage(url:wallpapers[index]));
             },
              child: Container(
               decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
               
                 width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                 child:ClipRRect(borderRadius: BorderRadius.circular(10),
                 child:  Image.network(wallpapers[index],fit: BoxFit.cover,
                 errorBuilder: (context, error, stackTrace) {
                   return Center(child: Text('Check Your Internet Connection',textAlign:TextAlign.center,style: TextStyle(color: Colors.white),));
                 },
                 ),)
                 ),
            )
            ;
          }
          ,
           options: CarouselOptions(
             height: MediaQuery.of(context).size.height,
             autoPlayInterval: Duration(seconds: 5),
             autoPlayAnimationDuration: Duration(seconds: 2),
             autoPlayCurve: Curves.bounceIn,
             viewportFraction: 1.0,
             autoPlay: true,
             scrollDirection: Axis.vertical,
            
            
           )
       )
     );
    
   }
 }