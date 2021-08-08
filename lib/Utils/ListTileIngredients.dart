import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

class listingredients extends StatelessWidget{
  String ingredient_name;
  String quantity;
  int sno;
  listingredients({this.ingredient_name,this.quantity,this.sno});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Container(
      margin: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 1.5,
      ),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
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
      child:  Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
              ),
              width: SizeConfig.screenWidth * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("${sno+1}".toString()),
                  Container(
                    color: Color(0XFFFEE715),
                    height: SizeConfig.blockSizeVertical * 6,
                    width: SizeConfig.blockSizeHorizontal * 0.4,
                  ),
                  Text(ingredient_name,style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                ],
              ),
            ),
            Container(
              width: SizeConfig.screenWidth * 0.35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color(0XFFFEE715),
                            width: SizeConfig.blockSizeHorizontal * 0.4
                        )),
                    alignment: Alignment.center,
                    width: SizeConfig.screenWidth * 0.2,
                    height: SizeConfig.blockSizeVertical * 3,
                    child: Text(quantity.toString(),textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0XFFFEE715),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )
                    ),
                    alignment: Alignment.center,
                    width: SizeConfig.blockSizeHorizontal * 8,
                    height: SizeConfig.blockSizeVertical * 6,
                    child: RotatedBox(
                      child: Text("Req.",style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                      quarterTurns: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }

}