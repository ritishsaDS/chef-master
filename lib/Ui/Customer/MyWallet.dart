import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/Cutomerdrawer.dart';
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
      drawer: Customerdrawer(),
      bottomNavigationBar: Customerbottom(index:3),
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
