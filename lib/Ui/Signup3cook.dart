import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:http/http.dart'as http;
import 'LoginScreen.dart';

class Signup3Cook extends StatefulWidget {
  String experience;
  String summary;
  String street;
  String city;
  String state;
  String country;
  String building;
  String name;
  String business;
  String phone;
  String alternative;
  String email;
  String gender;
  String dob;
  Signup3Cook(
      {this.gender,

      this.email,
      this.name,
      this.business,
      this.dob,
      this.phone,
      this.alternative,this.experience,
      this.summary,
      this.street,
      this.city,
      this.state,
      this.country,
      this.building});
  @override
  _Signup3CookState createState() => _Signup3CookState();
}

class _Signup3CookState extends State<Signup3Cook> {
  TextEditingController pwdController = TextEditingController();
  FocusNode pwdFocusNode;
  FocusNode cPwdFocusNode;
  bool isLoading = false;
  bool isError = false;
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  TextEditingController cPwdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                    height: MediaQuery.of(context).size.height,
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
                                margin: EdgeInsets.all(
                                    SizeConfig.blockSizeVertical * 2),
                                child: Image(
                                  image: AssetImage(
                                      'assets/icons/my dishes icon.png'),
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
                                      height:
                                          SizeConfig.blockSizeVertical * 5.2,
                                      width: SizeConfig.screenWidth,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Password',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              "Password",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            padding: EdgeInsets.only(
                                                bottom:
                                                    SizeConfig.screenHeight *
                                                        0.01),
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.05,
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    1.5),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left:
                                                  SizeConfig.screenWidth * 0.05,
                                              right:
                                                  SizeConfig.screenWidth * 0.05,
                                            ),
                                            child: TextFormField(
                                              focusNode: pwdFocusNode,
                                              controller: pwdController,
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType: TextInputType.text,
                                              obscureText: true,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets
                                                          .only(
                                                              top: 10.0,
                                                              left: 4.0),
                                                  isDense: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      800],
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                  width: 1.0)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey[800],
                                                              style:
                                                                  BorderStyle
                                                                      .solid,
                                                              width: 1.0)),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey[800],
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey[800],
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1.0),
                                                  ),
                                                  errorStyle: TextStyle(
                                                      color: Colors.red),
                                                  errorMaxLines: 5),
                                              onFieldSubmitted: (term) {
                                                pwdFocusNode.unfocus();
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        cPwdFocusNode);
                                              },
                                              validator: (value) {
                                                if (value.isEmpty)
                                                  return "This field is required";
                                                else if (validateStructure(
                                                        value) ==
                                                    false) {
                                                  return " password must be at least 8 characters "
                                                      "must contain at least one uppercase, one lowercase, one Special Character and one digit.";
                                                } else
                                                  return null;
                                              },
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "Re-enter Password",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            padding: EdgeInsets.only(
                                                bottom:
                                                    SizeConfig.screenHeight *
                                                        0.01),
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.screenWidth *
                                                    0.05,
                                                top: SizeConfig
                                                        .blockSizeVertical *
                                                    1.5),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              left:
                                                  SizeConfig.screenWidth * 0.05,
                                              right:
                                                  SizeConfig.screenWidth * 0.05,
                                            ),
                                            child: TextFormField(
                                              focusNode: cPwdFocusNode,
                                              controller: cPwdController,
                                              textInputAction:
                                                  TextInputAction.next,
                                              keyboardType: TextInputType.text,
                                              obscureText: true,
                                              style: TextStyle(
                                                  color: Colors.black),
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets
                                                          .only(
                                                              top: 10.0,
                                                              left: 4.0),
                                                  isDense: true,
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                          .grey[
                                                                      800],
                                                                  style:
                                                                      BorderStyle
                                                                          .solid,
                                                                  width: 1.0)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: Colors
                                                                  .grey[800],
                                                              style:
                                                                  BorderStyle
                                                                      .solid,
                                                              width: 1.0)),
                                                  errorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey[800],
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1.0),
                                                  ),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey[800],
                                                        style:
                                                            BorderStyle.solid,
                                                        width: 1.0),
                                                  ),
                                                  errorStyle: TextStyle(
                                                      color: Colors.red)),
                                              onFieldSubmitted: (term) {
                                                cPwdFocusNode.unfocus();
                                              },
                                              validator: (value) {
                                                if (value.isEmpty)
                                                  return "This field is required";
                                                else if (value !=
                                                    pwdController.text)
                                                  return "Password Mismatch";
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
                                              child: isLoading
                                                  ? CircularProgressIndicator(
                                                      valueColor:
                                                          new AlwaysStoppedAnimation<
                                                                  Color>(
                                                              Colors.white),
                                                    )
                                                  : Text("Sign Up Now"),
                                              color: Color(0XFFfee715),
                                              onPressed: () {
                                                signup();
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
                                          SizedBox(
                                            height: 25,
                                          )
                                        ],
                                      ),
                                    ),
                                  ]))
                        ])))));
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
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
        final response = await http.post(Uri.parse(register), body: {
          "full_name": widget.name,
          "business_name": widget.business,
          "country_code": "+91",
          "phone_number": widget.phone,
          "email": widget.email,
          "password": pwdController.text,
          "confirm_password": cPwdController.text,
          "gender": "Male",
          "dob": widget.dob,
          "alternative_phone_number": widget.alternative,
          "years_of_experience": widget.experience,
          "state": widget.state,
          "city": widget.city,
          "country": widget.country,
          "street_name": widget.street,
          "description": widget.summary,
          "building_description": widget.building
        });
        print("bjkb" + response.toString());
        if (response.statusCode == 200) {
          final responseJson = json.decode(response.body);

          registerwithserver = responseJson;
          showToast("Register Succesfully");
          // print(loginwithserver['data']['email']);
          print(registerwithserver);

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
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

  }
}

