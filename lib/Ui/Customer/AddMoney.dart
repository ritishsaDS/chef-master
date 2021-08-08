import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/AddMoneyCard.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({Key key}) : super(key: key);

  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
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
                    backgroundColor: Colors.transparent,
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
                  Container(
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
                    "Add Money",
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
             width: SizeConfig.screenWidth,
             margin: EdgeInsets.only(
               top: SizeConfig.blockSizeVertical * 4,
               left: SizeConfig.screenWidth * 0.02,
               right: SizeConfig.screenWidth * 0.02
             ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Container(
                   width: SizeConfig.screenWidth,
                   alignment: Alignment.center,
                   child: Text("Saved Card",style: TextStyle(
                     color: Colors.black,
                     fontWeight: FontWeight.bold,
                   ),),
                 ),
                 Container(
                   width: SizeConfig.screenWidth,
                   alignment: Alignment.center,
                   margin: EdgeInsets.only(
                     left: SizeConfig.screenWidth * 0.1,
                     right: SizeConfig.screenWidth * 0.1
                   ),
                   child: Divider(
                     color: Colors.grey,
                   ),
                 ),
                 Stack(
                   children: [
                     Container(
                       width: SizeConfig.screenWidth,
                       height: SizeConfig.screenHeight * 0.25,
                       child: ListView(
                         shrinkWrap: true,
                         primary: false,
                         physics: BouncingScrollPhysics(),
                         scrollDirection: Axis.horizontal,
                         children: [
                           cardAddMoney(context,"1200\t\t\t4505\t\t\t7856\t\t\t6100","03/2024","Card Holder Name"),
                           cardAddMoney(context,"1200\t\t\t4505\t\t\t7856\t\t\t6100","03/2024","Card Holder Name"),
                           cardAddMoney(context,"1200\t\t\t4505\t\t\t7856\t\t\t6100","03/2024","Card Holder Name"),
                           cardAddMoney(context,"1200 \t\t\t4505\t\t\t7856\t\t\t6100","03/2024","Card Holder Name"),


                         ],
                       ),
                     ),
                     Container(
                       width: SizeConfig.screenWidth,
                       height: SizeConfig.screenHeight * 0.25,
                       alignment: Alignment.center,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Icon(Icons.arrow_back_ios_rounded,color: Colors.black,),
                           Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,)
                         ],
                       ),
                     ),
                   ],
                 ),
                 Container(
                   width: SizeConfig.screenWidth,
                   alignment: Alignment.center,
                   margin: EdgeInsets.only(
                       left: SizeConfig.screenWidth * 0.1,
                       right: SizeConfig.screenWidth * 0.1
                   ),
                   child: Divider(
                     color: Colors.grey,
                   ),
                 ),
                 Container(
                   width: SizeConfig.screenWidth,
                   alignment: Alignment.center,
                   child: Text("Others",
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                   ),),
                 ),
                 Container(
                   margin: EdgeInsets.symmetric(
                     horizontal: SizeConfig.screenWidth * 0.05,
                     vertical: SizeConfig.blockSizeVertical
                   ),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(10),
                     shape: BoxShape.rectangle,
                     boxShadow: [
                       BoxShadow(
                         color: Colors.grey[300],
                         offset: Offset(1,1),
                         spreadRadius: 0.9,
                         blurRadius: 1
                       ),
                     ]
                   ),
                   child: ListTile(
                     onTap: (){
                       Navigator.of(context).pushNamed('/AddCard');
                     },
                     dense: true,
                     title: Text("Debit Card/Credit Card"),
                     trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.symmetric(
                       horizontal: SizeConfig.screenWidth * 0.05,
                       vertical: SizeConfig.blockSizeVertical
                   ),
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                       shape: BoxShape.rectangle,
                       boxShadow: [
                         BoxShadow(
                             color: Colors.grey[300],
                             offset: Offset(1,1),
                             spreadRadius: 0.9,
                             blurRadius: 1
                         ),
                       ]
                   ),
                   child: ListTile(
                     dense: true,
                     title: Text("Net Banking"),
                     trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
                   ),
                 ),
                 Container(
                   margin: EdgeInsets.symmetric(
                       horizontal: SizeConfig.screenWidth * 0.05,
                       vertical: SizeConfig.blockSizeVertical
                   ),
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(10),
                       shape: BoxShape.rectangle,
                       boxShadow: [
                         BoxShadow(
                             color: Colors.grey[300],
                             offset: Offset(1,1),
                             spreadRadius: 0.9,
                             blurRadius: 1
                         ),
                       ]
                   ),
                   child: ListTile(
                     dense: true,
                     title: Text("UPI Payment"),
                     trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
                   ),
                 ),
               ],
             ),
           ),
          ],
        ),
      ),
    ));
  }
}
