import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:http/http.dart' as http;

class CustomerSignUp2 extends StatefulWidget {
  CustomerSignUp2(
      {this.email,
        this.gender,
        this.name,
        this.phone,
        this.username,
        this.password});
  String name;
  String username;
  String phone;
  String email;
  String gender;
  String password;
  @override
  _CustomerSignUp2State createState() => _CustomerSignUp2State();
}

class _CustomerSignUp2State extends State<CustomerSignUp2> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController cPwdController = TextEditingController();
  final String url = "http://chief.uplosse.com/api/country-list";
  var _mySelection;

  FocusNode cityFocusNode;
  FocusNode stateFocusNode;
  FocusNode countryFocusNode;
  FocusNode pwdFocusNode;
  FocusNode cPwdFocusNode;
  FocusNode addressFocusNode;
  bool isLoading = false;
  bool isError = false;
  @override
  void initState() {
    updateprofile();
    // TODO: implement initState
    super.initState();
    cityFocusNode = FocusNode();
    stateFocusNode = FocusNode();
    countryFocusNode = FocusNode();
    addressFocusNode = FocusNode();
    pwdFocusNode = FocusNode();
    cPwdFocusNode = FocusNode();
    print(widget.gender);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cityFocusNode.dispose();
    stateFocusNode.dispose();
    countryFocusNode.dispose();
    addressFocusNode.dispose();
    pwdFocusNode.dispose();
    cPwdFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg/signup bg .png'),
                    fit: BoxFit.fill,
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: SizeConfig.screenWidth * 0.15,
                        height: SizeConfig.screenHeight * 0.10,
                        margin: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
                        child: Image(
                          image: AssetImage('assets/icons/my dishes icon.png'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 0.2,
                    ),
                    width: SizeConfig.screenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            spreadRadius: 1,
                            blurRadius: 0.5,
                            offset: Offset.zero)
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: SizeConfig.blockSizeVertical * 5.2,
                          width: SizeConfig.screenWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Sign Up As Customer',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          color: Color(0XFFfee715),
                          thickness: 1.0,
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.02,
                        ),
                        Form(
                          key: signUpFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "Address",
                                  style: TextStyle(color: Colors.black),
                                ),
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.screenHeight * 0.01),
                                margin: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 0.05),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.05,
                                  right: SizeConfig.screenWidth * 0.05,
                                ),
                                child: TextFormField(
                                  focusNode: addressFocusNode,
                                  controller: addressController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(top: 10.0, left: 4.0),
                                      isDense: true,
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
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
                                    addressFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(cityFocusNode);
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
                                child: Text(
                                  "City",
                                  style: TextStyle(color: Colors.black),
                                ),
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.screenHeight * 0.01),
                                margin: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 0.05,
                                    top: SizeConfig.blockSizeVertical * 1.5),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.05,
                                  right: SizeConfig.screenWidth * 0.05,
                                ),
                                child: TextFormField(
                                  focusNode: cityFocusNode,
                                  controller: cityController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(top: 10.0, left: 4.0),
                                      isDense: true,
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
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
                                    cityFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(stateFocusNode);
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
                                        Container(
                                          //todo: implement dropdown
                                          child: Text(
                                            "State",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          padding: EdgeInsets.only(
                                              bottom:
                                              SizeConfig.screenHeight * 0.01),
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical *
                                                  1.5),
                                        ),
                                        Container(
                                          width: SizeConfig.screenWidth * 0.2,
                                          height:
                                          SizeConfig.blockSizeVertical * 4.5,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          child: TextFormField(
                                            focusNode: stateFocusNode,
                                            controller: stateController,
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.text,
                                            style: TextStyle(color: Colors.black),
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    top: 10.0, left: 4.0),
                                                isDense: true,
                                                floatingLabelBehavior:
                                                FloatingLabelBehavior.always,
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
                                                focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[800],
                                                      style: BorderStyle.solid,
                                                      width: 1.0),
                                                ),
                                                errorStyle:
                                                TextStyle(color: Colors.red)),
                                            onFieldSubmitted: (term) {
                                              stateFocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .requestFocus(countryFocusNode);
                                            },
                                            validator: (value) {
                                              if (value.isEmpty)
                                                return "This field is required";
                                              else
                                                return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 10,),
                                        Container(
                                          //todo: implement dropdown
                                          child: Text(
                                            "Country",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          padding: EdgeInsets.only(
                                              bottom: SizeConfig.screenHeight * 0.01),
                                        ),
                                        Container(
                                          height:
                                          SizeConfig.blockSizeVertical * 4.5,
                                          width: 173,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),border: Border.all(color:Colors.black)),
                                          child: new DropdownButtonFormField(
                                            decoration: InputDecoration.collapsed(hintText: ''),
                                            items: updateprofilefromsever.map<DropdownMenuItem<String>>((item) {
                                              return  DropdownMenuItem(

                                                child: new Text(item['country_name'],style: TextStyle(fontSize: 8),),
                                                value: item['id'].toString(),
                                              );
                                            }).toList(),
                                            onChanged: (newVal) {
                                              setState(() {
                                                _mySelection = newVal;

                                                print(_mySelection);
                                              });
                                            },
                                            value: _mySelection,
                                          ),
                                        ),


                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Password",
                                  style: TextStyle(color: Colors.black),
                                ),
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.screenHeight * 0.01),
                                margin: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 0.05,
                                    top: SizeConfig.blockSizeVertical * 1.5),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.05,
                                  right: SizeConfig.screenWidth * 0.05,
                                ),
                                child: TextFormField(
                                  focusNode: pwdFocusNode,
                                  controller: pwdController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(top: 10.0, left: 4.0),
                                      isDense: true,
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
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
                                    pwdFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(cPwdFocusNode);
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
                                child: Container(
                                  child: Text(
                                    "Re-enter Password",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 0.05,
                                      top: SizeConfig.blockSizeVertical * 1.5),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 0.05,
                                    right: SizeConfig.screenWidth * 0.05,
                                    top: SizeConfig.blockSizeVertical),
                                width: SizeConfig.screenWidth,
                                child: TextFormField(
                                  focusNode: cPwdFocusNode,
                                  controller: cPwdController,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(top: 10.0, left: 4.0),
                                      isDense: true,
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
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
                                    cPwdFocusNode.unfocus();
                                  },
                                  validator: (value) {
                                    if (value.isEmpty)
                                      return "This field is required";
                                    else if (value != pwdController.text)
                                      return "Password Mismatch";
                                    else
                                      return null;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.05,
                                  right: SizeConfig.screenWidth * 0.05,
                                  top: SizeConfig.blockSizeVertical * 1.5,
                                ),
                                alignment: Alignment.center,
                                child: MaterialButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  minWidth: SizeConfig.screenWidth,
                                  child: Text(
                                    "Sign Up Now",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  color: Color(0XFFfee715),
                                  onPressed: () {
                                    signup();
                                    // Navigator.of(context)
                                    //     .pushNamed('/CustomerHomePage');
                                  },
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset.zero,
                                              blurRadius: 0.1,
                                              spreadRadius: 0.1,
                                            )
                                          ]),
                                      child: Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/icons/google.png'),
                                          ),
                                          VerticalDivider(
                                            color: Colors.black,
                                            thickness: 1.0,
                                          ),
                                          Text(
                                            "Sign in with \n Google+",
                                            style: TextStyle(
                                                fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.25),
                                          )
                                        ],
                                      ),
                                      width: SizeConfig.screenWidth * 0.34,
                                      height: SizeConfig.blockSizeVertical * 5,
                                      margin: EdgeInsets.only(),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 2,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5.0),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(5.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset.zero,
                                              blurRadius: 0.1,
                                              spreadRadius: 0.1,
                                            )
                                          ]),
                                      child: Row(
                                        children: [
                                          Image(
                                            image:
                                            AssetImage('assets/icons/fb.png'),
                                          ),
                                          VerticalDivider(
                                            color: Colors.black,
                                            thickness: 1.0,
                                          ),
                                          Text(
                                            "Sign in with \n Facebook",
                                            style: TextStyle(
                                                fontSize:
                                                SizeConfig.blockSizeVertical *
                                                    1.25),
                                          )
                                        ],
                                      ),
                                      width: SizeConfig.screenWidth * 0.34,
                                      height: SizeConfig.blockSizeVertical * 5,
                                      margin: EdgeInsets.only(),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical,
                                  bottom: SizeConfig.blockSizeVertical * 4,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an account? ",
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/CustomerLogin');
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize:
                                            SizeConfig.blockSizeVertical * 2,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.15,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
  dynamic updateprofilefromsever=new List();
  void updateprofile()async {
    print("update");

    try {
      final response = await http.get(Uri.parse(url));

      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        updateprofilefromsever = responseJson['data'];
        // print(loginwithserver['data']['email']);
        print(updateprofilefromsever);
        // showToast("Update Successfully");
        //  Navigator.of(context).pushNamed('/CustomerLogin');
        // showToast("");
        //  savedata();
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  dynamic registerwithserver = new List();
  signup() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.getString("device_id");
    // print(selectedDob);
    // print("osnanl" + usernameString);
    // bool isvalid = EmailValidator.validate(usernameString);
    if (signUpFormKey.currentState.validate()) {
      signUpFormKey.currentState.save();
      setState(() {
        isLoading = true;
      });
      try {
        final response = await http.post(Uri.parse(registeruser), body: {
          "full_name": widget.name,
          "phone_number": widget.phone,
          "name": widget.username,
          "email": widget.email,
          "password": pwdController.text,
          "confirm_password": cPwdController.text,
          "gender": widget.gender,
          "state": stateController.text,
          "address": addressController.text,
          "city": cityController.text,
          "country": _mySelection,
          "country_code": "+91"
        });
        print("bjkb" + response.statusCode.toString());
        if (response.statusCode == 200) {
          final responseJson = json.decode(response.body);

          registerwithserver = responseJson;
          // print(loginwithserver['data']['email']);
          print(registerwithserver);
          showToast("Register Succesfully");
          Navigator.of(context).pushNamed('/CustomerLogin');
          // showToast("");
          //  savedata();
          setState(() {
            isError = false;
            isLoading = false;
            print('setstate');
          });
        } else {
          print("bjkb" + response.statusCode.toString());
          final responseJson = json.decode(response.body);
          registerwithserver = responseJson;
          showToast(registerwithserver['error']);
          setState(() {
            isError = true;
            isLoading = false;
          });
        }
      } catch (e) {
        print(e);
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    }
  }
}
