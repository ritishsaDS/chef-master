import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_chef/Ui/AddDish.dart';
import 'package:flutter_chef/Ui/EventsChef.dart';
import 'package:flutter_chef/Ui/HomePage.dart';
import 'package:flutter_chef/Ui/MyDishes.dart';
import 'package:flutter_chef/Ui/MyEarnings.dart';
import 'package:flutter_chef/Ui/Orders.dart';
import 'package:flutter_chef/Ui/Profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'Api.dart';



class MyBottomBarDemo extends StatefulWidget {
  @override
  _MyBottomBarDemoState createState() => new _MyBottomBarDemoState();
}

class _MyBottomBarDemoState extends State<MyBottomBarDemo> {
  int _pageIndex = 0;
  PageController _pageController;
 bool isError = false;
 var imagefromserver;
 bool isLoading = false;
  List<Widget> _children = [
    HomePage(),
    MyDishes(sort:""),
    MyEarnings(),
    Eventschef(),
    Orders(),

    ProfileScreen(),
  ];

  @override
  void initState(){
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        bottomNavigationBar: CurvedNavigationBar(
          //key: _bottomNavigationKey,
          index: 0,
          height: 60.0,
          items: <Widget>[
            ImageIcon(AssetImage('assets/icons/home icon.png')),
            ImageIcon(AssetImage('assets/icons/my dishes icon.png')),
            ImageIcon(AssetImage('assets/icons/orders icon.png')),
            Icon(Icons.event_sharp,color: Colors.black,),
            ImageIcon(AssetImage('assets/icons/my earnings icon.png')),
            ImageIcon(imagefromserver==null? AssetImage("assets/icons/profile icon.png"):NetworkImage(imagefromserver),
    ),
          ],
          color: Color(0XFFfee715),
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          animationCurve:  Curves.easeInCirc,

          animationDuration: Duration(milliseconds: 1000),
          onTap: onTabTapped,
          letIndexChange: (index) => true,
        ),

        body:_children[selectedIndex]
    );
  }
  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  dynamic profile = List();
  Future<void> getprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
  var  token = prefs.getString("usertoken");
    try {
      final response = await http.post(Uri.parse(userprofile), headers: {
        'Authorization': 'Bearer $token',
      });
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        profile = responseJson['data'];
        if(profile['image']==null){
          imagefromserver=null;
        }else{
          setState(() {
            imagefromserver=profile['image'].toString();
            print('adjkdaasdsansan'+imagefromserver);
          });
        }
        // print(loginwithserver['data']['email']);
        print(profile);

        // alternativePhoneController = TextEditingController(
        //     text: profile["alternative_phone_number"].toString());

        // experienceController = TextEditingController(
        //     text: profile["years_of_experience"].toString());
        //  streetController = TextEditingController(text: profile["street_name"]);

        // selectedGender = selectedGender(gender: 'Male');
        //  phoneController=TextEditingController(text: profile["phone_number"]);
        // Navigator.of(context).pushNamed('/CustomerLogin');
        // showToast("");
        //  savedata();
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
}
class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(child: Text("Screen 1")),
    );
  }
}

class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Center(child: Text("Screen 2")),
    );
  }
}

class Screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
      child: Center(child: Text("Screen 3")),
    );
  }
}