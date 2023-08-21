import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:map_app/widgets/news_box.dart';
import 'package:http/http.dart' as http;
class NewsController extends GetxController{
  String apiKey="";
String apiUrl="";

RxBool isLoading=true.obs;

RxList<News> newsData=RxList<News>();

@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getNews('srilanka');
  }

void getNews(String type)async{
    try{
      isLoading.value=true;
      await dotenv.load();
      apiKey=dotenv.env['NEWS_API'].toString();
      apiUrl='https://newsapi.org/v2/everything?q=$type&apiKey=$apiKey';
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
            newsData.value=newsList;
            isLoading.value=false;
          }
      }

    }catch(e){
      print(e);
    }
  }
}