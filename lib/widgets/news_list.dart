import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:map_app/controllers/news_controller.dart';

class NewsList extends StatefulWidget {
  const NewsList({super.key});

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
NewsController controller=Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    
    void initState() {
    // TODO: implement initState
    super.initState();
    //controller.getNews('srilanka');
  }
    return Obx((){
          if(controller.isLoading.value){
            return LoadingAnimationWidget.halfTriangleDot(color: Colors.blue, size: 40);
          }else{
            return ListView.builder(
              itemCount: controller.newsData.length,
            itemBuilder:(context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  //width: width,
                  //height: height*0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Color.fromARGB(255, 4, 51, 70),Color.fromARGB(255, 56, 55, 55)]),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(controller.newsData[index].title.toString(),textAlign: TextAlign.center ,style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        SizedBox(
                          width: width*0.8,
                          height: 200,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child:controller. newsData[index].imageUrl!=null?  Image.network(controller.newsData[index].imageUrl.toString(),fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) {
                              return Image.asset('assets/news.jpg');
                            },):Image.asset('assets/news.jpg')

                          ),
                        ),
                        SizedBox(height: 10,),
                        Text(controller.newsData[index].description.toString(),textAlign: TextAlign.center ,style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  ),
                ),
              );
            }
            
            );
          }
        });
  }
}