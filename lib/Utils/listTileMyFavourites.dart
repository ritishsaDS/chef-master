import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

import 'Constants.dart';

Widget myFavouritesCard(
    BuildContext context){
  SizeConfig().init(context);
  return InkWell(
    onTap: (){
      Navigator.of(context).pushNamed('/MostSellingDishesDetails');
    },
    child: Container(
      width: SizeConfig.screenWidth * 0.85,
      height: SizeConfig.screenHeight * 0.3,
      margin: EdgeInsets.only(
        bottom: SizeConfig.blockSizeVertical,
        top: SizeConfig.blockSizeVertical,
        left: SizeConfig.screenWidth * 0.05,
        right: SizeConfig.screenWidth * 0.05,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color(0XFFDDDDDD),
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(
                    2.0,
                    2.0
                )

            )
          ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: SizeConfig.screenHeight * 0.23,
            child: Stack(fit: StackFit.expand,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network('https://www.digitalnegative.co/wp-content/uploads/20161103-EighteenChefs13834.jpg',
                      fit: BoxFit.fill,
                    )),
                //todo: design favourite icon
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 0.5,
                left: SizeConfig.blockSizeVertical
            ),
            child: Text("Dish Name",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeVertical * 2,
              ),),
          ),
          Container(
            height: SizeConfig.blockSizeVertical * 4,
            //color: Colors.pink,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin:EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 0.2,
                      left: SizeConfig.blockSizeVertical
                  ),
                  child: Text("Chef Name",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 1.50,
                        color: Colors.grey
                    ),),
                ),
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
                MaterialButton(onPressed: (){},
                  elevation: 0.0,
                  height: SizeConfig.blockSizeVertical * 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      )
                  ),
                  child: Row(
                    children: [
                      Text(Constants().currency+"200",
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal,
                      ),
                      Icon(Icons.shopping_cart,color: Colors.black,
                        size: SizeConfig.blockSizeVertical * 2.5,)
                    ],
                  ),
                  minWidth: SizeConfig.screenWidth * 0.25,
                  color: Color(0XFFFEE715),)
              ],
            ),
          ),
        ],
      ),
    ),
  );
}