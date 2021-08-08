import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/ListTileMyDishes.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';
class chefsearch extends StatefulWidget{
  String sort;
   chefsearch({this.sort}) ;

  @override
  _chefsearchState createState() => _chefsearchState();
}

class _chefsearchState extends State<chefsearch> {
  bool isLoading=false;
  var kdnon;
  bool isError=false;
  @override
  void initState() {

    getdishesfromserver(widget.sort);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
     appBar: AppBar(
        backgroundColor: Color(0XFFFFe715),
        elevation: 0.0,
        centerTitle: true,
        title: Text("Search",style: TextStyle(
            fontSize: SizeConfig.blockSizeVertical * 2.5,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      body: SafeArea(child: Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child:
            Container(

        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.3,
        child:kdnon=="ppsakl"?Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Center(
                child: Image.asset("assets/images/folloe.png"),
              ),
              SizedBox(
                height: 10,
              ),
              Text("No Dish AVailable",style: TextStyle(fontFamily: "proxima",fontSize: 20),)
            ],
          ),
        ): ListView(

          children: disheswidget()
        ),
      ),
          ))),
    );}
  dynamic dishfromserver=new List();
  void getdishesfromserver(sort) async {
    setState(() {
      isLoading=true;
    });
    try {
      SharedPreferences prefs= await SharedPreferences.getInstance();
      var token= prefs.getString("token");
      print(token);
      final response = await http.post(Uri.parse(chefsearchdish), headers: {
        'Authorization': 'Bearer $token',

      } ,body: {"search":sort});
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(dishfromserver.length);
        dishfromserver = responseJson['data'] as List;

        print(dishfromserver);
        if(dishfromserver==null){
          kdnon="ppsakl";
        }
        else{

        }
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });


      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  List<Widget> disheswidget() {
    List<Widget> productList = new List();

    for (int i = 0; i < dishfromserver.length; i++) {
      productList.add(GestureDetector(onTap: () {


        //   name:dishfromserver[i]['name'],
        //   chefname: dishfromserver[i]["chef_name"]['full_name'].toString(),
        //   price: dishfromserver[i]['price'],
        //   image: dishfromserver[i]['image'],
        //   time:dishfromserver[i]['time_taken'],
        // ) ));
      },
          child: Listtilemydish(
              name:dishfromserver[i]["name"],
              timetaken:dishfromserver[i]["time_taken"],
              price:dishfromserver[i]["price"],
              image:dishfromserver[i]["image"],
              id:dishfromserver[i]['id'],
              dish_ingredients:   dishfromserver[i]["dish_ingredients"]
          )

      ));
    }
    return productList;
  }
}