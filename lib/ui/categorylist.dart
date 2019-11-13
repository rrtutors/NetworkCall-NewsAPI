import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:newsapp/colors.dart';
import 'package:newsapp/model/newscategory.dart';


class NewsCategory extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  NewsCategorystate();
  }

}
class NewsCategorystate extends State<NewsCategory>{
  static const  _appPrimaryValue = Color(0xFF009688);
  List<NewsCategoryModel>listNews;
  List<NewsCategoryModel>listNewsAll;
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = new Text( 'Search by Category' );
  TextEditingController searchController=new TextEditingController();
  List<Color>liscolors=new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    liscolors.add(Color(0xFF009688));
    liscolors.add(Color(0xFFFF0080));
    liscolors.add(Color(0xFF800080));
    listNews=new List();
    listNewsAll=new List();

    //_searchPressed();
    searchController.addListener((){
      print(searchController.text);
      if (searchController.text.isEmpty) {

        setState(() {
         listNews.clear();
         listNews.addAll(listNewsAll);

        });
      } else {
        setState(() {
          listNews.clear();
         for(int k=0;k<listNewsAll.length;k++)
           {
             print(listNewsAll[k].name+" names ");
             if(listNewsAll[k].name.toLowerCase().contains(searchController.text.toLowerCase()))
               {
                 print(listNewsAll[k].name+" names inside");
                 listNews.add(listNewsAll[k]);
               }
           }
        });
      }
    });
    fetchNews();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _appPrimaryValue,
        title: _appBarTitle,
      leading: IconButton(icon: this._searchIcon, onPressed: (){
        _searchPressed();
      }),
      ),
      body:(listNews.length>0)?ListView.builder(
          itemCount: listNews.length,
          itemBuilder: (ctx,index){
          return setNewsItem(listNews[index],index);
        }):Center(child: CircularProgressIndicator(),),

    );
  }


  setNewsItem(NewsCategoryModel newsModel,index)
  {
    Color color=Colors.green[700];
    if(index==0||index==5||index==11)
      color=liscolors[0];
    else if(index%2==0)
      color=liscolors[1];
    else color=liscolors[2];
    return Card(
      elevation: 5,
      child: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(5),
        child: InkWell(
          onTap: (){
            HashMap<String,String>hm=new HashMap();
            hm['category']=newsModel.category;

            Navigator.pushNamed(context, "/news",arguments: hm);
          },
          child: Row(
          children: <Widget>[
          Container(
            height: 50,
            width: 50,
            decoration: ShapeDecoration(shape: CircleBorder(),color: color),
            child: Center(child: Text(newsModel.name.substring(0,1).toUpperCase(),style: TextStyle(fontSize: 30,color: Colors.white),)),
          ),
          SizedBox(width:15,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(newsModel.name,style: TextStyle(fontSize: 18,color: Colors.black),),
                  SizedBox(height:5,),
                  Text(newsModel.description,style: TextStyle(fontSize: 12,color: Colors.grey[800]),maxLines: 3,),
                ],
              ),
            )
      ],),
        ),),
    );
  }


  fetchNews(){
    var callNews = NewsCategoryModel.callNewsCAtegory();
    callNews.then((data){
      var response=json.decode(data.body );
      var listNewsdata=response['sources']as List;
      setState(() {
        listNews=listNewsdata.map<NewsCategoryModel>((model)=>NewsCategoryModel.fromJson(model)).toList();
        listNewsAll.clear();
        listNewsAll.addAll(listNews);
      });


    },onError: (error){
      print("Result Error $error");
    }
    );

  }
  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: searchController,
          cursorColor: Colors.white,
          style: TextStyle(color: Colors.white),
          decoration: new InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
              prefixIcon: new Icon(Icons.search,color: Colors.white,),
              hintText: 'Search...',
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('Search Example');

        searchController.clear();
      }
    });
  }
}