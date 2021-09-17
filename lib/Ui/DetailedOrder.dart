import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/ListTileIngredients.dart';
import 'package:flutter_chef/Utils/NavigationBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/ListTileDetailOrder.dart';

class DetailedOrder extends StatefulWidget {
  const DetailedOrder({Key key}) : super(key: key);

  @override
  _DetailedOrderState createState() => _DetailedOrderState();
}

class _DetailedOrderState extends State<DetailedOrder> {
  bool breakfast = false;
  bool lunch = false;
  bool dinner = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
    //  bottomNavigationBar: navBar(0),
      appBar: AppBar(
        backgroundColor: Color(0XFFFEE715),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          "Orders",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg/top bg orders .png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cook\nCook Name",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.blockSizeVertical * 1.5),
                  ),
                  Text(
                    "\tTime\n30 Min.",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.blockSizeVertical * 1.5),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/bg/left line.png',
                    ),
                    margin: EdgeInsets.only(
                      right: SizeConfig.blockSizeHorizontal,
                    ),
                    width: SizeConfig.screenWidth * 0.35,
                  ),
                  Text(
                    "Ingredients",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/bg/right line.png',
                    ),
                    margin: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal,
                    ),
                    width: SizeConfig.screenWidth * 0.35,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical),
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    minWidth: SizeConfig.screenWidth * 0.28,
                    height: SizeConfig.blockSizeVertical * 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: breakfast == true ? Color(0XFFfee715) : Colors.white,
                    onPressed: () {
                      setState(() {
                        lunch = false;
                        breakfast = true;
                        dinner = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Image.asset('assets/icons/breakfast icon.png'),

                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal,
                        ),
                        Text(
                          "Ingredients",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                              fontWeight: breakfast == true
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: SizeConfig.screenWidth * 0.28,
                    height: SizeConfig.blockSizeVertical * 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: lunch == true ? Color(0XFFfee715) : Colors.white,
                    onPressed: () {
                      setState(() {
                        lunch = true;
                        breakfast = false;
                        dinner = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Image.asset('assets/icons/breakfast icon.png'),

                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal,
                        ),
                        Text(
                          "Live Chat",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                              fontWeight: lunch == true
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: SizeConfig.screenWidth * 0.28,
                    height: SizeConfig.blockSizeVertical * 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: dinner == true ? Color(0XFFfee715) : Colors.white,
                    onPressed: () {
                      setState(() {
                        dinner = true;
                        breakfast = false;
                        lunch = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Image.asset('assets/icons/breakfast icon.png'),

                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal,
                        ),
                        Text(
                          "Description",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                              fontWeight: dinner == true
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
              children: [
                listTileDetailOrder(context, " 2 Kg.", "1"),
                listTileDetailOrder(context, " 200 Gm.", "2"),
                listTileDetailOrder(context, " 1 Kg.", "3"),
                listTileDetailOrder(context, " 2 Kg.", "4")
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.white,
                    child: Text(
                      "Item Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.white,
                    child: Text(
                      "Item Name",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.white,
                    child: Icon(
                      Icons.add_circle,
                      color: Colors.black,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
                top: SizeConfig.blockSizeVertical,
              ),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 0.5,
                        spreadRadius: 0.2,
                        offset: Offset(1, 1)),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.05,
                        right: SizeConfig.screenWidth * 0.05,
                        top: SizeConfig.blockSizeVertical,
                        bottom: SizeConfig.blockSizeVertical),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Additional Instructions to Cook",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical,
                        ),
                        Text(
                          "Lorem Ipsum is simply dummy text of the printing"
                          " and typesetting industry. Lorem Ipsum has been "
                          "the industry's standard dummy text ever since the"
                          " 1500s, when an unknown printer took a galley of "
                          "type and scrambled it to make a type specimen book.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 1.5),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0XFFFEE715),
                    thickness: 1.0,
                    height: SizeConfig.blockSizeVertical * 4,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Delivery Mode",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical,
                            ),
                            Text(
                              "Designated Pickup",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Store Cooking Video",
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical,
                            ),
                            Text(
                              "Yes",
                              style: TextStyle(color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.05,
                        right: SizeConfig.screenWidth * 0.05,
                        top: SizeConfig.blockSizeVertical * 2,
                        bottom: SizeConfig.blockSizeVertical),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Color(0XFFFEE715)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.5,
                            spreadRadius: 0.3,
                            offset: Offset(1, 1),
                          )
                        ]),
                    width: SizeConfig.screenWidth * 0.5,
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal,
                      right: SizeConfig.blockSizeHorizontal,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://www.persofoto.com/images/vorher-nachher/passfoto-beispiel-vorher.jpg'),
                        ),
                        Text("Designated Name")
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical * 3),
              child: Text(
                "Cook's Comment",
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Color(0XFFFEE715), width: 1.0),
                  borderRadius: BorderRadius.circular(20)),
              child: TextFormField(
                decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: "Enter your comments here",
                    contentPadding:
                        EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeVertical * 1.5,
                    )),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0XFFFEE715), width: 1.0),
                  shape: BoxShape.rectangle),
              margin: EdgeInsets.only(
                  right: SizeConfig.screenWidth * 0.05,
                  left: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical * 2),
              height: SizeConfig.blockSizeVertical * 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {},
                    child: Text("Price:"+Constants().currency+"200"),
                  ),
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text("Tip:"+Constants().currency+" 50"),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical * 2),
              child: MaterialButton(
                onPressed: () {},
                color: Color(0XFFFEE715),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: SizeConfig.screenWidth,
                child: Text("Ready To Live"),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
