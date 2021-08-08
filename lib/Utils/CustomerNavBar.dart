import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/Customer/Cust_Cart.dart';

Widget customerNavBar(int index, BuildContext context) {
  return CurvedNavigationBar(
    index: index,
    height: 50.0,
    items: <Widget>[
      InkWell(
        child: ImageIcon(AssetImage('assets/icons/home icon.png')),
        onTap: () {
          Navigator.of(context).pushNamed('/CustomerHomePage');
        },
      ),
      InkWell(
        child: ImageIcon(AssetImage('assets/icons/cart icon.png')),
        onTap: () {
          Navigator.of(context).pushNamed('/Cart');
        },
      ),
      InkWell(
        child: ImageIcon(AssetImage('assets/icons/orders icon.png')),
        onTap: () {
          Navigator.of(context).pushNamed('/CustomerOrders');
        },
      ),
      InkWell(
        child: ImageIcon(AssetImage('assets/icons/wallet icon.png')),
        onTap: () {
          Navigator.of(context).pushNamed('/Wallet');
        },
      ),
      InkWell(child: ImageIcon(AssetImage('assets/icons/profile icon.png')),
        onTap: (){
          Navigator.of(context).pushNamed('/CustomerProfile');
        },),


    ],
    
    color: Color(0XFFfee715),
    buttonBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    animationCurve: Curves.easeInOut,
    animationDuration: Duration(milliseconds: 600),
    onTap: (int i) {},
    letIndexChange: (index) => true,
  );
}
