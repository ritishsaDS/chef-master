import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart'as http;

class Homepagecard extends StatefulWidget {
  String name;
  String image;
  dynamic price;
  var id;
  String chefname;
  Homepagecard({this.chefname, this.image, this.name, this.price,this.id});
  @override
  _HomepagecardState createState() => _HomepagecardState();
}

class _HomepagecardState extends State<Homepagecard> {
  var video;
  bool isLoading= false;
  bool isError=false;
  VideoPlayerController controller;
  @override
  void initState() {
    if (widget.image.contains("mp4")) {
      video = true;
      controller = VideoPlayerController.network(widget.image);

    } else {
      video = false;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
          width: SizeConfig.screenWidth * 0.85,
          height: SizeConfig.screenHeight * 0.3,
          margin: EdgeInsets.only(
            bottom: SizeConfig.blockSizeVertical,
            top: SizeConfig.blockSizeVertical,
            left: SizeConfig.blockSizeHorizontal * 6,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0XFFDDDDDD),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(2.0, 2.0))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.screenHeight * 0.23,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        child: Image.network(
                          widget.image,
                          fit: BoxFit.fill,
                        )),

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 0.5,
                    left: SizeConfig.blockSizeVertical),
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 2,
                  ),
                ),
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 0.2,
                          left: SizeConfig.blockSizeVertical),
                      child: Text(
                        widget.chefname,
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 1.50,
                            color: Colors.grey),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {},
                      elevation: 0.0,
                      height: SizeConfig.blockSizeVertical * 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Row(
                        children: [
                          Text(
                            Constants().currency + widget.price.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal,
                          ),
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                            size: SizeConfig.blockSizeVertical * 2.5,
                          )
                        ],
                      ),
                      minWidth: SizeConfig.screenWidth * 0.25,
                      color: Color(0XFFFEE715),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 5,
          right: 0,
          child: Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(80),
              ),
              color: Colors.white,
            ),
            child: GestureDetector(
              onTap: ()=>
                addtowishlist(),

              child: Center(
                child: Icon(
                  Icons.favorite,
                  color: Colors.pink,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
dynamic addwishlistarray = new List();
  void addtowishlist() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   var token = prefs.getString("usertoken");
   print(token);
   print(widget.id.toString());
    try {
      final response = await http.post(Uri.parse(addWishlist),headers: {
        'Authorization': 'Bearer $token',
      },body: {
        "id":widget.id.toString(),

      });
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        addwishlistarray = responseJson['data'];

        print(addwishlistarray);

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
