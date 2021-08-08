import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

List<Quantity> quantity = <Quantity>[const Quantity(qty: 'Kg.'),
  const Quantity(qty: 'Gm.'),
  const Quantity(qty: 'Ltr.')];

  Quantity Qty;

Widget listTileAddDish(BuildContext context,
    String Sno,
    String qty,
    String unit,
    bool req){
  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: SizeConfig.blockSizeVertical,
      horizontal: SizeConfig.screenWidth * 0.05
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
                Text(Sno),
                Container(
                  color: Color(0XFFFEE715),
                  height: SizeConfig.blockSizeVertical * 6,
                  width: SizeConfig.blockSizeHorizontal * 0.4,
                ),
                Text("Item Name",style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Color(0XFFFEE715),
                      ),
                  ),
                  alignment: Alignment.center,
                  width: SizeConfig.screenWidth * 0.2,
                  height: SizeConfig.blockSizeVertical * 3,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Qty.",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.blockSizeVertical * 1.25
                      ),
                      contentPadding: EdgeInsets.all(10),
                    ),
                    textAlign: TextAlign.center,
                    cursorHeight: SizeConfig.blockSizeVertical * 2,
                    cursorColor: Colors.black,

                  ),
                ),
                SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 2,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: Color(0XFFFEE715),
                          width: SizeConfig.blockSizeHorizontal * 0.4
                      )),
                  alignment: Alignment.center,
                  width: SizeConfig.screenWidth * 0.15,
                  height: SizeConfig.blockSizeVertical * 3,
                  child: Row(
                    children: [
                      Text(unit,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      Icon(Icons.arrow_drop_down,
                      color: Colors.black,
                      size: SizeConfig.blockSizeVertical * 2,)
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: req == true ?Color(0XFFFEE715):Colors.white,
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

class Quantity{
  const Quantity({this.qty});
  final String qty;
}