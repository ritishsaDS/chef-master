import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

Widget cartListTile(
    BuildContext context,
    String cookName,
    String price,
    ){
  SizeConfig().init(context);
  return Container(
    margin: EdgeInsets.only(
      top: SizeConfig.blockSizeVertical * 2,
      left: SizeConfig.screenWidth * 0.02,
      right: SizeConfig.screenWidth * 0.02
    ),
    height: SizeConfig.blockSizeVertical * 10,
    width: SizeConfig.screenWidth,
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
    child: Stack(
      children: [
        ListTile(
          onTap: () {
            Navigator.of(context).pushNamed('/CustomerCartDetails');
          },
          title: Column(
            children: [
              Container(
                margin:EdgeInsets.only(
                  right: SizeConfig.blockSizeHorizontal * 8
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.edit,size: SizeConfig.blockSizeVertical * 2,),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 1,
                    ),
                    Image.asset('assets/icons/delete icon.png',
                      height: SizeConfig.blockSizeVertical * 2,)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Dish Name",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 1.5),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 8,
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
              Container(child: Divider(),
              margin: EdgeInsets.only(
                right: SizeConfig.blockSizeHorizontal * 20
              ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cook",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        cookName,
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
                    margin: EdgeInsets.only(
                      right: SizeConfig.blockSizeHorizontal * 20
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      color: Colors.red,
                      padding: EdgeInsets.zero,
                      child: Text("Buy Now",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0XFFFEE715),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              alignment: Alignment.center,
              width: SizeConfig.screenWidth * 0.1,
              height: SizeConfig.blockSizeVertical * 10,
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(Constants().currency+price),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
