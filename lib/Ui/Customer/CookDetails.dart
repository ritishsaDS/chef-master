import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/MostSellingDishesCard.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CookDetails extends StatefulWidget {
  dynamic name;
  dynamic phone;
   CookDetails({this.name,this.phone}) ;

  @override
  _CookDetailsState createState() => _CookDetailsState();
}

class _CookDetailsState extends State<CookDetails> {

  bool aboutCook = true;
  bool dishes = false;
  bool popularDishes = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: customerNavBar(0, context),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.3,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.elliptical(SizeConfig.screenWidth, 150),
                    ),
                    image: DecorationImage(
                        image: NetworkImage('https://st.depositphotos.com/1743476/1276/i/600/depositphotos_12768786-stock-photo-dinner-preparation-at-restaurant.jpg'),
                        fit: BoxFit.cover
                    )
                ),
                child: Column(
                  children: [
                    AppBar(
                      title: Text("Top Cook's",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),),
                      centerTitle: true,
                      backgroundColor: Colors.white38,
                      elevation: 0.0,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Best Dish",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 1.50
                          ),),
                        Text("Dish Name",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: SizeConfig.blockSizeVertical * 1.50
                          ),),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rating",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 1.50
                          ),),
                        Container(
                          margin: EdgeInsets.only(
                              right: SizeConfig.blockSizeHorizontal * 5
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.star_sharp,color:Colors.yellow[600],
                                size: SizeConfig.blockSizeVertical * 2,),
                              Text("4.5",style: TextStyle(
                                  fontSize: SizeConfig.blockSizeVertical * 1.25,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Image.asset('assets/bg/left line.png',),
                      width: SizeConfig.screenWidth * 0.35,),
                    Text(widget.name,style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        fontWeight: FontWeight.bold
                    ),),
                    Container(
                      child: Image.asset('assets/bg/right line.png',),
                      width: SizeConfig.screenWidth * 0.35,),
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical * 2
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(onPressed: (){
                      setState(() {
                        aboutCook = true;
                        dishes = false;
                        popularDishes = false;

                      });
                    },
                      child: Text("About Cook",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeVertical * 1.50,
                        ),
                      ),
                      color: aboutCook == true ? Color(0XFFFEE715) : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),),
                    MaterialButton(onPressed: (){
                      setState(() {
                        aboutCook = false;
                        dishes = true;
                        popularDishes = false;

                      });
                    },
                      child: Text("Dishes",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeVertical * 1.50,
                        ),
                      ),
                      color: dishes == true ? Color(0XFFFEE715) : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),),
                    MaterialButton(onPressed: (){
                      setState(() {
                        aboutCook = false;
                        dishes = false;
                        popularDishes = true;

                      });
                    },
                      child: Text("Popular Dishes",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeVertical * 1.50,
                        ),
                      ),
                      color: popularDishes == true ? Color(0XFFFEE715) : Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),)
                  ],
                ),
              ),
              if(aboutCook == true)
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical * 2
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        offset: Offset(1,1),
                        spreadRadius: 0.6,
                        blurRadius: 1
                      )
                    ]
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:EdgeInsets.symmetric(
                          vertical: SizeConfig.blockSizeVertical * 1.2,
                          horizontal: SizeConfig.screenWidth * 0.05
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("About Cook",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                            ),),
                            Text("Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.\n\n"
                                "Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical * 1.50
                              ),),
                          ],
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        child: Divider(
                          color: Color(0XFFFEE715),
                          thickness: 1.0,
                        ),
                      ),
                      Container(
                        margin:EdgeInsets.symmetric(
                            vertical: SizeConfig.blockSizeVertical * 1.2,
                            horizontal: SizeConfig.screenWidth * 0.05
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Most Selling Dish",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold
                                  ),),
                                Text("Dish Name",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: SizeConfig.blockSizeVertical * 1.50
                                  ),),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text("Rating",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.blockSizeVertical * 1.50
                                  ),),
                                SizedBox(
                                  height: SizeConfig.blockSizeVertical * 0.2,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Colors.amber
                                    )
                                  ),
                                  padding: EdgeInsets.all(2),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.amber,
                                        ),
                                        height: SizeConfig.blockSizeVertical * 2,
                                        child: Icon(Icons.star,color: Colors.white,
                                        size: SizeConfig.blockSizeVertical * 2,),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.blockSizeHorizontal,
                                      ),
                                      RatingBar.builder(itemBuilder: (context, _)=> Icon(
                                        Icons.star,color: Colors.amber,
                                      ), onRatingUpdate: (rating){
                                        print(rating);
                                      },
                                      itemCount: 5,
                                      allowHalfRating: true,
                                      direction: Axis.horizontal,
                                      glow: true,
                                      initialRating: 0,
                                        glowColor: Colors.amberAccent,
                                        itemSize: SizeConfig.blockSizeVertical * 2,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              if(dishes == true)
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2,
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // mostSellingDishesCard(context),
                      // mostSellingDishesCard(context),
                      // mostSellingDishesCard(context),
                      // mostSellingDishesCard(context),
                      // mostSellingDishesCard(context),

                    ],
                  ),
                ),
              if(popularDishes == true)
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2,
                    bottom: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      // mostSellingDishesCard(context),
                      // mostSellingDishesCard(context),
                      // mostSellingDishesCard(context),
                      // mostSellingDishesCard(context),
                      // mostSellingDishesCard(context),

                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
