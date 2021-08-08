import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/MyDishes.dart';

Widget navBar(int index,BuildContext context){
  return CurvedNavigationBar(
    index: index,
    height: 50.0,
    items: <Widget>[
      InkWell(child: ImageIcon(AssetImage('assets/icons/home icon.png')),
        onTap: (){
          Navigator.of(context).pushNamed('/Home');
        },),
      InkWell(child: ImageIcon(AssetImage('assets/icons/my dishes icon.png')),
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyDishes(sort:"")));
      },),
      InkWell(child: ImageIcon(AssetImage('assets/icons/orders icon.png')),
        onTap: (){
          Navigator.of(context).pushNamed('/Orders');
        },),
      InkWell(child: ImageIcon(AssetImage('assets/icons/my earnings icon.png')),
      onTap: (){
        Navigator.of(context).pushNamed('/MyEarnings');
      },),
      InkWell(child: ImageIcon(AssetImage('assets/icons/profile icon.png')),
      onTap: (){
        Navigator.of(context).pushNamed('/Profile');
      },),

    ],
    color: Color(0XFFfee715),
    buttonBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    animationCurve: Curves.easeInOut,
    animationDuration: Duration(milliseconds: 600),
    onTap: (int i){},
    letIndexChange: (index) => true,
  );
}