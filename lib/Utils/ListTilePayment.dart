import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

Widget listTilePayment(BuildContext context){
  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.only(
      top: SizeConfig.blockSizeVertical * 1.5,
    ),
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
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
    height: SizeConfig.blockSizeVertical * 9,
    child: ListTile(
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dish Name",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 2
              ),),
              Text("28/03/2021 \t 11:30 AM",style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical,
                color: Colors.grey,
              ) ,)
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Order By \nClient Name",style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical,
                color: Colors.grey,
              ) ,),
              Container(
                height: SizeConfig.blockSizeVertical * 2.5,
                width: SizeConfig.blockSizeHorizontal * 20,
                child: MaterialButton(onPressed: (){},
                  color: Color(0XFFFEE715),
                  child: Text(Constants().currency+"200",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 1.5
                    ),),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)
                  ),),
              ),
            ],
          ),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
      leading: Container(
        width: SizeConfig.blockSizeHorizontal * 12,
        height: SizeConfig.blockSizeVertical * 6,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network('https://i.pinimg.com/originals/31/ac/7d/31ac7d17b45a6b900090f8a237baa7e4.jpg',fit: BoxFit.cover,),
        ),
      ),
    ),
  );
}