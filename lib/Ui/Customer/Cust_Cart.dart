import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Cartlisttile.dart';
import 'package:flutter_chef/Utils/Constants.dart';

import '../../Utils/CustomerNavBar.dart';
import '../../Utils/HomePageCard.dart';
import '../../Utils/SizeConfig.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool breakfast = false;
  bool lunch = false;
  bool dinner = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: customerNavBar(1, context),
            drawer: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Color(0XFFFEE715),
                    height: SizeConfig.screenHeight * 0.1,
                    width: SizeConfig.screenWidth,
                    padding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical * 2,
                        horizontal: SizeConfig.blockSizeHorizontal * 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "June 10,2021",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.blockSizeVertical * 1.50,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical,
                            ),
                            Text(
                              "Hi,Client Name",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Container(
                          height: SizeConfig.screenHeight * 0.1,
                          width: SizeConfig.screenWidth * 0.1,
                          child: Icon(
                            Icons.menu_rounded,
                            size: SizeConfig.blockSizeVertical * 4,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 4,
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed('/Cart');
                    },
                    leading: Image.asset(
                      'assets/icons/cart icon.png',
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    title: Text(
                      "My Cart",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed('/CustomerOrders');
                    },
                    leading: Image.asset(
                      'assets/icons/orders icon.png',
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    title: Text(
                      "My Orders",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed('/Wallet');
                    },
                    leading: Image.asset(
                      'assets/icons/wallet icon.png',
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    title: Text(
                      "My Wallet",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).pushNamed('/CustomerProfile');
                    },
                    leading: Image.asset(
                      'assets/icons/profile icon.png',
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    title: Text(
                      "My Profile",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.favorite_sharp,
                      color: Colors.black,
                      size: SizeConfig.blockSizeVertical * 4,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    title: Text(
                      "My Favourite",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/MyFavourite');
                    },
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.of(context).popAndPushNamed('/CustomerLogin');
                    },
                    leading: Image.asset(
                      'assets/icons/logout icon.png',
                      height: SizeConfig.blockSizeVertical * 4,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.black,
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: SizeConfig.blockSizeVertical * 30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/bg/earnings top bg.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                              centerTitle: true,
                              title: Text("My Cart",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),),
                              iconTheme: IconThemeData(
                                  color: Colors.black
                              ),
                            ),
                            Container(
                                child: Text("Total Balance"),
                            width: SizeConfig.screenWidth,
                            alignment: Alignment.center,),
                            Container(
                              child: Text(Constants().currency+" 1000",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.blockSizeVertical * 3.25,
                              ),),
                              width: SizeConfig.screenWidth,
                              alignment: Alignment.center,),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 3,
                            ),
                            Container(
                              child: Text("Purchase All",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                              width: SizeConfig.screenWidth * 0.3,
                              height: SizeConfig.blockSizeVertical * 3,
                              alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.black
                              )
                            ),),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Image.asset(
                                'assets/bg/left line.png',
                              ),
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical,
                                right: SizeConfig.blockSizeHorizontal,
                              ),
                              width: SizeConfig.screenWidth * 0.35,
                            ),
                            Text(
                              " Pending \nPayments",
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              child: Image.asset(
                                'assets/bg/right line.png',
                              ),
                              margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical,
                                left: SizeConfig.blockSizeHorizontal,
                              ),
                              width: SizeConfig.screenWidth * 0.35,
                            ),
                          ],
                        ),
                      ),
                      ListView(
                        primary: false,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          cartListTile(context,
                          "Cook Name","200"),
                          cartListTile(context,
                              "Cook Name","400"),
                          cartListTile(context,
                              "Cook Name","600"),
                          cartListTile(context,
                              "Cook Name","900"),
                          cartListTile(context,
                              "Cook Name","1100"),

                        ],
                      ),
                    ]))));
  }
}
