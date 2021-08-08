import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/NavigationBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/ListTilePayment.dart';

class MyEarnings extends StatefulWidget {
  const MyEarnings({Key key}) : super(key: key);

  @override
  _MyEarningsState createState() => _MyEarningsState();
}

class _MyEarningsState extends State<MyEarnings> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
    body: SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg/earnings top bg.png'),
                fit: BoxFit.cover,
              )),
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppBar(
                  backgroundColor: Color(0XFFFFe715),
                  elevation: 0.0,
                  centerTitle: true,
                  title: Text("My Earning",style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 2.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.black
                  ),),
                  iconTheme: IconThemeData(
                    color: Colors.black
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text("Total Earning",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 1.5
                      ),),
                      Text(Constants().currency+"  2000",
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 3
                      ),),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("Today",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 1.5
                          ),),
                          Text(Constants().currency+" 400",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      Column(
                        children: [
                          Text("This Week",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 1.5
                          ),),
                          Text(Constants().currency+" 400",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2,
                              fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      Column(
                        children: [
                          Text("This Month",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 1.5
                          ),),
                          Text(Constants().currency+" 400",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 2,
                                fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 4
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0XFFFEE715),
                          width: 1.5
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  height: SizeConfig.blockSizeVertical * 4,
                  width: SizeConfig.blockSizeHorizontal * 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width:SizeConfig.screenWidth * 0.2,
                        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "All Payments",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                            ),
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
                      Container(
                        color: Color(0XFFFEE715),
                        width: SizeConfig.blockSizeHorizontal * 8,
                        height: SizeConfig.blockSizeVertical * 4,
                        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                        child: Align(child: Icon(Icons.keyboard_arrow_down_sharp,color: Colors.black,),
                          alignment: Alignment.center,),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0XFFFEE715),
                          width: 1.5
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  height: SizeConfig.blockSizeVertical * 4,
                  width: SizeConfig.blockSizeHorizontal * 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width:SizeConfig.screenWidth * 0.2,
                        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                            ),
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
                      Container(
                        color: Color(0XFFFEE715),
                        width: SizeConfig.blockSizeHorizontal * 8,
                        height: SizeConfig.blockSizeVertical * 4,
                        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                        child: Align(child: Icon(Icons.search,color: Colors.black,),
                          alignment: Alignment.center,),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: Color(0XFFFEE715),
                          width: 1.5
                      ),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  height: SizeConfig.blockSizeVertical * 4,
                  width: SizeConfig.blockSizeHorizontal * 30,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width:SizeConfig.screenWidth * 0.2,
                        padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Feb 2020",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                            ),
                          ),
                          cursorColor: Colors.black,
                        ),
                      ),
                      Container(
                        color: Color(0XFFFEE715),
                        width: SizeConfig.blockSizeHorizontal * 8,
                        height: SizeConfig.blockSizeVertical * 4,
                        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                        child: Align(child: Icon(Icons.date_range_rounded,color: Colors.black,),
                          alignment: Alignment.center,),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical * 1.5
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Image.asset('assets/bg/left line.png',),
                  margin: EdgeInsets.only(
                    right: SizeConfig.blockSizeHorizontal,
                  ),
                  width: SizeConfig.screenWidth * 0.35,),
                Text("Payments",style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 2,
                    fontWeight: FontWeight.bold
                ),),
                Container(
                  child: Image.asset('assets/bg/right line.png',),
                  margin: EdgeInsets.only(
                    left: SizeConfig.blockSizeHorizontal,
                  ),
                  width: SizeConfig.screenWidth * 0.35,),
              ],
            ),
          ),
          ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              listTilePayment(context),
              listTilePayment(context),
              listTilePayment(context),
              listTilePayment(context),
              listTilePayment(context),
            ],
          ),
        ],
      ),
    ),
     // bottomNavigationBar: navBar(3, context),
    ));
    
  }
}
