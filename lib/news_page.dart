import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:map_app/widgets/bottom_nav_bar.dart';
import 'package:map_app/widgets/floating_action_button.dart';
import 'package:map_app/widgets/news_box.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key,required this.news});
  final News news;

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black,Color.fromARGB(255, 46, 45, 45)])
        ),
        child: SingleChildScrollView(child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.news.date.toString().substring(0,10),style: TextStyle(color: Color.fromARGB(255, 245, 141, 6),fontSize: 18),)
                ],
              ),
              Text(widget.news.title.toString(),textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(widget.news.imageUrl.toString(),fit: BoxFit.cover,errorBuilder: (context, error, stackTrace) {
                  return Image.asset('assets/news.jpg');
                },),
              ),
              SizedBox(height: 10,),
              Text(widget.news.source.toString(),style: TextStyle(color: Color.fromARGB(255, 8, 229, 236),fontSize: 14),),
              Text(widget.news.author.toString(),style: TextStyle(color: Color.fromARGB(255, 187, 228, 6),fontSize: 14),),
              
              Text(widget.news.description.toString(),style: TextStyle(color: Colors.white,fontSize: 18),)
            ],
          ),
        )),
      ),
      floatingActionButton: FloatingActionBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar:BottomNavBar(index: 1,) 
    );
  }
}