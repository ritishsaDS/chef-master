import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/ListTileMyDishes.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/NavigationBar.dart';
import 'package:flutter_chef/Utils/models/adddishmodule.dart';
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'MyDishesIngredientsScreen.dart';
import 'chefsearch.dart';
class MyDishes extends StatefulWidget {
  String sort;
   MyDishes({this.sort}) ;

  @override
  _MyDishesState createState() => _MyDishesState();
}

class _MyDishesState extends State<MyDishes> {
  bool isError=false;
  bool isLoading=false;
  Sort selectedGender;
  var gendervalue;
  List<Sort> genders = <Sort>[
    const Sort(type: 'Breakfast'),
    const Sort(type: 'Lunch'),
    const Sort(type: 'Dinner')
  ];
  var kdnon;
  var sort="";
  var search;
  @override
  void initState() {
    sort=widget.sort;
    getdishesfromserver(sort);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.more_vert,color: Colors.black,),
        centerTitle: true,
        title: ImageIcon(
          AssetImage('assets/icons/my dishes icon.png'),
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://www.persofoto.com/images/vorher-nachher/passfoto-beispiel-vorher.jpg'),
            ),
          ),
        ],
      ),
     // bottomNavigationBar: navBar(1,context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(child: Text("Popular Dishes",
            //   style: TextStyle(
            //     fontSize: SizeConfig.blockSizeVertical * 2,
            //     fontWeight: FontWeight.bold,
            //   ),),
            //   alignment: Alignment.center,
            //   padding: EdgeInsets.all(SizeConfig.blockSizeVertical),),
    //         Container(
    //           width: SizeConfig.screenWidth,
    //           height: SizeConfig.screenHeight * 0.3,
    //           child: Container(
    //             width: SizeConfig.screenWidth,
    //             padding: EdgeInsets.only(
    //               left: SizeConfig.blockSizeVertical * 2,
    //               right: SizeConfig.blockSizeVertical * 2,
    //             ),
    //             decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(5)
    //             ),
    //             child: Carousel(
    //               boxFit: BoxFit.cover,
    //               autoplay: true,
    //               borderRadius: true,
    //               autoplayDuration: Duration(
    //                   seconds: 3
    //               ),
    //               animationCurve: Curves.fastOutSlowIn,
    //               dotSpacing: SizeConfig.blockSizeHorizontal * 3,
    //               animationDuration: Duration(milliseconds: 1000),
    //               dotSize: 6.0,
    //               dotColor: Colors.grey[700],
    //               dotIncreasedColor: Color(0XFFFEE715),
    //               dotBgColor: Colors.transparent,
    //               dotPosition: DotPosition.bottomCenter,
    //               //dotVerticalPadding: SizeConfig.blockSizeVertical,
    //               showIndicator: true,
    //               indicatorBgPadding: 9.0,
    //               images: [
    //                 NetworkImage('https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),
    //                 NetworkImage('https://scx2.b-cdn.net/gfx/news/hires/2016/howcuttingdo.jpg'),
    //                 NetworkImage('https://cdn-a.william-reed.com/var/wrbm_gb_food_pharma/storage/images/publications/food-beverage-nutrition/foodnavigator.com/article/2020/04/22/coronavirus-and-obesity-doctors-take-aim-at-food-industry-over-poor-diets/10933380-3-eng-GB/Coronavirus-and-obesity-Doctors-take-aim-at-food-industry-over-poor-diets_wrbm_large.jpg'),
    //                 NetworkImage('https://rs.projects-abroad.net/v1/hero/indian-cuisine-south-africa-food-tours-product-5e146c7a97eb2.[1600].jpeg'),
    //                 NetworkImage('https://www.refrigeratedfrozenfood.com/ext/resources/NEW_RD_Website/DefaultImages/default-pasta.jpg?1430942591'),
    //                 NetworkImage('https://i.pinimg.com/originals/18/20/fe/1820fe688c159fc88ce4429de5fa05b5.jpg'),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Container(
    //           margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical,left: 10),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Container(
    //
    //                 decoration: BoxDecoration(
    //                     border: Border.all(
    //                         color: Color(0XFFFEE715),
    //                         width: 1.5
    //                     ),
    //                     borderRadius: BorderRadius.circular(5)
    //                 ),
    //                 height: SizeConfig.blockSizeVertical * 4,
    //                 width: SizeConfig.blockSizeHorizontal * 38,
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Container(
    //                       width: SizeConfig.screenWidth * 0.37,
    //
    //                       child: DropdownButtonFormField<Sort>(
    //
    //                         decoration: InputDecoration.collapsed(hintText: ''),
    //                         //   focusNode: genderFocusNode,
    //                         hint: Text(
    //                           widget.sort==""?" Sort By":widget.sort,
    //                           style: TextStyle(
    //                               fontSize:
    //                               SizeConfig.blockSizeVertical * 1.5),
    //                         ),
    //                         value: selectedGender,
    //                         onChanged: (Sort value) {
    //                           setState(() {
    //                             selectedGender = value;
    //
    //                             sort=selectedGender.type;
    //                             print(sort);
    //                           });
    //                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyDishes(sort:sort)));
    //
    //                         },
    //                         items: genders.map((Sort gender) {
    //                           return DropdownMenuItem<Sort>(
    //                             value: gender,
    //                             child: Text(
    //                               gender.type,
    //                               style: TextStyle(
    //                                   fontSize:
    //                                   SizeConfig.blockSizeVertical *
    //                                       1.5),
    //                             ),
    //                           );
    //                         }).toList(),
    //                       ),
    //                     ),
    //
    //
    //                   ],
    //                 ),
    //               ),
    //
    //               Container(
    //                 decoration: BoxDecoration(
    //                     border: Border.all(
    //                         color: Color(0XFFFEE715),
    //                         width: 1.5
    //                     ),
    //                     borderRadius: BorderRadius.circular(5)
    //                 ),
    //                 height: SizeConfig.blockSizeVertical * 4,
    //                 width: SizeConfig.blockSizeHorizontal * 35,
    //                 margin: EdgeInsets.only(
    //                     right: SizeConfig.blockSizeVertical * 2
    //                 ),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Container(
    //                       width:SizeConfig.screenWidth * 0.2,
    //                       padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
    //                       child: TextFormField(
    //                         style: new TextStyle(
    //
    //                             fontStyle: FontStyle.normal,
    //                             fontSize: 12.0),
    //                         decoration: InputDecoration(
    //                           border: InputBorder.none,
    //                           hintText: "Search",
    //
    //                           hintStyle: TextStyle(
    //                             color: Colors.grey,
    //                             fontSize: SizeConfig.blockSizeVertical * 1,
    //                           ),
    //
    //                         ),
    //                         onChanged: (value){
    //                           setState(() {
    //                             search=value;
    //                           });
    //                         },
    //                         cursorColor: Colors.black,
    //                       ),
    //                     ),
    //                     GestureDetector(
    //                       onTap:(){
    //                         Navigator.push(context,MaterialPageRoute(builder: (context)=>chefsearch(sort:search)));
    //
    // },
    //                       child: Container(
    //                         color: Color(0XFFFEE715),
    //                         width: SizeConfig.blockSizeHorizontal * 8,
    //                         height: SizeConfig.blockSizeVertical * 4,
    //                         padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
    //                         child: Align(child: Icon(Icons.search,color: Colors.black,),
    //                           alignment: Alignment.center,),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
            Container(child: Text("My Videos",
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical * 2,
                fontWeight: FontWeight.bold,
              ),),
              alignment: Alignment.center,
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),),
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.3,
              child: Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeVertical * 2,

                  right: SizeConfig.blockSizeVertical * 2,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline,size: 40,),
                    Text("Add A Video",style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Image.asset('assets/bg/left line.png',),
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical,
                      right: SizeConfig.blockSizeHorizontal,
                    ),
                    width: SizeConfig.screenWidth * 0.35,),
                  Text("My Dishes",style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      fontWeight: FontWeight.bold
                  ),),
                  Container(
                    child: Image.asset('assets/bg/right line.png',),
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical,
                      left: SizeConfig.blockSizeHorizontal,
                    ),
                    width: SizeConfig.screenWidth * 0.35,),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
                top: SizeConfig.blockSizeVertical
              ),
              child: MaterialButton(onPressed: (){
                Navigator.of(context).pushNamed('/AddDish');
              },
                minWidth: SizeConfig.screenWidth,
              color: Color(0XFFFEE715),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
                ),
              child: Text("Add New Dish",
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),),),
            ),
            Container(
              width: SizeConfig.screenHeight*0.50,
             child:kdnon=="ppsakl"?Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: Image.asset("assets/images/folloe.png"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("No Dish AVailable",style: TextStyle(fontFamily: "proxima",fontSize: 20),)
                ],
              ),
            ) :  ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
                children:
                disheswidget()

            ),)

          ],
        ),
      ),
    ));
  }

  dynamic dishfromserver=new List();
  void getdishesfromserver(sort) async {
    setState(() {
      isLoading=true;
    });
    try {
      SharedPreferences prefs= await SharedPreferences.getInstance();
     var token= prefs.getString("token");
      print(token);
      final response = await http.post(Uri.parse(dishsorting), headers: {
        'Authorization': 'Bearer $token',

      } ,body: {"search":sort});
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(dishfromserver.length);
        dishfromserver = responseJson['data'] as List;

print(dishfromserver);

if(dishfromserver==null){
  kdnon="ppsakl";
}
else{

}
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
      productList.add(GestureDetector(onTap: () {


        //   name:dishfromserver[i]['name'],
        //   chefname: dishfromserver[i]["chef_name"]['full_name'].toString(),
        //   price: dishfromserver[i]['price'],
        //   image: dishfromserver[i]['image'],
        //   time:dishfromserver[i]['time_taken'],
        // ) ));
      },
        child: Listtilemydish(
          name:dishfromserver[i]["name"],
          timetaken:dishfromserver[i]["time_taken"],
          price:dishfromserver[i]["price"],
          image:dishfromserver[i]["image"],
            id:dishfromserver[i]['id'],
            dish_ingredients:   dishfromserver[i]["dish_ingredients"]
        )

      ));
    }
    return productList;
  }
}
class Sort {
  const Sort({this.type});
  final String type;
}
