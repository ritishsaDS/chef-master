import 'dart:convert';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_chef/Ui/Customer/CookDetails.dart';
import 'package:flutter_chef/Ui/Customer/MostSellingDishes.dart';
import 'package:flutter_chef/Ui/Customer/MostSellingDishesDetails.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/NavigationBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/HomePageCard.dart';
import 'package:flutter_chef/Utils/HomePageCookCard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../AskLogin.dart';
import 'Profile.dart';
import 'TopCooks.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({Key key}) : super(key: key);

  @override
  _CustomerHomePageState createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  bool breakfast = false;
  bool lunch = false;
  bool dinner = false;
  bool isLoading = false;
  bool isError = false;
  final _currentPageNotifier = ValueNotifier<int>(0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    getCookfromServer();
    getdishesfromserver();
    getbannerfromserver();
    WidgetsBinding.instance.addPostFrameCallback((_) => _animateSlider());
    // TODO: implement initState
    super.initState();
  }
  final PageController _controller = PageController();

  void _animateSlider() {
    Future.delayed(Duration(seconds: 2)).then((_) {
      int nextPage = _controller.page.round() + 1;

      if (nextPage == bannerfromserver.length) {
        nextPage = 0;
      }

      _controller
          .animateToPage(nextPage, duration: Duration(seconds: 1), curve: Curves.linear)
          .then((_) => _animateSlider());
    });
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap:() => _scaffoldKey.currentState.openDrawer(),
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            title: ImageIcon(
              AssetImage('assets/icons/my dishes icon.png'),
              color: Colors.black,
            ),
            actions: [
              Padding(
                  padding: EdgeInsets.all(5),
                  child: IconButton(icon:Icon(Icons.logout,color: Colors.black,),onPressed: () async {
                    SharedPreferences prefs=await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AskLoginScreen()));
                  },)
              ),
            ],
          ),
          backgroundColor: Colors.white,
          bottomNavigationBar: customerNavBar(0, context),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    "Popular Dishes",
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight * 0.35,
                  child: Stack(
                    children: [
                      PageView(
                          controller: _controller,
                        children:imagewidget(),  onPageChanged: (int index) {
                    _currentPageNotifier.value = index;
                  }


        ),SizedBox(height: 10,),

                    Positioned(


                      bottom:0,
                      right: 0,
                        left: 0,
                      child:   _buildCircleIndicator6(),)

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Color(0XFFFEE715), width: 1.5),
                            borderRadius: BorderRadius.circular(5)),
                        height: SizeConfig.blockSizeVertical * 4,
                        width: SizeConfig.blockSizeHorizontal * 35,
                        margin:
                        EdgeInsets.only(left: SizeConfig.blockSizeVertical * 2),
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
                                  hintText: "Sort By",
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
                                  Icons.keyboard_arrow_down,
                                  color: Colors.black,
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Color(0XFFFEE715), width: 1.5),
                            borderRadius: BorderRadius.circular(5)),
                        height: SizeConfig.blockSizeVertical * 4,
                        width: SizeConfig.blockSizeHorizontal * 35,
                        margin: EdgeInsets.only(
                            right: SizeConfig.blockSizeVertical * 2),
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
                        width: SizeConfig.screenWidth * 0.25,
                      ),
                      Text(
                        "Most Selling Dishes",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        child: Image.asset(
                          'assets/bg/right line.png',
                        ),
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical,
                          left: SizeConfig.blockSizeHorizontal,
                        ),
                        width: SizeConfig.screenWidth * 0.25,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical),
                  width: SizeConfig.screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MaterialButton(
                        minWidth: SizeConfig.screenWidth * 0.28,
                        height: SizeConfig.blockSizeVertical * 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: breakfast == true ? Color(0XFFfee715) : Colors.white,
                        onPressed: () {
                          setState(() {
                            lunch = false;
                            breakfast = true;
                            dinner = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Image.asset('assets/icons/breakfast icon.png'),
                            Image.asset(
                              'assets/icons/breakfast icon.png',
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Text(
                              "Breakfast",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                                  fontWeight: breakfast == true
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: SizeConfig.screenWidth * 0.28,
                        height: SizeConfig.blockSizeVertical * 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: lunch == true ? Color(0XFFfee715) : Colors.white,
                        onPressed: () {
                          setState(() {
                            lunch = true;
                            breakfast = false;
                            dinner = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Image.asset('assets/icons/breakfast icon.png'),
                            Image.asset(
                              'assets/icons/lunch icon.png',
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Text(
                              "Lunch",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                                  fontWeight: lunch == true
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: SizeConfig.screenWidth * 0.28,
                        height: SizeConfig.blockSizeVertical * 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: dinner == true ? Color(0XFFfee715) : Colors.white,
                        onPressed: () {
                          setState(() {
                            dinner = true;
                            breakfast = false;
                            lunch = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //Image.asset('assets/icons/breakfast icon.png'),
                            Image.asset(
                              'assets/icons/dinner icon.png',
                              height: SizeConfig.blockSizeVertical * 2,
                            ),
                            SizedBox(
                              width: SizeConfig.blockSizeHorizontal,
                            ),
                            Text(
                              "Dinner",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                                  fontWeight: dinner == true
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      color: Colors.white,
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.32,
                      child: ListView(
                          primary: false,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: disheswidget()),
                    ),
                    Positioned(
                      right: 0,
                      top: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(80),
                          ),
                          color: Colors.yellow,
                        ),
                        height: SizeConfig.screenHeight * 0.15,
                        width: SizeConfig.blockSizeHorizontal * 11,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/MostSellingDishes');
                          },
                          child: RotatedBox(
                            child: Text(
                              "See All",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 1.25,
                                  fontWeight: FontWeight.bold),
                            ),
                            quarterTurns: 1,
                          ),
                        ),
                      ),
                    )
                  ],
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
                        "Top Cook's",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                            fontWeight: FontWeight.bold),
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
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1.5),
                      color: Colors.white,
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.32,
                      child: ListView(
                          primary: false,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: getcookwidget()),
                    ),
                    Positioned(
                      right: 0,
                      top: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(80),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(80),
                          ),
                          color: Colors.yellow,
                        ),
                        height: SizeConfig.screenHeight * 0.15,
                        width: SizeConfig.blockSizeHorizontal * 11,
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TopCooks()));
                          },
                          child: RotatedBox(
                            child: Text(
                              "See All",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 1.25,
                                  fontWeight: FontWeight.bold),
                            ),
                            quarterTurns: 1,
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ],
            ),
          ),
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
                // ListTile(
                //   leading: Image.asset(
                //     'assets/icons/icon.png',
                //     height: SizeConfig.blockSizeVertical * 4,
                //   ),
                //   trailing: Icon(
                //     Icons.arrow_forward_ios_rounded,
                //     color: Colors.black,
                //   ),
                //   title: Text(
                //     "My cookfromserver",
                //     style: TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
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
        ));
  }

  List<Widget> getcookwidget() {
    setState(() {
      isLoading = true;
    });

    List<Widget> productList = new List();
    for (int i = 0; i < cookfromserver.length; i++) {
      productList.add(GestureDetector(
        onTap:(){
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>CookDetails(
              name: cookfromserver[i]['full_name'],
              phone: cookfromserver[i]['phone_number'].toString()
          )));
        },
        child: homepagecook(
            fullname: cookfromserver[i]['full_name'],
            phone: cookfromserver[i]['phone_number'].toString()),
      ));
    }
    return productList;
  }

  List<Widget> disheswidget() {
    setState(() {
      isLoading = true;
    });

    List<Widget> productList = new List();
    for (int i = 0; i < dishfromserver.length; i++) {
      productList.add(GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>MostSellingDishesDetails(
            name:dishfromserver[i]['name'],
            chefname: dishfromserver[i]["chef_name"]['full_name'].toString(),
            price: dishfromserver[i]['price'],
              image: dishfromserver[i]['image'] == null
                  ? ""
                  : dishfromserver[i]['image'],
            time:dishfromserver[i]['time_taken'],
          ) ));
        },
        child: Homepagecard(
            name: dishfromserver[i]['name'],
            chefname: dishfromserver[i]["chef_name"]['full_name'].toString(),
            price: dishfromserver[i]['price'],
            id:dishfromserver[i]['id'],
            image: dishfromserver[i]['image'] == null
                ? ""
                : dishfromserver[i]['image']),
      ));
    }
    return productList;
  }

  dynamic cookfromserver = List();
  dynamic dishfromserver = List();
  dynamic bannerfromserver = List();

  void getCookfromServer() async {
    try {
      final response = await http.post(Uri.parse(chefListing));
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        cookfromserver = responseJson['data'];

        print(cookfromserver);

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
  void getbannerfromserver() async {
    try {
      final response = await http.get(Uri.parse("http://chief.uplosse.com/api/banner-list"));
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        bannerfromserver = responseJson['data'] as List;

        print(bannerfromserver);

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
  void getdishesfromserver() async {
    try {
      final response = await http.post(Uri.parse(dishListing));
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        dishfromserver = responseJson['data'];

        print(dishfromserver);

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


  List<Widget> imagewidget() {
    setState(() {
      isLoading = true;
    });

    List<Widget> productList = new List();
    for (int i = 0; i < bannerfromserver.length; i++) {
      productList.add(GestureDetector(
        onTap: (){

        },
        child:Image.network(bannerfromserver[i]['image'],fit: BoxFit.fitWidth,)));
    }
    return productList;
  }

  _buildCircleIndicator6() {
    return Padding(padding: EdgeInsets.only(top:20),
      child: CirclePageIndicator(
        dotSpacing: 10.0,
        selectedSize: 15,
        borderColor: Colors.yellow,
        dotColor: Colors.yellow,
        selectedDotColor: Colors.yellowAccent,
        itemCount: bannerfromserver.length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }
}
