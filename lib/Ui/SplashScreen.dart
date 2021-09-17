import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/HomePage.dart';
import 'package:flutter_chef/Utils/BottomNavigation.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chef/Ui/AddDish.dart';

import 'Customer/HomePage.dart';
import 'Customer/SignUp.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.delayed(const Duration(seconds: 2), () {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => LoginScreen()),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/bg/splash screen bg.png'))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child:
                  Image(image: AssetImage('assets/icons/my dishes icon.png')),
                  height: SizeConfig.screenHeight * 0.1,
                  width: SizeConfig.screenWidth * 0.4,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 10),

                ),
                Container(
                  child: Text(
                    'CHEFS N COOKS',
                    style: TextStyle(),
                  ),
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 0.5),
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.7,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                  child: Text(
                    'Welcome To ChefsNcooks',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 2.5,
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.7,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                  child: Text(
                    'Here you will easily find a cook that will make your '
                        'favourite dish for you while you watch it live. You can pickup your meal'
                        'or arrange for someone you trust to do it for you.',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.blockSizeVertical * 2),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Container(
                  child: MaterialButton(
                    onPressed: () async {
                     // Navigator.of(context).pushNamed("/AskLogin");
                      SharedPreferences preferences =
                      await SharedPreferences.getInstance();

                      if (preferences.getString("token") == null&&preferences.getString("usertoken")==null) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CustomerSignUp()));
                      } else {
                        if (preferences.getString("login") == "/CustomerLogin") {
                          Navigator.pushReplacement(
                              context,

                              MaterialPageRoute(
                                  builder: (context) => CustomerHomePage()));
                        } else {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyBottomBarDemo()));
                        }
                      }
                    },
                    child: Text(
                      'Proceed',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    minWidth: SizeConfig.screenWidth * 0.6,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/buttons/proceed button .png'),
                    ),
                  ),
                  width: SizeConfig.screenWidth * 0.6,
                  height: SizeConfig.screenHeight * 0.1,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: SizeConfig.screenHeight * 0.05),
                )
              ],
            ),
          ),
        ));
  }
}
