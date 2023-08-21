import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:map_app/controllers/news_controller.dart';
import 'package:map_app/news_page.dart';
import 'package:map_app/widgets/bottom_nav_bar.dart';
import 'package:map_app/widgets/floating_action_button.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
List<String> titleList=['srilanka','sport','war','agriculture','business','bitcoin','health','enviroment','social','technology','games','travel','education','science'];

NewsController controller=Get.find<NewsController>();
int selectedTitle=0;
//String type=titleList[selectedTitle];

Future<void> getData(String type)async{
controller.getNews(type);
}



  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;




    return Scaffold(
      extendBody: true,
      body: Container(
        height: height,
        color: Color.fromARGB(255, 37, 37, 37),
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 30,),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(blurRadius: 1,spreadRadius: 2,offset: Offset(2,3),color: Color.fromARGB(255, 62, 4, 100))],
                        color: Color.fromARGB(255, 27, 4, 63
                        )),
                      height: height*0.25,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          itemCount: titleList.length,
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            mainAxisExtent: 30,
                            maxCrossAxisExtent: 100),
                           itemBuilder: (context,index){
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedTitle=index;
                                  print(selectedTitle);
                                  getData(titleList[selectedTitle]);
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(blurRadius: 1,spreadRadius: 3,color: Color.fromARGB(255, 10, 10, 10),offset: Offset(2,3))],
                                  borderRadius: BorderRadius.circular(10),
                                  color:selectedTitle==index?Color.fromARGB(255, 109, 170, 11): Colors.white
                                ),
                                child:  Center(child: Text(titleList[index],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                                ),
                            );
                           }),
                      ),
                    ),
                    Container(
                      height: height*0.6,
                      child: Obx((){
                        if(controller.isLoading.value){
                          return LoadingAnimationWidget.inkDrop(color: Color.fromARGB(255, 10, 146, 180), size: 50);
                        }else{
                          return ListView.builder(
                            itemCount: controller.newsData.length,
                            itemBuilder: (context,index){
                            return  GestureDetector(
                                onTap: () {
                                  Get.to(NewsPage(news: controller.newsData[index]));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    //width: width,
                                    //height: height*0.3,
                                    decoration: BoxDecoration(
                                      boxShadow: [BoxShadow(blurRadius: 1,spreadRadius: 1,offset: Offset(2,3),color: Color.fromARGB(255, 8, 68, 117))],
                                      gradient: LinearGradient(colors: [Color.fromARGB(255, 1, 20, 27),Color.fromARGB(255, 56, 55, 55)]),
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
                                ),
                              );
                          });
                        }
                      }),
                    )
                   
                  ],
                ),
                
        ),
            ),floatingActionButton: FloatingActionBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:BottomNavBar(index: 1,) 
          
        
      
    );
  }
}