import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

import '../colors.dart';
class NewsCategoryModel {
  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

  NewsCategoryModel(this.id,this.name,this.description,this.url,this.category,this.language,this.country);

  NewsCategoryModel.fromJson(Map<String,dynamic>parseModel)
  {
    id=parseModel['id'];
    name=parseModel['name'];
    description=parseModel['description'];
    url=parseModel['url'];
    category=parseModel['category'];
    language=parseModel['language'];
    country=parseModel['country'];
  }

  static Future callNewsCAtegory() async{
    var url=AppColors.api_key;
    return  get('https://newsapi.org/v2/sources?apiKey=$url&page=1');
    //return  get('http://jsonplaceholder.typicode.com/photos');
  }
}