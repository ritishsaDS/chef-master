import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

import 'browseguest.dart';

class AskLoginScreen extends StatefulWidget {
  @override
  _AskLoginScreenState createState() => _AskLoginScreenState();
}

class _AskLoginScreenState extends State<AskLoginScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
            body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: new DecorationImage(
              fit: BoxFit.fill, image: AssetImage('assets/bg/bg .png'))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image(image: AssetImage('assets/icons/my dishes icon.png')),
            height: SizeConfig.screenHeight * 0.1,
            width: SizeConfig.screenWidth * 0.4,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.2),
          ),
          Container(
            child: Text(
              'CHEFS N COOKS',
              style: TextStyle(),
            ),
            margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.15,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/Login');
            },
            child: Container(
              margin: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.02),
              padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.2,
                right: SizeConfig.screenWidth * 0.02,
              ),
              width: SizeConfig.screenWidth * 0.8,
              height: SizeConfig.screenHeight * 0.06,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      spreadRadius: 0.5,
                      offset: Offset.fromDirection(2, 1),
                    )
                  ],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Signin As A Cook',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 2,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/CustomerLogin');
            },
            child: Container(
              margin: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.02),
              padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.2,
                right: SizeConfig.screenWidth * 0.02,
              ),
              width: SizeConfig.screenWidth * 0.8,
              height: SizeConfig.screenHeight * 0.06,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      spreadRadius: 0.5,
                      offset: Offset.fromDirection(2, 1),
                    )
                  ],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Signin As A Customer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 2,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Browseguest()));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: SizeConfig.screenHeight * 0.01),
              padding: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.2,
                right: SizeConfig.screenWidth * 0.02,
              ),
              width: SizeConfig.screenWidth * 0.8,
              height: SizeConfig.screenHeight * 0.06,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      spreadRadius: 0.5,
                      offset: Offset.fromDirection(2, 1),
                    )
                  ],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Browse As A Guest',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 2,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
