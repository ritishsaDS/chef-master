import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/Customer/HomePage.dart';
import 'package:flutter_chef/Ui/HomePage.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
class Browseguest extends StatefulWidget {
  @override
  _BrowseguestState createState() => _BrowseguestState();
}

class _BrowseguestState extends State<Browseguest> {
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
                    onTap: () async {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => HomePage()));
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
                            'Browse As A Cook',
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
                    onTap: () async {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => CustomerHomePage()));
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
                            'Browse As A Customer',
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
