import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

class AddCard extends StatefulWidget {
  const AddCard({Key key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {

  Color cdButtonColor = Colors.white;
  Color internetButtonColor = Colors.white;
  Color walletButtonColor = Colors.white;
  Color cdTextColor = Colors.grey;
  Color internetTextColor = Colors.grey;
  Color walletTextColor = Colors.grey;

  bool saveCheckbox = false;
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController cardHolderController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  FocusNode cardNumberFocusNode;
  FocusNode cvvFocusNode;
  FocusNode monthFocusNode;
  FocusNode holderFocusNode;
  FocusNode mobileFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cardNumberFocusNode = FocusNode();
    cvvFocusNode = FocusNode();
    monthFocusNode = FocusNode();
    holderFocusNode = FocusNode();
    mobileFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cardNumberFocusNode.dispose();
    cvvFocusNode.dispose();
    mobileFocusNode.dispose();
    holderFocusNode.dispose();
    mobileFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      bottomNavigationBar: Customerbottom(index: 3,),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/icons/minus icon.png',
                      height: SizeConfig.blockSizeVertical * 2,),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      Text(Constants().currency+" 1000",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 4
                        ),),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      Image.asset('assets/icons/add icon.png',
                        height: SizeConfig.blockSizeVertical * 2,),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical * 0.5,
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.3,
                    height: SizeConfig.blockSizeVertical * 3.5,
                    alignment: Alignment.center,
                    child: Text("Amount",
                      style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
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
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.screenHeight * 0.03,
                  bottom: SizeConfig.screenHeight * 0.01 ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2.0,
                      blurRadius: 5.0,
                      offset: Offset(0,0)
                  )],),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                      top: SizeConfig.blockSizeVertical * 2
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(onPressed: (){
                          setState(() {
                            cdButtonColor= Color(0XFFFEE715);
                            internetButtonColor = Colors.white;
                            walletButtonColor = Colors.white;
                          });
                        },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)
                          ),
                          padding: EdgeInsets.all(8),
                          child: Text("Credit / Debit Card",
                          style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 1.25
                          ),),
                          color: cdButtonColor,),
                        MaterialButton(onPressed: (){
                          setState(() {
                            cdButtonColor= Colors.white;
                            internetButtonColor = Color(0XFFFEE715);
                            walletButtonColor = Colors.white;
                          });
                        },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          padding: EdgeInsets.all(8),                          child: Text("Internet Banking",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.25
                            ),),
                          color: internetButtonColor,),
                        MaterialButton(onPressed: (){
                          setState(() {
                            cdButtonColor= Colors.white;
                            internetButtonColor = Colors.white;
                            walletButtonColor = Color(0XFFFEE715);
                          });
                        },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                          ),
                          padding: EdgeInsets.all(8),                          child: Text("UPI Payment",
                            style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.25
                            ),),
                          color: walletButtonColor,),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 2,
                      bottom: SizeConfig.blockSizeVertical * 2
                    ),
                    width: SizeConfig.screenWidth,
                    alignment: Alignment.center,
                    child: Text("Card Detail",
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  Container(
                    height: SizeConfig.screenHeight * 0.06,
                    width: SizeConfig.screenWidth,
                    margin: EdgeInsets.only(
                      left: SizeConfig.screenWidth * 0.05,
                      right: SizeConfig.screenWidth * 0.05,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[200],
                            spreadRadius: 0.5,
                            blurRadius: 1.0,
                            offset: Offset(0,0)
                        )
                      ],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/icons/visa card icon.png',
                        height: SizeConfig.blockSizeVertical * 4,),
                        Image.asset('assets/icons/master card icon.png',
                        height: SizeConfig.blockSizeVertical * 4,),
                        Image.asset('assets/icons/american icon.png',
                        height: SizeConfig.blockSizeVertical * 4,)
                        ],),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Form(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width : SizeConfig.screenWidth,
                            margin: EdgeInsets.only(
                              left : SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding : EdgeInsets.all(5.0),
                                    child: Text("Card Number")),
                                TextFormField(
                                  controller: cardNumberController,
                                  focusNode: cardNumberFocusNode,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                                      contentPadding: EdgeInsets.all(5.0)
                                  ),
                                  onFieldSubmitted: (term){
                                    cardNumberFocusNode.unfocus();
                                    FocusScope.of(context).requestFocus(cvvFocusNode);
                                  },
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(8.0),
                          ),
                          Container(
                            width: SizeConfig.screenWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding : EdgeInsets.all(5.0),
                                        child: Text("CVV")),
                                    Container(
                                      width: SizeConfig.screenHeight * 0.15,
                                      child: TextFormField(
                                        controller: cvvController,
                                        focusNode: cvvFocusNode,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                                            contentPadding: EdgeInsets.all(5.0)
                                        ),
                                        onFieldSubmitted: (term){
                                          cvvFocusNode.unfocus();
                                          FocusScope.of(context).requestFocus(monthFocusNode);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                        padding : EdgeInsets.all(5.0),
                                        child: Text("Month/Year")),
                                    Container(
                                      width: SizeConfig.screenHeight * 0.15,
                                      child: TextFormField(
                                        controller: monthController,
                                        focusNode: monthFocusNode,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            isDense: true,
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                                            contentPadding: EdgeInsets.all(5.0)
                                        ),
                                        onFieldSubmitted: (term){
                                          monthFocusNode.unfocus();
                                          FocusScope.of(context).requestFocus(holderFocusNode);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width : SizeConfig.screenWidth,
                            margin: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.05,
                                right: SizeConfig.screenWidth * 0.05
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding : EdgeInsets.all(5.0),
                                    child: Text("Card Holder Name")),
                                TextFormField(
                                  controller: cardHolderController,
                                  focusNode: holderFocusNode,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                                      contentPadding: EdgeInsets.all(5.0)
                                  ),
                                  onFieldSubmitted: (term){
                                    holderFocusNode.unfocus();
                                    FocusScope.of(context).requestFocus(mobileFocusNode);
                                  },
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(8.0),
                          ),
                          Container(
                            width : SizeConfig.screenWidth,
                            margin: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.05,
                                right: SizeConfig.screenWidth * 0.05
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    padding : EdgeInsets.all(5.0),
                                    child: Text("Mobile Number")),
                                TextFormField(
                                  controller: mobileNumberController,
                                  focusNode: mobileFocusNode,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                      isDense: true,
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0),),
                                      contentPadding: EdgeInsets.all(5.0)
                                  ),
                                  onFieldSubmitted: (term){
                                    mobileFocusNode.unfocus();
                                  },
                                )
                              ],
                            ),
                            padding: EdgeInsets.all(8.0),
                          ),
                          CheckboxListTile(value: saveCheckbox,
                              controlAffinity: ListTileControlAffinity.leading,
                              dense: true,
                              activeColor: Color(0XFFFEE715),
                              checkColor: Colors.black,
                              title: Text("Save Card Info",
                              style: TextStyle(
                                color: Colors.grey
                              ),),
                              onChanged: (bool value){
                            setState(() {
                              saveCheckbox = value;
                            });
                              }),
                          Container(
                            width: SizeConfig.screenWidth,
                            margin: EdgeInsets.only(
                                left: SizeConfig.screenWidth * 0.05,
                                right: SizeConfig.screenWidth * 0.05
                            ),
                            child: MaterialButton(
                              onPressed: (){
                                showDialog(context: context, builder:
                                (BuildContext context){
                                  return CustomDialog();
                                });
                              },
                              color: Color(0XFFFEE715),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: SizeConfig.screenWidth * 0.03
                                      ),
                                      child: Text("Add Now",style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: SizeConfig.blockSizeVertical * 2
                                      ),)),
                                  Container(
                                    height: SizeConfig.screenHeight * 0.035,
                                    width: SizeConfig.screenWidth * 0.25,
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0),
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Text(Constants().currency+"\t1400",textAlign: TextAlign.center,),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          )
                        ],))],),

                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class CustomDialog extends StatelessWidget {
  const CustomDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight * 0.35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage('assets/bg/pop up .png'),
                fit: BoxFit.cover
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: SizeConfig.screenWidth,
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16
                  ),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Image.asset('assets/icons/wrong.png',
                      height: SizeConfig.blockSizeVertical * 2,),
                  ),
                ),
                Container(
                    child: Column(
                      children: [
                        Text("Your Purchase was",
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 2.5
                        ),),
                        Text("SUCCESSFUL",
                        style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 3,
                          fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 15
                ),
                alignment: Alignment.center,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

