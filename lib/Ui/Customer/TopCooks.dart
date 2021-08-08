import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/TopCookCard.dart';
import 'package:http/http.dart'as http;

import 'CookDetails.dart';
class TopCooks extends StatefulWidget {
  const TopCooks({Key key}) : super(key: key);

  @override
  _TopCooksState createState() => _TopCooksState();
}

class _TopCooksState extends State<TopCooks> {

  bool breakfast=false;
  bool lunch=false;
  bool dinner=false;
  bool isError=false;
  bool isLoading=false;

  @override
  void initState() {
    getdishesfromserver();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: customerNavBar(0, context),
      appBar: AppBar(
        backgroundColor: Color(0XFFFEE715),
        title: Text("Top Cook's",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 4,
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color(0XFFFEE715),
                        width: 1.5
                    ),
                    borderRadius: BorderRadius.circular(5)
                ),
                height: SizeConfig.blockSizeVertical * 4,
                width: SizeConfig.screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width:SizeConfig.screenWidth * 0.8,
                      padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
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
                      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                      child: Align(child: Icon(Icons.search,color: Colors.black,),
                        alignment: Alignment.center,),
                    ),
                  ],
                ),
              ),
            ),
            ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: cookwidget()

            ),
          ],
        ),
      ),
    ));
  }
  dynamic dishfromserver=new List();
  void getdishesfromserver() async {
    setState(() {
      isLoading=true;
    });
    try {
      final response = await http.post(Uri.parse(chefListing));
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
        // for(int i=0;i<dishfromserver.length;i++){
        //   searcharray.add( dishfromserver[i]['name']);
        //   print(searcharray.toString());
        // }

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
  List<Widget> cookwidget() {


    List<Widget> productList = new List();

      for (int i = 0; i < dishfromserver.length; i++) {
        productList.add(GestureDetector(
          onTap: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>CookDetails(
            //   name: dishfromserver[i]['full_name'],
            //   phone: dishfromserver[i]["phone_number"].toString(),
            // )));
          },
          child: topcookcard(
              name: dishfromserver[i]['full_name'],
              chefname: dishfromserver[i]["phone_number"].toString(),
            ),
        ));
      }
      return productList;

    }

}
