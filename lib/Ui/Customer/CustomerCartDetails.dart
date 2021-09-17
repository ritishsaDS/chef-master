import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/listTileMostSellingDishesDetails.dart';

class CustomerCartDetails extends StatefulWidget {
  const CustomerCartDetails({Key key}) : super(key: key);

  @override
  _CustomerCartDetailsState createState() => _CustomerCartDetailsState();
}

class _CustomerCartDetailsState extends State<CustomerCartDetails> {

  TextEditingController instructionsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Customerbottom(index:1),
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
                      image: NetworkImage('https://media.istockphoto.com/photos/chicken-fajita-wrap-sandwich-sandwich-with-fajita-chicken-roll-with-picture-id1180092933?k=6&m=1180092933&s=612x612&w=0&h=UlJ0Px6VloEGgPgD8LS2NsPwNoHhq6P6NRT76bVISZ0='),
                      fit: BoxFit.cover
                  )
              ),
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.white30,
                    centerTitle: true,
                    elevation: 0.0,
                    title: Text("My Cart",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),),
                  )
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
                  Text("Cook \nCook Name",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.blockSizeVertical * 1.50
                    ),),
                  Text("Time\n30 Min.",
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
                  Text("Dish Name",style: TextStyle(
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
                listTileMostSellingDishDetail(context,""," 2 Kg.","1"),
                listTileMostSellingDishDetail(context,""," 200 Gm.","2"),
                listTileMostSellingDishDetail(context,""," 1 Kg.","3"),
                listTileMostSellingDishDetail(context,""," 2 Kg.","4")
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
                        //addWidget = true;
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
                            InkWell(
                              onTap: (){
                              showDialog(context: context,
                                  builder: (BuildContext context){
                                return CustomDialog();
                                  });
                              },
                              child: Row(
                                children: [
                                  Text("Designated Pickup",style: TextStyle(
                                      color: Colors.black,
                                    fontSize: SizeConfig.blockSizeVertical * 1.50,
                                    fontWeight: FontWeight.bold
                                  ),),
                                  Icon(Icons.arrow_drop_down,
                                  color: Color(0XFFFEE715),),
                                ],
                              ),
                            ),
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
                                color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: SizeConfig.blockSizeVertical * 1.50
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
                    child: Text("Price:"+Constants().currency+" 200",
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
                Navigator.of(context).pushNamed('/CustomerPayment');
              },
                color: Color(0XFFFEE715),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minWidth: SizeConfig.screenWidth,
                child: Text("Save Changes",
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

class CustomDialog extends StatefulWidget {
  const CustomDialog({Key key}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {

  DesignatedPickups designatedPickups;

  List<DesignatedPickups> pickups = <DesignatedPickups>[const DesignatedPickups(
    pickup: "Pick Up 1",),
    const DesignatedPickups(pickup: "Pick Up 2"),
    const DesignatedPickups(pickup: "Pick Up 3")];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.only(
        left: SizeConfig.screenWidth * 0.01,
        right: SizeConfig.screenWidth * 0.01,
        top: SizeConfig.screenHeight * 0.15,
        bottom: SizeConfig.screenHeight * 0.05,
      ),
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0XFFFEE715),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: SizeConfig.screenWidth,
                height: SizeConfig.blockSizeVertical * 7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 5,
                    ),
                    Text("Designated Pickup",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.blockSizeVertical * 2
                      ),),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image.asset('assets/icons/wrong.png',
                        width: SizeConfig.blockSizeHorizontal * 5,),
                    )
                  ],
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                child: Text("Select Existing Designated Pickup",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                  ),),
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 5
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            offset: Offset(0,1),
                            spreadRadius: 1.2,
                            blurRadius: 0.5
                        )]),
                  width: SizeConfig.screenWidth * 0.5,
                  height: SizeConfig.blockSizeVertical * 5,
                  child: DropdownButtonFormField<DesignatedPickups>(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10)
                    ),
                    hint: Text("Select Pickup",
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 1.5,
                      ),),
                    value: designatedPickups,
                    onChanged: (DesignatedPickups pickup){
                      setState(() {
                        designatedPickups = pickup;
                      });
                    },
                    items:
                      pickups.map((DesignatedPickups pickup){
                        return DropdownMenuItem<DesignatedPickups>(
                          value: pickup,
                            child: Text(pickup.pickup,style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5
                            ),
                              textAlign: TextAlign.center,));
                      }).toList(),
                  ),
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                child: Divider(
                  color: Colors.grey[300],
                  thickness: 2.0,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.screenWidth * 0.05,
                  vertical: SizeConfig.blockSizeVertical * 3
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                child: Text("Create New Designated Pickup",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                  ),),
              ),
              Container(
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                child: Text("Upload Passport-Sized Picture Of Designated Pickup",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 1.50
                  ),),
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 1.5
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                child: MaterialButton(
                  color: Colors.white,
                  onPressed: (){},
                  minWidth: SizeConfig.screenWidth * 0.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Choose File",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                child: Text("No File Choosen",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 0.5
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                child: Text("Name Of Designated Pickup",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 1.75
                  ),),
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            offset: Offset(0,1),
                            spreadRadius: 1.2,
                            blurRadius: 0.5
                        )]),
                  width: SizeConfig.screenWidth * 0.5,
                  height: SizeConfig.blockSizeVertical * 5,
                  alignment: Alignment.center,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter name for desginated pickup",
                      hintStyle: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 1.25,
                        color: Colors.grey
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8)
                    ),
                  ),
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                alignment: Alignment.center,
                child: Text("Generate Pickup Code",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical,
                  bottom: SizeConfig.blockSizeVertical
                ),
                alignment: Alignment.center,
                child: Container(
                  width: SizeConfig.screenWidth * 0.5,
                  height: SizeConfig.blockSizeVertical * 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0XFFFEE715),
                      width: 1.0
                    ),
                    color: Colors.white
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(2),
                        width: SizeConfig.screenWidth * 0.15,
                        height: SizeConfig.blockSizeVertical * 5,
                        decoration: BoxDecoration(
                          color: Color(0XFFFEE715),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Text("Gen.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.1,
                  right: SizeConfig.screenWidth * 0.1,
                ),
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  onPressed: (){},
                  height: SizeConfig.blockSizeVertical * 4,
                  color: Color(0XFFFEE715),
                  child: Text("Save",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                  minWidth: SizeConfig.screenWidth * 0.3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DesignatedPickups{
  const DesignatedPickups({this.pickup});
  final String pickup;
}

