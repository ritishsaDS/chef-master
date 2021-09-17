import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/ListTileTotalOrders.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

class Eventschef extends StatefulWidget{
  @override
  _EventschefState createState() => _EventschefState();
}

class _EventschefState extends State<Eventschef> {
  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDob,
      firstDate: selectedDob,
      lastDate: DateTime(2101),
      currentDate: selectedDob,
    );

    if (picked != null && picked != selectedDob) {
      setState(() {
        selectedDob = picked;
      });
    }
  }
  DateTime selectedDob = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(child: Scaffold(
      // bottomNavigationBar: navBar(2),


      body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg/top bg orders .png'),
                      fit: BoxFit.cover,
                    )),
                width: SizeConfig.screenWidth,
                height: SizeConfig.screenHeight * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppBar(
                      backgroundColor: Color(0XFFFFe715),
                      elevation: 0.0,
                      centerTitle: true,
                      title: Text(
                        "Events",
                        style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 2.5,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      iconTheme: IconThemeData(color: Colors.black),
                    ),

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.05,
                      ),
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Color(0XFFFEE715), width: 1.5),
                          borderRadius: BorderRadius.circular(5)),
                      height: SizeConfig.blockSizeVertical * 4,
                      width: SizeConfig.blockSizeHorizontal * 30,
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
                                hintText: "Events",
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
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.black,
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        right: SizeConfig.screenWidth * 0.05,
                      ),
                      decoration: BoxDecoration(
                          border:
                          Border.all(color: Color(0XFFFEE715), width: 1.5),
                          borderRadius: BorderRadius.circular(5)),
                      height: SizeConfig.blockSizeVertical * 4,
                      width: SizeConfig.blockSizeHorizontal * 30,
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
                margin:
                EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1.5),
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
                      "Event Detail",
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Event Title",
                      style: TextStyle(color: Colors.black),
                    ),

                  ],
                ),
                padding: EdgeInsets.only(
                    bottom: SizeConfig.screenHeight * 0.01),
                margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.blockSizeHorizontal * 8,
                  top: SizeConfig.blockSizeVertical * 1.5,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                ),
                child: TextFormField(
                  // focusNode: buildingFocusNode,
                  // controller: buildingController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                 // maxLength: 2000,
                  maxLines: 1,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.only(top: 10.0, left: 4.0),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[800],
                              style: BorderStyle.solid,
                              width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[800],
                              style: BorderStyle.solid,
                              width: 1.0)),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey[800],
                            style: BorderStyle.solid,
                            width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey[800],
                            style: BorderStyle.solid,
                            width: 1.0),
                      ),
                      errorStyle: TextStyle(color: Colors.red)),
                  onFieldSubmitted: (term) {
                    // buildingFocusNode.unfocus();
                    // FocusScope.of(context).requestFocus(gpsFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty)
                      return "This field is required";
                    else
                      return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Event Date",
                      style: TextStyle(color: Colors.black),
                    ),

                  ],
                ),
                padding: EdgeInsets.only(
                    bottom: SizeConfig.screenHeight * 0.01),
                margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.blockSizeHorizontal * 8,
                  top: SizeConfig.blockSizeVertical * 1.5,
                ),
              ),
              InkWell(
                onTap: () {
                  selectDate(context);
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: SizeConfig.screenWidth * 0.05,
                    right: SizeConfig.blockSizeHorizontal * 8,
                   // top: SizeConfig.blockSizeVertical * 1.5,
                    bottom: SizeConfig.blockSizeVertical * 1.5,
                  ),
                  padding: EdgeInsets.only(left: 10),
                  alignment: Alignment.centerLeft,
                  width: SizeConfig.screenWidth ,
                  child: Text(
                    "${selectedDob.day}" +
                        "/" +
                        "${selectedDob.month}" +
                        "/" +
                        "${selectedDob.year}"
                            .split(' ')[0]
                            .replaceAll("-", "/"),
                    style: TextStyle(
                        fontSize:
                        SizeConfig.blockSizeVertical *
                            1.5),
                  ),
                  height: SizeConfig.blockSizeVertical * 4,

                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[800],
                      ),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),

              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Description",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      "(Max. 2000 Characters)",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: SizeConfig.blockSizeVertical * 1.5),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(
                    bottom: SizeConfig.screenHeight * 0.01),
                margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.blockSizeHorizontal * 8,
                  top: SizeConfig.blockSizeVertical * 1.5,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                ),
                child: TextFormField(
                  // focusNode: buildingFocusNode,
                  // controller: buildingController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  maxLength: 2000,
                  maxLines: 3,
                  style: TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      contentPadding:
                      EdgeInsets.only(top: 10.0, left: 4.0),
                      isDense: true,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[800],
                              style: BorderStyle.solid,
                              width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey[800],
                              style: BorderStyle.solid,
                              width: 1.0)),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey[800],
                            style: BorderStyle.solid,
                            width: 1.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.grey[800],
                            style: BorderStyle.solid,
                            width: 1.0),
                      ),
                      errorStyle: TextStyle(color: Colors.red)),
                  onFieldSubmitted: (term) {
                   // buildingFocusNode.unfocus();
                   // FocusScope.of(context).requestFocus(gpsFocusNode);
                  },
                  validator: (value) {
                    if (value.isEmpty)
                      return "This field is required";
                    else
                      return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left:
                  SizeConfig.screenWidth * 0.05,
                  right:
                  SizeConfig.screenWidth * 0.05,
                  top:
                  SizeConfig.blockSizeVertical *
                      1.5,
                ),
                alignment: Alignment.center,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(5),
                  ),
                  minWidth: SizeConfig.screenWidth,
                  // child: isLoading
                  //     ? CircularProgressIndicator(
                  //   valueColor:
                  //   new AlwaysStoppedAnimation<
                  //       Color>(
                  //       Colors.white),
                  // )
                      child: Text("Add Event"),
                  color: Color(0XFFfee715),
                  onPressed: () {
                   // signup();
                    // signup(
                    //     fullNameController.text,
                    //     businessNameController.text,
                    //     phoneController.text,
                    //     alternativePhoneController.text,
                    //     emailController.text,
                    //     experienceController.text,
                    //     streetController.text,
                    //     cityController.text,
                    //     stateController.text,
                    //     countryController.text);
                    //  Navigator.of(context).pushNamed('/Home');
                  },
                ),
              ),

            ],
          )),
    ));

  }}