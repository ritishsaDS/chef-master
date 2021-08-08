import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/AskLogin.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/ListTileOrders.dart';
import 'package:flutter_chef/Utils/NavigationBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chefsearch.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var search;
  @override
  void initState() {
    print("hasc;jklasc"+currencyyy);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.more_vert,color: Colors.black,),
        centerTitle: true,
        title: ImageIcon(
          AssetImage('assets/icons/my dishes icon.png'),
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
            child: IconButton(icon:Icon(Icons.logout,color:Colors.black),onPressed: () async {
              SharedPreferences prefs=await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AskLoginScreen()));
            },)
          ),
        ],
      ),
     // bottomNavigationBar: navBar(0,context),
      drawer: Drawer(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0XFFFEE715),
            height: SizeConfig.screenHeight * 0.1,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 2,
                horizontal: SizeConfig.blockSizeHorizontal * 5
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("June 10,2021",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeVertical * 1.50,
                      ),),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical,
                    ),
                    Text("Hi,Cook Name",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 2,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),)
                  ],
                ),
                Container(
                  height: SizeConfig.screenHeight * 0.1,
                  width: SizeConfig.screenWidth * 0.1,
                  child: Icon(Icons.menu_rounded,size: SizeConfig.blockSizeVertical * 4,
                    color: Colors.black,),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          ListTile(
            leading: Image.asset('assets/icons/my earnings icon.png',
              height: SizeConfig.blockSizeVertical * 4,),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
            title: Text("My Earnings",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
          ),
          ListTile(
            leading: Image.asset('assets/icons/orders icon.png',
              height: SizeConfig.blockSizeVertical * 4,),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
            title: Text("My Orders",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
          ),
          ListTile(
            leading: Image.asset('assets/icons/my dishes icon.png',
              height: SizeConfig.blockSizeVertical * 4,),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
            title: Text("My Dishes",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
          ),
          ListTile(
            leading: Image.asset('assets/icons/profile icon.png',
              height: SizeConfig.blockSizeVertical * 4,),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
            title: Text("My Profile",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
          ),
          ListTile(
            leading: Image.asset('assets/icons/logout icon.png',
              height: SizeConfig.blockSizeVertical * 4,),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
            title: Text("Logout",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
          ),
        ],
      ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(child: Text("My Videos",
          style: TextStyle(
            fontSize: SizeConfig.blockSizeVertical * 2,
            fontWeight: FontWeight.bold,
          ),),
          alignment: Alignment.center,
          padding: EdgeInsets.all(SizeConfig.blockSizeVertical),),
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.3,
              child: Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(
                  left: SizeConfig.blockSizeVertical * 2,

                  right: SizeConfig.blockSizeVertical * 2,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_circle_outline,size: 40,),
                    Text("Add A Video",style: TextStyle(fontSize: 18),)
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    width: SizeConfig.blockSizeHorizontal * 35,
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeVertical * 2
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:SizeConfig.screenWidth * 0.2,
                          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Sort By",
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
                          child: Align(child: Icon(Icons.keyboard_arrow_down,color: Colors.black,),
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
                    width: SizeConfig.blockSizeHorizontal * 35,
                    margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeVertical * 2
                    ),
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
                            onChanged: (value){
                              setState(() {
                                search=value;
                              });
                            },
                            cursorColor: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                           Navigator.push(context,MaterialPageRoute(builder: (context)=>chefsearch(sort:search)));
                          },
                          child: Container(
                            color: Color(0XFFFEE715),
                            width: SizeConfig.blockSizeHorizontal * 8,
                            height: SizeConfig.blockSizeVertical * 4,
                            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                            child: Align(child: Icon(Icons.search,color: Colors.black,),
                            alignment: Alignment.center,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Image.asset('assets/bg/left line.png',),

                  width: SizeConfig.screenWidth * 0.42,),
                  Text("Orders",style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 2,
                    fontWeight: FontWeight.bold
                  ),),
                  Container(
                    child: Image.asset('assets/bg/right line.png',),

                    width: SizeConfig.screenWidth * 0.42,),
                ],
              ),
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
              children: [
                listTileOrders(),
                // listTileOrders(),
                // listTileOrders(),
                // listTileOrders(),
                // listTileOrders(),
                // listTileOrders(),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
