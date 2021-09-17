import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/NavigationBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/ListTileTotalOrders.dart';

class Orders extends StatefulWidget {
  const Orders({Key key}) : super(key: key);

  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(child: Scaffold(
     // bottomNavigationBar: navBar(2),


      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/bg/top bg orders .png'),
                  fit: BoxFit.cover,
                )),
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppBar(
                      backgroundColor: Color(0XFFFFe715),
                      elevation: 0.0,
                      centerTitle: true,
                      title: Text(
                        "Orders",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 2.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      iconTheme: IconThemeData(color: Colors.black),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 2.5,
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Total Orders",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: SizeConfig.blockSizeVertical * 1.5),
                          ),
                          Text(
                            "30",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Pending Orders",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.5),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "05",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "/30",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Completed Orders",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.5),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "20",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "/30",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "Cancelled Orders",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        SizeConfig.blockSizeVertical * 1.5),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "05",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "/30",
                                    style: TextStyle(
                                        fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.05,
                      ),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0XFFFEE715), width: 1.5),
                          borderRadius: BorderRadius.circular(5)),
                      height: SizeConfig.blockSizeVertical * 4,
                      width: SizeConfig.blockSizeHorizontal * 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.2,
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Completed",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                                ),
                              ),
                              cursorColor: Colors.black,
                            ),
                          ),
                          Container(
                            color: Color(0XFFFEE715),
                            width: SizeConfig.blockSizeHorizontal * 8,
                            height: SizeConfig.blockSizeVertical * 4,
                            padding:
                                EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                            child: Align(
                              child: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.black,
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: SizeConfig.screenWidth * 0.05,
                      ),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0XFFFEE715), width: 1.5),
                          borderRadius: BorderRadius.circular(5)),
                      height: SizeConfig.blockSizeVertical * 4,
                      width: SizeConfig.blockSizeHorizontal * 30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: SizeConfig.screenWidth * 0.2,
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal),
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                                ),
                              ),
                              cursorColor: Colors.black,
                            ),
                          ),
                          Container(
                            color: Color(0XFFFEE715),
                            width: SizeConfig.blockSizeHorizontal * 8,
                            height: SizeConfig.blockSizeVertical * 4,
                            padding:
                                EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                            child: Align(
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/bg/left line.png',
                      ),
                      margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal,
                      ),
                      width: SizeConfig.screenWidth * 0.35,
                    ),
                    Text(
                      "Completed",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 2,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      child: Image.asset(
                        'assets/bg/right line.png',
                      ),
                      margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal,
                      ),
                      width: SizeConfig.screenWidth * 0.35,
                    ),
                  ],
                ),
              ),
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  listTileTotalOrders(context),
                  listTileTotalOrders(context),
                  listTileTotalOrders(context),
                  listTileTotalOrders(context),
                  listTileTotalOrders(context),
                  listTileTotalOrders(context),
                ],
              ),
            ],
          )),
    ));

}}
