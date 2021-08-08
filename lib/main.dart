import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/AskLogin.dart';
import 'package:flutter_chef/Ui/Customer/Cust_Cart.dart';
import 'package:flutter_chef/Ui/Customer/Cust_orders.dart';
import 'package:flutter_chef/Ui/Customer/MyWallet.dart';
import 'package:flutter_chef/Ui/Customer/SignUp.dart';
import 'package:flutter_chef/Ui/LoginScreen.dart';
import 'package:flutter_chef/Ui/MyEarnings.dart';
import 'package:flutter_chef/Ui/Profile.dart';
import 'package:flutter_chef/Ui/SignUpCookScreen.dart';
import 'package:flutter_chef/Ui/SplashScreen.dart';
import 'package:flutter_chef/Ui/HomePage.dart';
import 'package:flutter_chef/Ui/MyDishes.dart';
import 'package:flutter_chef/Ui/MyDishesIngredientsScreen.dart';
import 'package:flutter_chef/Ui/EditIngredient.dart';
import 'package:flutter_chef/Ui/Orders.dart';
import 'package:flutter_chef/Ui/DetailedOrder.dart';
import 'Ui/Customer/Login.dart';
import 'package:flutter_chef/Ui/Customer/SignUp2.dart';
import 'package:flutter_chef/Ui/Customer/HomePage.dart';
import 'package:flutter_chef/Ui/Customer/Profile.dart';
import 'package:flutter_chef/Ui/Customer/MostSellingDishes.dart';
import 'package:flutter_chef/Ui/Customer/MostSellingDishesDetails.dart';
import 'package:flutter_chef/Ui/Customer/MyFavourite.dart';
import 'package:flutter_chef/Ui/Customer/AddMoney.dart';
import 'package:flutter_chef/Ui/Customer/AddCard.dart';
import 'package:flutter_chef/Ui/Customer/CustomerOrderDetails.dart';
import 'package:flutter_chef/Ui/Customer/TopCooks.dart';
import 'package:flutter_chef/Ui/Customer/CookDetails.dart';
import 'package:flutter_chef/Ui/Customer/CustomerCartDetails.dart';
import 'package:flutter_chef/Ui/Customer/CustomerPayment.dart';
import 'package:flutter_chef/Ui/AddDish.dart';

import 'Ui/places.dart';
void main(){
  runApp(ChefApp());
}
class ChefApp extends StatefulWidget {
  @override
  _ChefAppState createState() => _ChefAppState();
}

class _ChefAppState extends State<ChefApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chef App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        fontFamily: 'Montserrat',
      ),
      routes: {
        '/AskLogin' : (context)=> AskLoginScreen(),
        '/Login' : (context)=> LoginScreen(),
        '/SignUpCook' : (context)=> SignUpCook(),
        '/Profile' : (context)=> ProfileScreen(),
        '/Home' : (context)=> HomePage(),
        '/MyDishes' : (context)=> MyDishes(),
        '/AddDish' : (context)=> AddDish(),
        '/Ingredients' : (context)=> Ingredients(),
        '/EditIngredients' : (context)=> EditIngredient(),
        '/MyEarnings' : (context)=> MyEarnings(),
        '/Orders' : (context) => Orders(),
        '/DetailedOrder' : (context)=> DetailedOrder(),
        '/CustomerLogin' : (context)=> Login(),
        '/CustomerSignUp' : (context)=> CustomerSignUp(),
        '/CustomerSignUp2' : (context)=> CustomerSignUp2(),
        '/CustomerHomePage' : (context)=> CustomerHomePage(),
        '/CustomerProfile' : (context)=> CustomerProfile(),
        '/MostSellingDishes' : (context)=> MostSellingDishes(),
        '/MostSellingDishesDetails' : (context)=> MostSellingDishesDetails(),
        '/MyFavourite' : (context)=> MyFavourite(),
        '/CustomerOrders' : (context)=> CustomerOrders(),
        '/Cart' : (context)=> Cart(),
        '/Wallet' : (context)=> MyWallet(),
        '/AddMoney' : (context)=> AddMoney(),
        '/AddCard':(context)=>AddCard(),
        '/CustomerOrderDetails':(context)=> CustomerOrderDetail(),
        '/TopCooks':(context)=>TopCooks(),
        '/CookDetails':(context)=> CookDetails(),
        '/CustomerCartDetails':(context)=>CustomerCartDetails(),
        '/CustomerPayment':(context)=>CustomerPayment(),
      },
    );
  }
}
