import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/MostSellingDishesCard.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Utils/Api.dart';
import 'MostSellingDishesDetails.dart';

class MostSellingDishes extends StatefulWidget {
  const MostSellingDishes({Key key}) : super(key: key);

  @override
  _MostSellingDishesState createState() => _MostSellingDishesState();
}

class _MostSellingDishesState extends State<MostSellingDishes> {
  bool breakfast = false;
  bool lunch = false;
  bool dinner = false;
  bool isError = false;
  TextEditingController _textEditingController = TextEditingController();
  bool isLoading = false;
  List searcharray = [];
  List foodListSearch = [];
  @override
  void initState() {
    getdishesfromserver();
    // TODO: implement initState
    super.initState();
  }

  Sort selectedGender;
  var gendervalue;
  List<Sort> genders = <Sort>[
    const Sort(type: 'Breakfast'),
    const Sort(type: 'Lunch'),
    const Sort(type: 'Dinner')
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Customerbottom(index:0),
      appBar: AppBar(
        backgroundColor: Color(0XFFFEE715),
        title: Text(
          "Most Selling Dishes",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0XFFFEE715), width: 1.5),
                        borderRadius: BorderRadius.circular(5)),
                    height: SizeConfig.blockSizeVertical * 4,
                    width: SizeConfig.blockSizeHorizontal * 38,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.37,
                          child: DropdownButtonFormField<Sort>(
                            decoration: InputDecoration.collapsed(hintText: ''),
                            //   focusNode: genderFocusNode,
                            hint: Text(
                              "Sort By",
                              style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 1.5),
                            ),
                            value: selectedGender,
                            onChanged: (Sort value) {
                              setState(() {
                                selectedGender = value;
                                print(selectedGender.type);
                              });
                            },
                            items: genders.map((Sort gender) {
                              return DropdownMenuItem<Sort>(
                                value: gender,
                                child: Text(
                                  gender.type,
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.blockSizeVertical * 1.5),
                                ),
                              );
                            }).toList(),
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
                    width: SizeConfig.blockSizeHorizontal * 38,
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
                            onChanged: (value) {
                              setState(() {
                                print(value);
                                print(searcharray);
                                foodListSearch = searcharray
                                    .where((element) => element.contains(value))
                                    .toList();
                                if (_textEditingController.text.isNotEmpty &&
                                    foodListSearch.length == 0) {
                                  print(
                                      'foodListSearch length ${foodListSearch.length}');
                                }
                              });
                            },
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
                  child: isLoading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: SizeConfig.screenHeight / 2,
                            ),
                            Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.yellow,
                              ),
                            ),
                          ],
                        )
                      : ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: disheswidget()),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  dynamic dishfromserver = new List();
  void getdishesfromserver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("usertoken");
    var Userid = prefs.getInt("Userid");
    setState(() {
      isLoading = true;
    });
    try {
      final response = await http.post(Uri.parse(dishListing),body: {
      //"product_id":widget.id.toString(),
      "user_id":
      Userid.toString(),


      });
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

  List<Widget> disheswidget() {
    List<Widget> productList = new List();

    for (int i = 0; i < dishfromserver.length; i++) {
      productList.add(GestureDetector(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => MostSellingDishesDetails(
          //               name: dishfromserver[i]['name'],
          //               image: dishfromserver[i]['image'] ,
          //               price: dishfromserver[i]['price'],
          //               id: dishfromserver[i]['id'],
          //               chefname: dishfromserver[i]["chef_name"]['full_name'].toString(),
          //               time: "43",
          //             )));
        },
        child: mostsellingdishes(
          name: dishfromserver[i]['dishes']['name'],
         // chefname: dishfromserver[i]["chef_name"]['full_name'].toString(),
          price: dishfromserver[i]['dishes']['price'],
          id: dishfromserver[i]['dishes']['id'],
          image: dishfromserver[i]['dishes']['image'] == null
              ? ""
              : dishfromserver[i]['dishes']['image'],
        ),
      ));
    }
    return productList;
  }
}

class Sort {
  const Sort({this.type});
  final String type;
}
