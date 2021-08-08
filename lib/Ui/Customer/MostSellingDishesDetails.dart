import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/listTileMostSellingDishesDetails.dart';

class MostSellingDishesDetails extends StatefulWidget {
  dynamic name;
  dynamic image;
  dynamic chefname;
  dynamic time;
  dynamic price;
   MostSellingDishesDetails({this.chefname,this.image,this.name,this.price,this.time}) ;


  @override
  _MostSellingDishesDetailsState createState() => _MostSellingDishesDetailsState();
}

class _MostSellingDishesDetailsState extends State<MostSellingDishesDetails> {
  bool addWidget = false;
  bool addWidget1 = true;
  TextEditingController instructionsController = TextEditingController();
  @override

  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: customerNavBar(0, context),
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
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(SizeConfig.screenWidth, 150),
              ),
              image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.cover
              )
            ),
            child: Column(
              children: [
                AppBar(
                  backgroundColor: Colors.white30,
                  title: Text(widget.name,
                  style: TextStyle( fontWeight: FontWeight.bold,
                      color: Colors.white),),
                  centerTitle: true,
                ),
              ],
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
                  Text("Cook \n${widget.chefname}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: SizeConfig.blockSizeVertical * 1.50
                  ),),
                  Text("Time\n${widget.time}",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: SizeConfig.blockSizeVertical * 1.50
                  ),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Image.asset('assets/bg/left line.png',),
                    width: SizeConfig.screenWidth * 0.35,),
                  Text("${widget.name}",style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      fontWeight: FontWeight.bold
                  ),),
                  Container(
                    child: Image.asset('assets/bg/right line.png',),
                    width: SizeConfig.screenWidth * 0.35,),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.1,
                top: SizeConfig.blockSizeVertical * 2
              ),
              width: SizeConfig.screenWidth,
              alignment: Alignment.centerLeft,
              child: Text("Ingredients",style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey
              ),),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
              children: [
                listTileMostSellingDishDetail(context," 2 Kg.","1"),
                listTileMostSellingDishDetail(context," 200 Gm.","2"),
                listTileMostSellingDishDetail(context," 1 Kg.","3"),
                listTileMostSellingDishDetail(context," 2 Kg.","4")
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.1,
                  top: SizeConfig.blockSizeVertical * 2
              ),
              width: SizeConfig.screenWidth,
              alignment: Alignment.centerLeft,
              child: Text("Additional Ingredients",style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
              ),),
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical,
                right: SizeConfig.screenWidth * 0.05,
                left: SizeConfig.screenWidth * 0.05,
              ),
              width: SizeConfig.screenWidth,
              child: Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                runSpacing: 5,
                children:[
                  Container(
                    width: SizeConfig.screenWidth * 0.28,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.01,
                      right: SizeConfig.screenWidth * 0.01,
                    ),
                    child: MaterialButton(onPressed: (){},
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: Colors.white,
                      child: Text("Item Name",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 1.50
                      ),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.28,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.01,
                      right: SizeConfig.screenWidth * 0.01,
                    ),
                    child: MaterialButton(onPressed: (){},
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: Colors.white,
                      child: Text("Item Name",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeVertical * 1.50
                      ),),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.28,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.01,
                      right: SizeConfig.screenWidth * 0.01,
                    ),
                    child: MaterialButton(onPressed: (){
                      setState(() {
                        addWidget = true;
                        //todo: implement add item button
                      });
                    },
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      color: Colors.white,
                      child: Icon(
                        Icons.add_circle,color: Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )

                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
                top: SizeConfig.blockSizeVertical * 2,
              ),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[400],
                        blurRadius: 2,
                        spreadRadius: 01,
                        offset: Offset(1,1)
                    ),
                  ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin:EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.05,
                        right: SizeConfig.screenWidth * 0.05,
                        top: SizeConfig.blockSizeVertical,
                        bottom: SizeConfig.blockSizeVertical
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Additional Instructions to Cook",style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: SizeConfig.blockSizeVertical,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.grey[400],
                              width: 1.0
                            )
                          ),
                          child: TextField(
                            controller: instructionsController,
                            maxLines: 2,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter Instructions",
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                left: 5
                              )
                            ),
                          ),
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
                            Text("Delivery Mode",style: TextStyle(
                                color: Colors.grey,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical,
                            ),
                            Text("Designated Pickup",style: TextStyle(
                                color: Colors.black
                            ),),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Store Cooking Video",style: TextStyle(
                                color: Colors.grey,
                              fontWeight: FontWeight.bold
                            ),),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical,
                            ),
                            Text("Yes",style: TextStyle(
                                color: Colors.black
                            ),)
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
                        bottom: SizeConfig.blockSizeVertical
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Color(0XFFFEE715)
                        ),
                        boxShadow: [BoxShadow(
                          color: Colors.grey[400],
                          blurRadius: 0.5,
                          spreadRadius: 0.3,
                          offset: Offset(1,1),
                        )]
                    ),
                    width: SizeConfig.screenWidth * 0.5,
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal,
                      right: SizeConfig.blockSizeHorizontal,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage('https://www.persofoto.com/images/vorher-nachher/passfoto-beispiel-vorher.jpg'),
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
                  left: SizeConfig.screenWidth * 0.1,
                  top: SizeConfig.blockSizeVertical * 3
              ),
              child: Text("Cook's Comment",style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),),
              alignment: Alignment.centerLeft,
            ),
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical
              ),
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeVertical * 4,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 5
              ),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                      color: Color(0XFFFEE715),
                      width: 1.0
                  ),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: Text("Show comments here"),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Color(0XFFFEE715),
                      width: 1.0
                  ),
                  shape: BoxShape.rectangle
              ),
              margin: EdgeInsets.only(
                  right: SizeConfig.screenWidth * 0.05,
                  left: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical * 2
              ),
              height: SizeConfig.blockSizeVertical * 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(onPressed: (){},
                    child: Text("Price:"+Constants().currency+" ${widget.price}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),),
                  VerticalDivider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                  Row(
                    children: [
                      Text("Tip: "+Constants().currency,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      Container(
                        width: SizeConfig.screenWidth * 0.1,
                          margin: EdgeInsets.only(
                            bottom: SizeConfig.blockSizeVertical * 0.1
                          ),
                          child: TextField(
                            cursorColor: Colors.grey[400],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                left: 8
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey[400]
                                )
                              ),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[400]
                                  )
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[400]
                                  )
                              ),
                              disabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[400]
                                  )
                              ),
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical * 2
              ),
              child: MaterialButton(onPressed: (){
                Navigator.of(context).pushNamed('/Cart');
              },
                color: Color(0XFFFEE715),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: SizeConfig.screenWidth,
                child: Text("Add To Cart",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),),
            )

          ],
        ),
      ),

    ));
  }
}
