import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/listTileCustomerPayment.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({Key key}) : super(key: key);

  @override
  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
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
                        "Hi,Client Name",
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
              onTap: (){
                Navigator.of(context).pushNamed('/Cart');
              },
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
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushNamed('/CustomerOrders');
              },
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
            ),
            ListTile(
              onTap: (){
                Navigator.of(context).pushNamed('/Wallet');
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
            ListTile(
              onTap: (){
                Navigator.of(context).pushNamed('/CustomerProfile');
              },
              leading: Image.asset(
                'assets/icons/profile icon.png',
                height: SizeConfig.blockSizeVertical * 4,
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.black,
              ),
              title: Text(
                "My Profile",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.favorite_sharp,
                color: Colors.black,
                size: SizeConfig.blockSizeVertical * 4,
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
              onTap: (){
                Navigator.of(context).popAndPushNamed('/CustomerLogin');
              },
              leading: Image.asset(
                'assets/icons/logout icon.png',
                height: SizeConfig.blockSizeVertical * 4,
              ),
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
      ),
      bottomNavigationBar: customerNavBar(3, context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg/top bg wallet.png'),
                  fit: BoxFit.cover
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppBar(
                    title: Text("Wallet",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),),
                    centerTitle: true,
                    backgroundColor: Color(0xfffee715),
                    elevation: 0.0,
                    iconTheme: IconThemeData(
                        color: Colors.black
                    ),
                  ),
                  Text("Available Balance"),
                  Text(Constants().currency+" 1000",
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 4
                  ),),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 2,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.of(context).pushNamed('/AddMoney');
                    },
                    child: Container(
                      width: SizeConfig.screenWidth * 0.3,
                      height: SizeConfig.blockSizeVertical * 3.5,
                      alignment: Alignment.center,
                      child: Text("Add Money",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black
                        ),
                        borderRadius: BorderRadius.circular(5)
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: Color(0XFFFEE715), width: 1.5),
                        borderRadius: BorderRadius.circular(5)),
                    height: SizeConfig.blockSizeVertical * 4,
                    width: SizeConfig.blockSizeHorizontal * 35,
                    margin:
                    EdgeInsets.only(left: SizeConfig.blockSizeVertical * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.25,
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal),
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
                          padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                          child: Align(
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                        Border.all(color: Color(0XFFFEE715), width: 1.5),
                        borderRadius: BorderRadius.circular(5)),
                    height: SizeConfig.blockSizeVertical * 4,
                    width: SizeConfig.blockSizeHorizontal * 35,
                    margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeVertical * 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: SizeConfig.screenWidth * 0.2,
                          padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal),
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
                          padding:
                          EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                          child: Align(
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            alignment: Alignment.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/bg/left line.png',
                    ),
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical,
                      right: SizeConfig.blockSizeHorizontal,
                    ),
                    width: SizeConfig.screenWidth * 0.35,
                  ),
                  Text(
                    "Payments",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/bg/right line.png',
                    ),
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical,
                      left: SizeConfig.blockSizeHorizontal,
                    ),
                    width: SizeConfig.screenWidth * 0.35,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 2,
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
              ),
              child:  ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  listTileCustomerPayment(context,
                  "Payment",
                  "UPI Transfer",
                  "200",
                  "-",
                  Colors.red),
                  listTileCustomerPayment(context,
                      "Payment",
                      "Wallet",
                      "200",
                      "-",
                      Colors.red),
                  listTileCustomerPayment(context,
                      "Card",
                      "Card Number",
                      "1400",
                      "+",
                      Colors.green),
                  listTileCustomerPayment(context,
                      "Payment",
                      "Net Banking",
                      "200",
                      "-",
                      Colors.red),
                  listTileCustomerPayment(context,
                      "Payment",
                      "Debit Card",
                      "200",
                      "-",
                      Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
