import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../colors.dart';

class NewsModel{

Source source;
String author;
String title;
String description;
String url;
String urlToImage;
String publishedAt;
String content;

NewsModel({this.source,this.author,this.title,this.description,this.url,this.urlToImage,this.publishedAt,this.content});

  NewsModel.fromJson(HashMap<String,dynamic> news){
    source= Source.fromJson(news["source"]);
    author=news['author'];
    title=news['title'];
    description=news['description'];
    url=news['url'];
    urlToImage=news['urlToImage'];
    publishedAt=news['publishedAt'];
    content=news['content'];

  }
/*return NewsModel( source: Source.fromJson(news["source"]),
author:news['author'],
title:news['title'],
description:news['description'],
url:news['url'],
urlToImage:news['urlToImage'],
publishedAt:news['publishedAt'],
content:news['content']

});*/

  static Future callNews(type,page) async
  {
    var url=AppColors.api_key;
    return await get('https://newsapi.org/v2/everything?q=$type&apiKey=$url&page=$page');
  }
}
class Source {
  String id;
  String name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json["id"] as String,
      name: json["name"] as String,
    );
  }
}