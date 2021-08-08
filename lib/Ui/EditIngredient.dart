import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/NavigationBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/EditIngredientTile.dart';

class EditIngredient extends StatefulWidget {
  const EditIngredient({Key key}) : super(key: key);

  @override
  _EditIngredientState createState() => _EditIngredientState();
}

class _EditIngredientState extends State<EditIngredient> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
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
     // bottomNavigationBar: navBar(1, context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(
                "Dish Name",
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
                        Icon(
                          Icons.delete,
                          color: Colors.black,
                          size: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        Icon(
                          Icons.edit,
                          color: Color(0XFFFEE715),
                          size: SizeConfig.blockSizeVertical * 2.5,
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      "\t \t Time \n30 Min. ",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 1.5,
                          color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
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
                    "Ingredients",
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
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
              children: [
                EditIngredientTile(context, "2", "Kg.", "1."),
                EditIngredientTile(context, "2", "Kg.", "1."),
                EditIngredientTile(context, "2", "Kg.", "1."),
                EditIngredientTile(context, "2", "Kg.", "1."),
                EditIngredientTile(context, "2", "Kg.", "1."),
                EditIngredientTile(context, "2", "Kg.", "1."),
                EditIngredientTile(context, "2", "Kg.", "1."),
                EditIngredientTile(context, "2", "Kg.", "1."),
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
                          offset: Offset(1, 1),
                        ),
                      ]),
                  height: SizeConfig.blockSizeVertical * 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Text(
                          "PRICE",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 2.3),
                        ),
                        width: SizeConfig.screenWidth * 0.3,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black,
                                    width:
                                        SizeConfig.blockSizeHorizontal * 0.4),
                                color: Colors.white),
                            alignment: Alignment.center,
                            width: SizeConfig.screenWidth * 0.25,
                            height: SizeConfig.blockSizeVertical * 3,
                            child: Text(
                              "200",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: Colors.black,
                                    width:
                                        SizeConfig.blockSizeHorizontal * 0.4),
                                color: Colors.white),
                            alignment: Alignment.center,
                            width: SizeConfig.screenWidth * 0.12,
                            height: SizeConfig.blockSizeVertical * 3,
                            child: Text(
                              Constants().currency,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
