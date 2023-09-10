 import 'package:flutter/material.dart';
 import 'package:flutter/src/widgets/container.dart';
 import 'package:flutter/src/widgets/framework.dart';
 import 'package:get/get.dart';




 //import 'package:image_downloader/image_downloader.dart';
 import 'package:map_app/widgets/bottom_nav_bar.dart';
 import 'package:map_app/widgets/floating_action_button.dart';

 class WallpaperPage extends StatefulWidget {
   const WallpaperPage({super.key,required this.url});

   final String url;

   @override
   State<WallpaperPage> createState() => _WallpaperPageState();
 }

 class _WallpaperPageState extends State<WallpaperPage> {




//  Future<void> _downloadImage()async{
//    try{
//      String? imageId=await ImageDownloader.downloadImage(widget.url);
//      if(imageId!=null){
//        final fileName= await ImageDownloader.findName(imageId);
//        final path=await ImageDownloader.findPath(imageId);
//        final fileSize=await ImageDownloader.findByteSize(imageId);
//        final mimeType=await ImageDownloader.findMimeType(imageId);

//        Get.snackbar('Image Download', '$fileName$mimeType Image Successfully Downloaded to $path');
      
//      }
//    }catch(error){
//      Get.snackbar('Image Download Failed!', 'Image Downloaded Failed: $error');
//      print(error);
//    }
//  }


   @override
   Widget build(BuildContext context) {
     return Scaffold(
       extendBody: true,
       body: 
          
           Stack(
             children: [
                  Container(
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                       
                         width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                         child:ClipRRect(borderRadius: BorderRadius.circular(10),
                         child:  Image.network(widget.url,fit: BoxFit.cover,
                         errorBuilder: (context, error, stackTrace) {
                           return Center(child: Text('Check Your Internet Connection',textAlign:TextAlign.center,style: TextStyle(color: Colors.white),));
                         },
                         ),)
                         ),
           Positioned(
             bottom:150 ,
             right: 30,
             child:Container(
               width: MediaQuery.of(context).size.width*0.8,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(10),
                 color: Color.fromARGB(255, 56, 56, 56).withOpacity(0.8),
                 boxShadow: [BoxShadow(
                   blurRadius: 3,
                   spreadRadius: 2,
                   color: Colors.blue
                 )]
               ),
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text('Download Image',style: TextStyle(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold),),
                     IconButton(onPressed: (){
             //_downloadImage();
           }, icon: Icon(Icons.download,color: Color.fromARGB(255, 5, 220, 236),size: 45,)),
                   ],
                 ),
               ),
             ) 
            
             )
             ],
           )
         ,
      
         floatingActionButton: FloatingActionBtn(),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
       bottomNavigationBar:BottomNavBar(index: 0,) ,     
                  
     );
                
   }
 }