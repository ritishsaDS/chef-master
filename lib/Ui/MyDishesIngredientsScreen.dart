import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/NavigationBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/ListTileIngredients.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyDishes.dart';

class Ingredients extends StatefulWidget {
  dynamic dish_ingredients;
  int price;
  String name;
  int time;
  int id;
   Ingredients({this.dish_ingredients,this.price,this.name,this.time,this.id}) ;

  @override
  _IngredientsState createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  @override
  void initState() {
    if(widget.dish_ingredients[0]["dish_id"]!=null){
      print(widget.dish_ingredients[0]["dish_id"]);
    }

    // TODO: implement initState
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
     // bottomNavigationBar:navBar(1,context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(child: Text(
          widget.name,
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
                padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeVertical * 2,
                  right: SizeConfig.blockSizeVertical * 2,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Carousel(
                  boxFit: BoxFit.cover,
                  autoplay: true,
                  borderRadius: true,
                  autoplayDuration: Duration(
                      seconds: 3
                  ),
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
                    NetworkImage('https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),
                    NetworkImage('https://scx2.b-cdn.net/gfx/news/hires/2016/howcuttingdo.jpg'),
                    NetworkImage('https://cdn-a.william-reed.com/var/wrbm_gb_food_pharma/storage/images/publications/food-beverage-nutrition/foodnavigator.com/article/2020/04/22/coronavirus-and-obesity-doctors-take-aim-at-food-industry-over-poor-diets/10933380-3-eng-GB/Coronavirus-and-obesity-Doctors-take-aim-at-food-industry-over-poor-diets_wrbm_large.jpg'),
                    NetworkImage('https://rs.projects-abroad.net/v1/hero/indian-cuisine-south-africa-food-tours-product-5e146c7a97eb2.[1600].jpeg'),
                    NetworkImage('https://www.refrigeratedfrozenfood.com/ext/resources/NEW_RD_Website/DefaultImages/default-pasta.jpg?1430942591'),
                    NetworkImage('https://i.pinimg.com/originals/18/20/fe/1820fe688c159fc88ce4429de5fa05b5.jpg'),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
                top: SizeConfig.blockSizeVertical * 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        GestureDetector(onTap:(){
                          showAlertDialog(context);

            },
                          child: Icon(Icons.delete,color: Colors.black,
                          size: SizeConfig.blockSizeVertical * 2.5,),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed('/EditIngredients');
                          },
                          child: Icon(Icons.edit,color: Colors.black,
                            size: SizeConfig.blockSizeVertical * 2.5,),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Text("\t \t Time \n${widget.time}min. ",style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 1.5,
                      color: Colors.grey[700]
                    ),),
                  ),
                ],
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
                  Text("Ingredients",style: TextStyle(
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
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
              children:disheswidget()

            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 1.5,
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0XFFFEE715),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0.5,
                      spreadRadius: 0.5,
                      offset: Offset(1,1),
                    ),
                  ]
              ),
              height: SizeConfig.blockSizeVertical * 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(child: Text("Price".toString(),style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 2.3
                  ),),
                    width: SizeConfig.screenWidth * 0.3,),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Colors.black,
                            width: SizeConfig.blockSizeHorizontal * 0.4
                        ),
                        color: Colors.white),
                    alignment: Alignment.center,
                    width: SizeConfig.screenWidth * 0.25,
                    height: SizeConfig.blockSizeVertical * 3,
                    child: Text(Constants().currency+" ${widget.price}",textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                ],
              ),),
          ],
        ),
      ),
    ));
  }
  List<Widget> disheswidget() {
    List<Widget> productList = new List();

    for (int i = 0; i < widget.dish_ingredients.length; i++) {
      productList.add(GestureDetector(onTap: () {


        //   name:dishfromserver[i]['name'],
        //   chefname: dishfromserver[i]["chef_name"]['full_name'].toString(),
        //   price: dishfromserver[i]['price'],
        //   image: dishfromserver[i]['image'],
        //   time:dishfromserver[i]['time_taken'],
        // ) ));
      },
          child: listingredients(
              ingredient_name:widget.dish_ingredients[i]["ingredient_name"],
              quantity:widget.dish_ingredients[i]["quantity"],
            sno:i,

          )

      ));
    }
    return productList;
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("Delete"),
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
        deletedish();

      },
    );
    Widget Nobutton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
      });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Dish"),
      content: Text("Do You want to add this dish"),
      actions: [
        okButton,
        Nobutton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  dynamic dishfromserver=new List();
  void deletedish() async {
    setState(() {
     // isLoading=true;
    });
    try {
      SharedPreferences prefs= await SharedPreferences.getInstance();
      var token= prefs.getString("token");
      final response = await http.post(Uri.parse(chefdeletdish), headers: {
        'Authorization': 'Bearer $token',
      }, body: {"dish_id": widget.dish_ingredients[0]["dish_id"].toString()});
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(dishfromserver.length);
        dishfromserver = responseJson['data'] as List;

        showToast("Dish Deleted Succesfully");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyDishes(sort: "",)));

        setState(() {

          print('setstate');
        });

      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {

        });
      }
    } catch (e) {
      print(e);
      setState(() {

      });
    }
  }

}
