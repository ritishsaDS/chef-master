import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/Customer/AddCard.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class cartListTile extends StatefulWidget{

      String cookName;
  String image;
      String price;
      String id;
      String name;
      String chef_id;
  cartListTile({this.price,this.image,this.cookName,this.id,this.name,this.chef_id});
  @override
  _cartListTileState createState() => _cartListTileState();
}

class _cartListTileState extends State<cartListTile> {
  bool  isError = false;
 bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        // getorder();
      },
      child: Container(
        margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 2,
            left: SizeConfig.screenWidth * 0.02,
            right: SizeConfig.screenWidth * 0.02
        ),
        height: SizeConfig.blockSizeVertical * 10,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[400],
                blurRadius: 1.2,
                spreadRadius: 0.5,
                offset: Offset(1, 1),
              ),
            ]),
        child: Stack(
          children: [
            ListTile(
              onTap: () {
              //  Navigator.of(context).pushNamed('/CustomerCartDetails');
              },
              title: Column(
                children: [
                  Container(
                    margin:EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 8
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.edit,size: SizeConfig.blockSizeVertical * 2,),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 1,
                        ),
                        // Image.asset('assets/icons/delete icon.png',
                        //   height: SizeConfig.blockSizeVertical * 2,)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: SizeConfig.blockSizeVertical * 1.5),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 8,
                      ),
                      Row(
                        children: [
                          Container(
                              margin:
                              EdgeInsets.only(right: SizeConfig.blockSizeHorizontal),
                              child: Text("28/03/2021",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: SizeConfig.blockSizeVertical * 1.25
                                ),)
                          ),
                          Container(
                              margin:
                              EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                              child: Text("11:30 AM",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: SizeConfig.blockSizeVertical * 1.25
                                ),)
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(child: Divider(),
                    margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 20
                    ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Cook",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            widget.cookName,
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 2.5,
                        width: SizeConfig.blockSizeHorizontal * 23,
                        margin: EdgeInsets.only(
                            right: SizeConfig.blockSizeHorizontal * 20
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            getWishlistfroserver();
                          },
                          color: Colors.red,
                          padding: EdgeInsets.zero,
                          child: Text("Buy Now",
                            style:
                            TextStyle(fontSize: SizeConfig.blockSizeVertical * 1.5,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              leading: Container(
                width: SizeConfig.blockSizeHorizontal * 12,
                height: SizeConfig.blockSizeVertical * 6,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0XFFFEE715),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  alignment: Alignment.center,
                  width: SizeConfig.screenWidth * 0.1,
                  height: SizeConfig.blockSizeVertical * 10,
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Text(Constants().currency+    widget.price),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
  dynamic wishlistarray = new List();
  void getWishlistfroserver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("usertoken");
    var Userid = prefs.getInt("Userid");
    print(token);
    // print(widget.id.toString());
    print(Userid.toString());
    var link="https://royalgujarati.com/chief/public/api/order";
    try {
      final response = await post(Uri.parse(link),body: {

        "user_id":
        Userid.toString(),
        "product_id":widget.id,
        "price":widget.price,
        "total_product":"1",
        "chef_id":widget.chef_id


      });
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
showToast("Order Palace");
        wishlistarray = responseJson['data'];
        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCard()));

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
}


