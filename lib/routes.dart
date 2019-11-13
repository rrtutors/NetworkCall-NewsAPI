
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/ui/categorylist.dart';
import 'package:newsapp/ui/newslist.dart';
import 'package:newsapp/ui/splash.dart';

class RouteSettngsPage extends RouteSettings{

  static Route<dynamic>generateRoute(RouteSettings settings){
    var args=settings.arguments;
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (_)=>SplashPage());
        break;
      case "/category":
        return MaterialPageRoute(builder: (_)=>NewsCategory());
        break;
      case "/news":
        HashMap<String,String>req=args as HashMap<String,String>;
        return MaterialPageRoute(builder: (_)=>News(req['category']));

        break;
    };
  }
}