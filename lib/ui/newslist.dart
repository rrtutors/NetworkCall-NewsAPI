import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/model/newsmodel.dart';

class News extends StatefulWidget{
  String category;
  News(this.category);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryState();
  }

}
class CategoryState extends State<News>{
  List<NewsModel>listNews=[];
  bool hasPages=true;
  ScrollController _scrollController = new ScrollController();
  int page=1;
  static const  _appPrimaryValue = Color(0xFF009688);
  @override
  void initState() {
    fetchnews();
    super.initState();


    _scrollController.addListener(() {
      if(!hasPages)
        {
          return;
        }
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page=page+1;
        fetchnews();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor:_appPrimaryValue,title: Text(widget.category.toUpperCase()),),
      body: listNews.length>0?ListView.builder(
          itemCount: (hasPages)?listNews.length+1:listNews.length,
          itemBuilder: (ctx,index){
        if(index==listNews.length)
          return Center(child: Container(width:50,height: 50,child: CircularProgressIndicator()));
        else
        return setNewsItem(listNews[index]);
      },controller: _scrollController,
      ):Center(child: CircularProgressIndicator(),),
    );
  }

  fetchnews(){
    var request=NewsModel.callNews(widget.category,page);
    request.then((data){

      var resdata=json.decode(data.body);
      String status=resdata['status'];

          hasPages=true;
          var listdata=resdata["articles"] as List;


          setState(() {
        if(status=="ok") {
          for (int k = 0; k < listdata.length; k++) {
            NewsModel myModel = NewsModel();
            myModel.author = listdata[k] ['author'];
            myModel.title = listdata[k] ['title'];
            myModel.description = listdata[k] ['description'];
            myModel.url = listdata[k] ['url'];
            myModel.urlToImage = listdata[k] ['urlToImage'];
            myModel.publishedAt = listdata[k] ['publishedAt'];
            myModel.content = listdata[k] ['content'];
            listNews.add(myModel);
          }
        }
        else
        {
          hasPages=false;
        }
          });



    },onError: (error){
      hasPages=false;
    });
  }

  setNewsItem(NewsModel newsModel)
  {
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: InkWell(
          onTap: (){

          },
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(newsModel.title,style: TextStyle(fontSize: 18,color: Colors.black),),
              SizedBox(height:5,),
             FadeInImage(placeholder: AssetImage("flutter_big.png"), height:200,fit: BoxFit.cover,image: NetworkImage(newsModel.urlToImage,) ),
              SizedBox(height:5,),
              Text((newsModel.content==null)?"":newsModel.content,style: TextStyle(fontSize: 12,color: Colors.grey[800]),maxLines: 3,),
            ],
          )
        ),),
    );
  }
}