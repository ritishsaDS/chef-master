import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/Customer/Cust_Cart.dart';
import 'package:flutter_chef/Ui/Customer/Cust_orders.dart';
import 'package:flutter_chef/Ui/Customer/Login.dart';
import 'package:flutter_chef/Ui/Customer/MyWallet.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'SizeConfig.dart';

class Customerdrawer extends StatefulWidget{
  @override
  _CustomerdrawerState createState() => _CustomerdrawerState();
}

class _CustomerdrawerState extends State<Customerdrawer> {
  var name;
 void  initState(){
   getname();
 }
 Future<void> getname() async {
   SharedPreferences prefs=await SharedPreferences.getInstance();
  name= prefs.getString("Name");
 }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0XFFFEE715),
            height: SizeConfig.screenHeight * 0.1,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 2,
                horizontal: SizeConfig.blockSizeHorizontal * 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "June 10,2021",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeVertical * 1.50,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical,
                    ),
                    Text(
                      "Hi,${name.toString()}",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 2,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Container(
                  height: SizeConfig.screenHeight * 0.1,
                  width: SizeConfig.screenWidth * 0.1,
                  child: Icon(
                    Icons.menu_rounded,
                    size: SizeConfig.blockSizeVertical * 4,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          ListTile(
            leading: Image.asset(
              'assets/icons/cart icon.png',
              height: SizeConfig.blockSizeVertical * 4,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
            ),
            title: Text(
              "My Cart",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Cart()));
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/icons/orders icon.png',
              height: SizeConfig.blockSizeVertical * 4,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
            ),
            title: Text(
              "My Orders",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerOrders()));
            },
          ),
          ListTile(

            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyWallet()));
            },
            leading: Image.asset(
              'assets/icons/wallet icon.png',
              height: SizeConfig.blockSizeVertical * 4,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
            ),
            title: Text(
              "My Wallet",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          // ListTile(
          //   leading: Image.asset(
          //     'assets/icons/icon.png',
          //     height: SizeConfig.blockSizeVertical * 4,
          //   ),
          //   trailing: Icon(
          //     Icons.arrow_forward_ios_rounded,
          //     color: Colors.black,
          //   ),
          //   title: Text(
          //     "My cookfromserver",
          //     style: TextStyle(fontWeight: FontWeight.bold),
          //   ),
          // ),
          ListTile(
            leading: Image.asset(
              'assets/icons/heart.png',
              height: SizeConfig.blockSizeVertical * 4,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
            ),
            title: Text(
              "My Favourite",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pushNamed('/MyFavourite');
            },
          ),
          ListTile(
            leading: Image.asset(
              'assets/icons/logout icon.png',
              height: SizeConfig.blockSizeVertical * 4,
            ),
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
            },
            trailing: Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.black,
            ),
            title: Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}