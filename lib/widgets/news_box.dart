import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;



class News{
  String? source;
  String? title;
  String? author;
  String? description;
  String? shortedD;
  String? imageUrl;
  String? content;
  String? date;

  News({this.source,this.title,this.author,this.description,this.imageUrl,this.content,this.date,this.shortedD});

}

class NewsBox extends StatefulWidget {
  const NewsBox({super.key});

  @override
  State<NewsBox> createState() => _NewsBoxState();
}

class _NewsBoxState extends State<NewsBox> {

String apiKey="";
String apiUrl="";

bool _isLoading=true;

List<News> newsData=[];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }


  void getNews()async{
    try{
      await dotenv.load();
      apiKey=dotenv.env['NEWS_API'].toString();
      apiUrl='https://newsapi.org/v2/everything?q=bitcoin&apiKey=$apiKey';
      final response=await http.get(Uri.parse(apiUrl));
      print(response.body);
      if(response.statusCode==200){
        final data=json.decode(response.body);
        List articles=data['articles'];
        List<News>newsList=articles.map((article){
          return News(
            source: article['source']['name'],
            author: article['author'],
            title: article['title'],
            description: article['description'],
            imageUrl: article['urlToImage'],
            content: article['content'],
            date: article['publishedAt'],
          );
        }).toList();

         if(newsList.isNotEmpty){
           setState(() {
             newsData=newsList;
             _isLoading=false;
           }); 
          }
      }

    }catch(e){
      print(e);
    }
  }

  String shorten(String description){
    List<String> words=description.split(' ');
    if(words.length>15){
      return '${words.take(15).join(' ')}...';

    }else{
      return description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading?CircularProgressIndicator():Container(
      child: CarouselSlider.builder(
        itemCount: newsData.length, 
        itemBuilder:(BuildContext context,index,ind){
          return SizedBox(
            width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
                  child: ClipRRect(borderRadius: BorderRadius.circular(10),
                  child:newsData[index].imageUrl!=null? 
                  Image.network(newsData[index].imageUrl.toString(),fit: BoxFit.cover,)
                  :Image.asset('assets/news.jpg')
                  ,),
                ),
                Positioned(
                  left: 0,
                  right: 0,

                  bottom: 0,
                  child: 
                  
                  Container(
                      width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height*0.08,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                        color: Color.fromARGB(255, 196, 209, 7).withOpacity(0.8)
                      ),
                     child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: 
                      SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(shorten(newsData[index].description.toString()),style: TextStyle(fontSize: 10,color: Color.fromARGB(255, 0, 0, 0)),),
                          ],
                        ),
                      )),
                  )
                  
                  
                  )
                
              ],
            ),
          );
        }, 
        options: CarouselOptions(
        height: MediaQuery.of(context).size.height,
        autoPlay: true,
        autoPlayCurve: Curves.bounceIn,
        viewportFraction: 1.0,
        scrollDirection: Axis.vertical,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(seconds: 2))),
    );
  }
}