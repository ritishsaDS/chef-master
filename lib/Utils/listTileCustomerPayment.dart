import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

Widget listTileCustomerPayment(
    BuildContext context,
    String subtitle1,
    String subtitle2,
    String amount,
    String icon,
    Color color,
    ){
  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.only(
      top: SizeConfig.blockSizeVertical * 2,
    ),
    decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
            blurRadius: 1.2,
            spreadRadius: 0.5,
            offset: Offset(1, 1),
          ),
        ]),
    //  height: SizeConfig.blockSizeVertical * 9,
    child: ListTile(
      onTap: () {
      },
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dish Name",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 2),
              ),
              Row(
                children: [
                  Container(
                    margin:
                    EdgeInsets.only(right: SizeConfig.blockSizeHorizontal),
                    child: Text("28/03/2021",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: SizeConfig.blockSizeVertical * 1.25
                    ),)
                  ),
                  Container(
                    margin:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                    child: Text("11:30 AM",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: SizeConfig.blockSizeVertical * 1.25
                      ),)
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subtitle1,
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    subtitle2,
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                height: SizeConfig.blockSizeVertical * 2.5,
                width: SizeConfig.blockSizeHorizontal * 23,
                child: MaterialButton(
                  onPressed: () {},
                  color: color,
                  child: Text(icon+"\t"+Constants().currency+amount,
                    style:
                    TextStyle(fontSize: SizeConfig.blockSizeVertical * 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3)),
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.black,
      ),
      leading: Container(
        width: SizeConfig.blockSizeHorizontal * 12,
        height: SizeConfig.blockSizeVertical * 6,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(5),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            'https://i.pinimg.com/originals/31/ac/7d/31ac7d17b45a6b900090f8a237baa7e4.jpg',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}