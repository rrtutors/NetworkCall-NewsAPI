import 'package:flutter/material.dart';
import 'package:newsapp/routes.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteSettngsPage.generateRoute,
    );
  }
  
}

/*
Flutter - News Application Sample
Hello Guys, In this post we are going to learn how to integrate Network calls in Flutter

Here i am using the NewsAPI to fetch the news headlines. News API is a simple HTTP REST API for searching and retrieving live articles from all over the web

tO Call api in Flutter we need to add http: ^0.12.0+2 dependencies in the pubspec.yaml file

Create a RouteSetting Page


*/
