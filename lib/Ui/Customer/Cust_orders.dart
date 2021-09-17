import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/listTileCustomerOrders.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerOrders extends StatefulWidget {
  @override
  _CustomerOrdersState createState() => _CustomerOrdersState();
}

class _CustomerOrdersState extends State<CustomerOrders> {
  bool isLoading = false;
  @override
  void initState() {
    getCookfromServer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Icon(
            Icons.more_vert,
            color: Colors.black,
          ),
          centerTitle: true,
          title: ImageIcon(
            AssetImage('assets/icons/my dishes icon.png'),
            color: Colors.black,
          ),
          actions: [
            Padding(
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://www.persofoto.com/images/vorher-nachher/passfoto-beispiel-vorher.jpg'),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        bottomNavigationBar: Customerbottom(index:2),
        body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Ready Orders",
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
                    height: SizeConfig.screenHeight * 0.3,
                    child: Container(
                      width: SizeConfig.screenWidth,
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeVertical * 2,
                        right: SizeConfig.blockSizeVertical * 2,
                      ),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                      child: Carousel(
                        boxFit: BoxFit.cover,
                        autoplay: true,
                        borderRadius: true,
                        autoplayDuration: Duration(seconds: 3),
                        animationCurve: Curves.fastOutSlowIn,
                        dotSpacing: SizeConfig.blockSizeHorizontal * 3,
                        animationDuration: Duration(milliseconds: 1000),
                        dotSize: 6.0,
                        dotColor: Colors.grey[700],
                        dotIncreasedColor: Color(0XFFFEE715),
                        dotBgColor: Colors.transparent,
                        dotPosition: DotPosition.bottomCenter,
                        //dotVerticalPadding: SizeConfig.blockSizeVertical,
                        showIndicator: true,
                        indicatorBgPadding: 9.0,
                        images: [
                          NetworkImage(
                              'https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),
                          NetworkImage(
                              'https://scx2.b-cdn.net/gfx/news/hires/2016/howcuttingdo.jpg'),
                          NetworkImage(
                              'https://cdn-a.william-reed.com/var/wrbm_gb_food_pharma/storage/images/publications/food-beverage-nutrition/foodnavigator.com/article/2020/04/22/coronavirus-and-obesity-doctors-take-aim-at-food-industry-over-poor-diets/10933380-3-eng-GB/Coronavirus-and-obesity-Doctors-take-aim-at-food-industry-over-poor-diets_wrbm_large.jpg'),
                          NetworkImage(
                              'https://rs.projects-abroad.net/v1/hero/indian-cuisine-south-africa-food-tours-product-5e146c7a97eb2.[1600].jpeg'),
                          NetworkImage(
                              'https://www.refrigeratedfrozenfood.com/ext/resources/NEW_RD_Website/DefaultImages/default-pasta.jpg?1430942591'),
                          NetworkImage(
                              'https://i.pinimg.com/originals/18/20/fe/1820fe688c159fc88ce4429de5fa05b5.jpg'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0XFFFEE715), width: 1.5),
                              borderRadius: BorderRadius.circular(5)),
                          height: SizeConfig.blockSizeVertical * 4,
                          width: SizeConfig.blockSizeHorizontal * 35,
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeVertical * 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: SizeConfig.screenWidth * 0.25,
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal),
                                child: TextField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Completed/Live",
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.25,
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                ),
                              ),
                              Container(
                                color: Color(0XFFFEE715),
                                width: SizeConfig.blockSizeHorizontal * 8,
                                height: SizeConfig.blockSizeVertical * 4,
                                padding: EdgeInsets.all(
                                    SizeConfig.blockSizeHorizontal),
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
                              border: Border.all(
                                  color: Color(0XFFFEE715), width: 1.5),
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
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.5,
                                    ),
                                  ),
                                  cursorColor: Colors.black,
                                ),
                              ),
                              Container(
                                color: Color(0XFFFEE715),
                                width: SizeConfig.blockSizeHorizontal * 8,
                                height: SizeConfig.blockSizeVertical * 4,
                                padding: EdgeInsets.all(
                                    SizeConfig.blockSizeHorizontal),
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
                          width: SizeConfig.screenWidth * 0.3,
                        ),
                        Text(
                          "Completed/Live",
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
                          width: SizeConfig.screenWidth * 0.3,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 3,
                        left: SizeConfig.screenWidth * 0.05,
                        right: SizeConfig.screenWidth * 0.05,
                        bottom: SizeConfig.blockSizeVertical * 3),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: orderwidget()
                        // customerOrders(context, "Live"),
                        // customerOrders(context, "Completed"),
                        // customerOrders(context, "Completed"),
                        // customerOrders(context, "Completed"),

                    ),
                  ),
                ])));
  }

  dynamic cookfromserver = new List();
  void getCookfromServer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt("Userid").toString());
    try {
      final response = await post(
          Uri.parse("https://royalgujarati.com/chief/public/api/my_order"),
          body: ({"user_id": prefs.getInt("Userid").toString()}));
      //   print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        cookfromserver = responseJson['data'];

        print(cookfromserver[0]['name']);

        setState(() {
          //isError = false;
          isLoading = false;
          print('setstate');
        });
      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {
          //isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        // isError = true;
        isLoading = false;
      });
    }
  }

  List<Widget> orderwidget() {
    List<Widget> orderlist = new List();
    for (int i = 0; i <cookfromserver.length; i++) {
      orderlist.add(
       Container(
          margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 1.5,
          ),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[200],
                  blurRadius: 1.5,
                  spreadRadius: 1,
                  offset: Offset(1,1),
                ),
              ]
          ),
          height: SizeConfig.blockSizeVertical * 9,
          child: ListTile(
            onTap: (){
              Navigator.of(context).pushNamed('/CustomerOrderDetails');
            },
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${cookfromserver[i]['name']}",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 2
                    ),),
                    Text("28/03/2021 \t 11:30 AM",style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical,
                      color: Colors.grey,
                    ) ,)
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Made By \n${cookfromserver[i]["business_name"]}",style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical,
                      color: Colors.grey,
                    ) ,),
                    //
                    MaterialButton(onPressed: (){},
                      minWidth: SizeConfig.screenWidth * 0.25,
                      height: SizeConfig.blockSizeVertical * 2,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: Color(0XFFFEE715),
                      child: Text(cookfromserver[i]['status']!=null?cookfromserver[i]['status']:"Not Active",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockSizeVertical * 1.5
                        ),),)
                  ],
                ),
              ],
            ),
            trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
            leading: Container(
              width: SizeConfig.blockSizeHorizontal * 12,
              height: SizeConfig.blockSizeVertical * 6,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network('https://i.pinimg.com/originals/31/ac/7d/31ac7d17b45a6b900090f8a237baa7e4.jpg',fit: BoxFit.cover,),
              ),
            ),
          ),
        ) );
    }
    return orderlist;
  }
}
