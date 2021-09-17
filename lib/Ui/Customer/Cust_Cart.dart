import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Cartlisttile.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/Cutomerdrawer.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/CustomerNavBar.dart';
import '../../Utils/HomePageCard.dart';
import '../../Utils/SizeConfig.dart';
import 'AddCard.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  bool breakfast = false;
  bool lunch = false;
  bool dinner = false;
 bool isError = false;
bool  isLoading = false;
@override
  void initState() {
  getWishlistfroserver();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: Customerbottom(index:1),
            drawer: Customerdrawer(),
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
                              child: Text(Constants().currency+ "${total.toString()}",
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
                        children: showFavouriteitem()

                      ),
                    ]))));
  }
  dynamic wishlistarray = new List();
var total=00;
  void getWishlistfroserver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("usertoken");
    var Userid = prefs.getInt("Userid");
    print(token);
    // print(widget.id.toString());
    print(Userid.toString());
    var link="https://royalgujarati.com/chief/public/api/get_cart";
    try {
      final response = await post(Uri.parse(link),body: {

        "user_id":
        Userid.toString(),


      });
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        wishlistarray = responseJson['data'][0]['carts'];
        total=responseJson['data'][0]['total_price'];
        //showToast("Dish Added to Wishlist Successfully");
        print(wishlistarray);

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
  List<Widget>  showFavouriteitem() {
    List <Widget> wishlist=List();
    for(int i=0; i<wishlistarray.length;i++){
      wishlist.add(
        GestureDetector(onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCard()));
        },
            child: cartListTile(name:wishlistarray[i]['name'],image:wishlistarray[i]['image'],price:wishlistarray[i]['price'].toString(),id:wishlistarray[i]['id'].toString(),cookName:"Cook Name",chef_id:wishlistarray[i]['chef_id'].toString()))
      );
    }
    return wishlist;
  }
}
