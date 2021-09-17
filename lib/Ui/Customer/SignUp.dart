import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_chef/Driver/DriverLogin.dart';
import 'package:flutter_chef/Driver/DriverRegister.dart';
import 'package:flutter_chef/Ui/SignUpCookScreen.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

import '../LoginScreen.dart';
import 'Login.dart';
import 'SignUp2.dart';

class CustomerSignUp extends StatefulWidget {
  const CustomerSignUp({Key key}) : super(key: key);

  @override
  _CustomerSignUpState createState() => _CustomerSignUpState();
}

class _CustomerSignUpState extends State<CustomerSignUp> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  Gender selectedGender;
  bool isLoading = false;
  bool isError = false;
  List<Gender> genders = <Gender>[
    const Gender(gender: 'Male'),
    const Gender(gender: 'Female'),
    const Gender(gender: 'Other')
  ];

  DateTime selectedDob = DateTime.now();
  String date = DateTime.now().toString();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController alternativePhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController gpsController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController cPwdController = TextEditingController();

  FocusNode fullNameFocusNode;
  FocusNode userNameFocusNode;
  FocusNode phoneFocusNode;
  FocusNode alternativePhoneFocusNode;
  FocusNode emailFocusNode;
  FocusNode genderFocusNode;
  FocusNode dobFocusNode;
  FocusNode experienceFocusNode;
  FocusNode streetFocusNode;
  FocusNode cityFocusNode;
  FocusNode stateFocusNode;
  FocusNode countryFocusNode;
  FocusNode buildingFocusNode;
  FocusNode gpsFocusNode;
  FocusNode pwdFocusNode;
  FocusNode cPwdFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameFocusNode = FocusNode();
    userNameFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    alternativePhoneFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    genderFocusNode = FocusNode();
    dobFocusNode = FocusNode();
    experienceFocusNode = FocusNode();
    streetFocusNode = FocusNode();
    cityFocusNode = FocusNode();
    stateFocusNode = FocusNode();
    countryFocusNode = FocusNode();
    buildingFocusNode = FocusNode();
    gpsFocusNode = FocusNode();
    pwdFocusNode = FocusNode();
    cPwdFocusNode = FocusNode();
  }
  int _radioValue = 0;

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameFocusNode.dispose();
    userNameFocusNode.dispose();
    phoneFocusNode.dispose();
    alternativePhoneFocusNode.dispose();
    emailFocusNode.dispose();
    genderFocusNode.dispose();
    dobFocusNode.dispose();
    experienceFocusNode.dispose();
    streetFocusNode.dispose();
    cityFocusNode.dispose();
    stateFocusNode.dispose();
    countryFocusNode.dispose();
    buildingFocusNode.dispose();
    gpsFocusNode.dispose();
    pwdFocusNode.dispose();
    cPwdFocusNode.dispose();
    super.dispose();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDob,
      firstDate: DateTime(1980, 1),
      lastDate: DateTime(2101),
      currentDate: selectedDob,
    );

    if (picked != null && picked != selectedDob) {
      setState(() {
        selectedDob = picked;
      });
    }
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
                  Center(child: Text("SignUp As: "),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      new Radio (
                        value: 0,
                        groupValue: _radioValue,

                        onChanged: _handleRadioValueChange ,
                      ),
                      new Text(
                        ' User',
                        style: new TextStyle(fontSize: 16.0),
                      ),


                      new Radio (
                        value: 1,
                        groupValue: _radioValue,

                        onChanged: _handleRadioValueChange,

                      ),

                      new Text(
                        ' Cook',
                        style: new TextStyle(
                          fontSize: 16.0,

                        ),
                      ),
                      new Radio (
                        value: 2,
                        groupValue: _radioValue,

                        onChanged: _handleRadioValueChange,

                      ),

                      new Text(
                        ' Delivery Person',
                        style: new TextStyle(
                          fontSize: 16.0,

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
                                child: Row(

                                  children: [
                                    Text(
                                      "Full Name ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
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
                                  focusNode: fullNameFocusNode,
                                  controller: fullNameController,
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
                                    fullNameFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(userNameFocusNode);
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
                                  children: [
                                    Text(
                                      "Username",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
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
                                  focusNode: userNameFocusNode,
                                  controller: userNameController,
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
                                    userNameFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(phoneFocusNode);
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          //todo: implement dropdown
                                          child: Row(
                                            children: [
                                              Text(
                                                "Phone ",
                                                style: TextStyle(color: Colors.black),
                                              ),
                                              Text(
                                                "*",
                                                style: TextStyle(color: Colors.red),
                                              ),
                                            ],
                                          ),
                                          padding: EdgeInsets.only(
                                              bottom:
                                              SizeConfig.screenHeight * 0.01),
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical *
                                                  1.5),
                                        ),
                                        Container(
                                          width: SizeConfig.screenWidth * 0.25,
                                          height:
                                          SizeConfig.blockSizeVertical * 4.5,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(5)),
                                          child: Row(
                                            children: [
                                              Container(
                                                width:
                                                SizeConfig.blockSizeHorizontal *
                                                    15,
                                                child: CountryCodePicker(
                                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                  initialSelection: '+91',
                                                  showFlagMain: false,
                                                  // optional. Shows only country name and flag
                                                  showCountryOnly: false,
                                                  hideMainText: false,
                                                  padding: EdgeInsets.only(
                                                      right: SizeConfig
                                                          .blockSizeHorizontal),
                                                  textStyle: TextStyle(
                                                      fontSize: SizeConfig
                                                          .blockSizeVertical *
                                                          1.5,
                                                      color: Colors.black),
                                                  showFlag: true,
                                                  // optional. Shows only country name and flag when popup is closed.
                                                  showOnlyCountryWhenClosed: false,
                                                  // optional. aligns the flag and the Text left
                                                  alignLeft: false,
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down,
                                                color: Colors.black,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.40,
                                      margin: EdgeInsets.only(
                                        left: SizeConfig.screenWidth * 0.045,
                                        top: SizeConfig.blockSizeVertical * 4.7,
                                      ),
                                      child: TextFormField(
                                        focusNode: phoneFocusNode,
                                        controller: phoneController,
                                        maxLength: 10,
                                        buildCounter: (BuildContext context,
                                            {int currentLength,
                                              int maxLength,
                                              bool isFocused}) =>
                                        null,
                                        textInputAction: TextInputAction.next,
                                        keyboardType: TextInputType.phone,
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
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[800],
                                                  style: BorderStyle.solid,
                                                  width: 1.0),
                                            ),
                                            errorStyle:
                                            TextStyle(color: Colors.red)),
                                        onFieldSubmitted: (term) {
                                          phoneFocusNode.unfocus();
                                          FocusScope.of(context).requestFocus(
                                              alternativePhoneFocusNode);
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
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "Email ",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "*",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
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
                                  focusNode: emailFocusNode,
                                  controller: emailController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
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
                                    emailFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(genderFocusNode);
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
                                  child: Row(
                                    children: [
                                      Text(
                                        "Gender ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      Text(
                                        "*",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
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
                                child: DropdownButtonFormField<Gender>(
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(
                                          SizeConfig.blockSizeHorizontal),
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
                                  focusNode: genderFocusNode,
                                  hint: Text(
                                    "Select Gender",
                                    style: TextStyle(
                                      fontSize: SizeConfig.blockSizeVertical * 1.2,
                                    ),
                                  ),
                                  value: selectedGender,
                                  onChanged: (Gender value) {
                                    setState(() {
                                      selectedGender = value;
                                    });
                                    genderFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(dobFocusNode);
                                  },
                                  items: genders.map((Gender gender) {
                                    return DropdownMenuItem<Gender>(
                                      value: gender,
                                      child: Text(
                                        gender.gender,
                                        style: TextStyle(
                                            fontSize:
                                            SizeConfig.blockSizeVertical * 1.5),
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }).toList(),
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
                                  child:  isLoading
                                      ? CircularProgressIndicator(
                                    valueColor:
                                    new AlwaysStoppedAnimation<
                                        Color>(Colors.white),
                                  )
                                      :Text(
                                    "Next",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  color: Color(0XFFfee715),
                                  onPressed: () {
                                    signup();
                                  },
                                ),
                              ),
                              // Container(
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       Container(
                              //         padding: EdgeInsets.all(5.0),
                              //         decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             borderRadius: BorderRadius.circular(5.0),
                              //             boxShadow: [
                              //               BoxShadow(
                              //                 color: Colors.grey,
                              //                 offset: Offset.zero,
                              //                 blurRadius: 0.1,
                              //                 spreadRadius: 0.1,
                              //               )
                              //             ]),
                              //         child: Row(
                              //           children: [
                              //             Image(
                              //               image: AssetImage(
                              //                   'assets/icons/google.png'),
                              //             ),
                              //             VerticalDivider(
                              //               color: Colors.black,
                              //               thickness: 1.0,
                              //             ),
                              //             Text(
                              //               "Sign in with \n Google+",
                              //               style: TextStyle(
                              //                   fontSize:
                              //                   SizeConfig.blockSizeVertical *
                              //                       1.25),
                              //             )
                              //           ],
                              //         ),
                              //         width: SizeConfig.screenWidth * 0.34,
                              //         height: SizeConfig.blockSizeVertical * 5,
                              //         margin: EdgeInsets.only(),
                              //       ),
                              //       SizedBox(
                              //         width: SizeConfig.blockSizeHorizontal * 2,
                              //       ),
                              //       Container(
                              //         padding: EdgeInsets.all(5.0),
                              //         decoration: BoxDecoration(
                              //             color: Colors.white,
                              //             borderRadius: BorderRadius.circular(5.0),
                              //             boxShadow: [
                              //               BoxShadow(
                              //                 color: Colors.grey,
                              //                 offset: Offset.zero,
                              //                 blurRadius: 0.1,
                              //                 spreadRadius: 0.1,
                              //               )
                              //             ]),
                              //         child: Row(
                              //           children: [
                              //             Image(
                              //               image:
                              //               AssetImage('assets/icons/fb.png'),
                              //             ),
                              //             VerticalDivider(
                              //               color: Colors.black,
                              //               thickness: 1.0,
                              //             ),
                              //             Text(
                              //               "Sign in with \n Facebook",
                              //               style: TextStyle(
                              //                   fontSize:
                              //                   SizeConfig.blockSizeVertical *
                              //                       1.25),
                              //             )
                              //           ],
                              //         ),
                              //         width: SizeConfig.screenWidth * 0.34,
                              //         height: SizeConfig.blockSizeVertical * 5,
                              //         margin: EdgeInsets.only(),
                              //       ),
                              //     ],
                              //   ),
                              // ),
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
Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
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

  dynamic registerwithserver = new List();
  signup() async {

    if (signUpFormKey.currentState.validate()) {
      signUpFormKey.currentState.save();
      setState(() {
        isLoading = true;
      });
      print("jkrn;o");
      final map = {
      "phone_number":phoneController.text,
      "gender":selectedGender.gender,
      "email":emailController.text,
      "password":pwdController.text,
      "confirm_password":cPwdController.text,
      "description":"kjjh",
      "full_name":fullNameController.text,
      "country_code":"91",
      "address":"HVVGVGVGVAGVVGV",
      "city":"Surat",
        'name':userNameController.text,
      "state":"Gujarat",
      "country":"India"};
      try {
        Dio dio=Dio();
        FormData data = FormData.fromMap(map);
        final response = await dio.post((registeruser),
            data: data);
        print("bjkb" + response.statusCode.toString());
        if (response.statusCode == 200) {
         // final responseJson = json.decode(response.data);

         // registerwithserver = responseJson;
          // print(loginwithserver['data']['email']);
          print(response.data);
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
          //print("bjkb" + response.statusCode.toString());
          final responseJson = json.decode(response.data);
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
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
          break;
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpCook()));
          break;
        case 2:
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Driverregister()));

      }
    });
  }

}

class Gender {
  const Gender({this.gender});
  final String gender;
}
class Drivermode {
  const Drivermode({this.mode});
  final String mode;
}