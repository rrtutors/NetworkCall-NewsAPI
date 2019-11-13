import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SplashState();
  }


}
class SplashState extends State<SplashPage>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, "/category");
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(

          //child: Future.delayed(Duration(seconds: 2),(){});
          child: Image.asset("splash_img.png",fit: BoxFit.cover,),

        ));
  }
}