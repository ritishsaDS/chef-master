import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

Widget cardAddMoney(BuildContext context,
    String cardNo,
    String expiryDate,
    String cardHolderName)
{
  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.only(
      top: SizeConfig.blockSizeVertical,
      left: SizeConfig.screenWidth * 0.02,
      right: SizeConfig.screenWidth * 0.02,
      bottom: SizeConfig.blockSizeVertical
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Color(0XFFFEE715),
    ),
    width: SizeConfig.screenWidth * 0.8,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical,
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/icons/chip.png',
                  height: SizeConfig.blockSizeVertical * 3),
              Image.asset('assets/icons/master card icon.png',
              height: SizeConfig.blockSizeVertical * 3,)
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 2,
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05
          ),
          child: Text("Card No.",style: TextStyle(
            fontSize: SizeConfig.blockSizeVertical * 1.25
          ),),
        ),
        Container(
          margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 0.5,
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05,
          ),
          child: Text(cardNo,
          style: TextStyle(
            fontSize: SizeConfig.blockSizeVertical * 2.5,
          ),),
        ),
        Container(
          margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical,
              left: SizeConfig.screenWidth * 0.05,
              right: SizeConfig.screenWidth * 0.05
          ),
          child: Text("Exp. Date.",style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 1.25
          ),),
        ),
        Container(
          margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 0.5,
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05,
          ),
          child: Text(expiryDate,
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 2,
            ),),
        ),
        Container(
          margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical,
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05,
          ),
          child: Text(cardHolderName,
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 2,
            ),),
        ),
        Container(
          width: SizeConfig.screenWidth,
          margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical * 0.2,
            left: SizeConfig.screenWidth * 0.05,
            right: SizeConfig.screenWidth * 0.05,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset('assets/icons/edit icon.png',
              height: SizeConfig.blockSizeVertical * 2,),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 4,
              ),
              Image.asset('assets/icons/delete icon.png',
                height: SizeConfig.blockSizeVertical * 2,)
            ],
          ),
        ),
      ],
    )
  );
}