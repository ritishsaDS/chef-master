import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chef/Utils/Actionsheet.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({Key key}) : super(key: key);

  @override
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  Gender selectedGender;
  List<Gender> genders = <Gender>[
    const Gender(gender: 'Male'),
    const Gender(gender: 'Female'),
    const Gender(gender: 'Other')
  ];
var imagefromserver;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  FocusNode fullNameFn;
  FocusNode usernameFn;
  var genderhint="Select Gender";
  FocusNode phoneFn;
  FocusNode emailFn;
  FocusNode genderFn;
  FocusNode addressFn;
  FocusNode cityFn;
  FocusNode stateFn;
  FocusNode countryFn;
  bool isError = false;
  var token ;
  bool isLoading = false;
  File image;
  final String url = "http://chief.uplosse.com/api/country-list";

  List data = List(); //edited line



  @override
  void initState() {
    updateprofile();
    getprofile();

    // TODO: implement initState
    super.initState();
    fullNameFn = FocusNode();
    usernameFn = FocusNode();
    phoneFn = FocusNode();
    emailFn = FocusNode();
    genderFn = FocusNode();
    addressFn = FocusNode();
    cityFn = FocusNode();
    stateFn = FocusNode();
    countryFn = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameFn.dispose();
    usernameFn.dispose();
    phoneFn.dispose();
    emailFn.dispose();
    genderFn.dispose();
    addressFn.dispose();
    cityFn.dispose();
    stateFn.dispose();
    countryFn.dispose();
    super.dispose();
  }
  String _mySelection;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: customerNavBar(4, context),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      height: SizeConfig.screenHeight * 0.2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/bg/top bg .png'),
                              fit: BoxFit.fill)),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Icon(
                                Icons.arrow_back_sharp,
                                color: Colors.black,
                                size: SizeConfig.blockSizeVertical * 4,
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                            Container(
                              child: Text(
                                "Profile",
                                style: TextStyle(
                                    fontSize: SizeConfig.blockSizeVertical * 2.8,
                                    fontWeight: FontWeight.bold),
                              ),
                              padding: EdgeInsets.all(8),
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 4.5),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topCenter,
                            child: CircleAvatar(
                              backgroundColor: Colors.blue,
                              radius: SizeConfig.blockSizeVertical * 7.5,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: SizeConfig.blockSizeVertical * 7.45,
                                child: Container(
                                  height: 90,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: image != null
                                            ? FileImage(File(image.path))
                                            :imagefromserver==null? AssetImage("assets/icons/profile icon.png"):NetworkImage(imagefromserver),
                                        fit: BoxFit.fill),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockSizeHorizontal * 55,
                                top: SizeConfig.blockSizeVertical * 10),
                            child: InkWell(
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                showCupertinoModalPopup(
                                    context: context,
                                    builder: (BuildContext context) => ActionSheet()
                                        .actionSheet(context, onCamera: () {
                                      Navigator.pop(context);
                                      FocusScope.of(context).unfocus();
                                      chooseCameraFile().then((File file) {
                                        if (file != null) {
                                          setState(() {
                                            //   loading = true;
                                          });
                                        }
                                      }).catchError((onError) {});
                                    }, onGallery: () {
                                      Navigator.pop(context);
                                      FocusScope.of(context).unfocus();
                                      androidchooseImageFile().then((value) {
                                        setState(() {
                                          //  loading = true;
                                        });
                                      }).catchError((onError) {});
                                    }, text: "Select profile image"));
                              },
                              child: Container(
                                width: SizeConfig.blockSizeVertical * 4.5,
                                height: SizeConfig.blockSizeVertical * 4.5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Container(
                                  child: Icon(
                                    Icons.add_circle,
                                    color: Colors.blue,
                                    size: SizeConfig.blockSizeVertical * 5,
                                  ),
                                  alignment: Alignment.centerRight,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.9,
                  color: Colors.white,
                  margin: EdgeInsets.only(
                    top: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: Form(
                    key: profileFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Full Name",
                            style: TextStyle(color: Colors.black),
                          ),
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.screenHeight * 0.01),
                          margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.05),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                              bottom: SizeConfig.blockSizeVertical),
                          child: TextFormField(
                            focusNode: fullNameFn,
                            controller: fullNameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
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
                              fullNameFn.unfocus();
                              FocusScope.of(context).requestFocus(usernameFn);
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
                            "Username",
                            style: TextStyle(color: Colors.black),
                          ),
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.screenHeight * 0.01),
                          margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.05),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.05,
                            right: SizeConfig.screenWidth * 0.05,
                          ),
                          child: TextFormField(
                            focusNode: usernameFn,
                            controller: usernameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
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
                              fullNameFn.unfocus();
                              FocusScope.of(context).requestFocus(phoneFn);
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
                              top: SizeConfig.blockSizeVertical * 1.5,
                              left: SizeConfig.screenWidth * 0.05),
                          child: Container(
                            //todo: implement dropdown
                            child: Text(
                              "Phone",
                              style: TextStyle(color: Colors.black),
                            ),
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.screenHeight * 0.01),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                              bottom: SizeConfig.blockSizeVertical),
                          child: Row(
                            children: [
                              Container(
                                width: SizeConfig.screenWidth * 0.25,
                                height: SizeConfig.blockSizeVertical * 4.5,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.circular(5)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: SizeConfig.blockSizeHorizontal * 15,
                                      child: CountryCodePicker(
                                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                        initialSelection: '+91',
                                        showFlagMain: false,
                                        // optional. Shows only country name and flag
                                        showCountryOnly: false, hideMainText: false,
                                        padding: EdgeInsets.only(
                                            right: SizeConfig.blockSizeHorizontal),
                                        textStyle: TextStyle(
                                            fontSize:
                                            SizeConfig.blockSizeVertical * 1.5,
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
                              Container(
                                width: SizeConfig.screenWidth * 0.5,
                                margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.045,
                                ),
                                child: TextFormField(
                                  focusNode: phoneFn,
                                  controller: phoneController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.phone,
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
                                    phoneFn.unfocus();
                                    FocusScope.of(context).requestFocus(emailFn);
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
                          child: Text(
                            "Email",
                            style: TextStyle(color: Colors.black),
                          ),
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.screenHeight * 0.01),
                          margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.05),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.05,
                            right: SizeConfig.screenWidth * 0.05,
                          ),
                          child: TextFormField(
                            focusNode: emailFn,
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
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
                              emailFn.unfocus();
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
                              "Gender",
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
                              top: SizeConfig.blockSizeVertical,
                              bottom: SizeConfig.blockSizeVertical),
                          width: SizeConfig.screenWidth,
                          child: DropdownButtonFormField<Gender>(
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.all(SizeConfig.blockSizeHorizontal),
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
                            focusNode: genderFn,
                            hint: Text(
                              genderhint,
                              style: TextStyle(
                                fontSize: SizeConfig.blockSizeVertical * 1.5,
                              ),
                            ),
                            value: selectedGender,
                            onChanged: (Gender value) {
                              setState(() {
                                selectedGender = value;
                              });
                              genderFn.unfocus();
                            },
                            items: genders.map((Gender gender) {
                              return DropdownMenuItem<Gender>(
                                value: gender,
                                child: Text(
                                  gender.gender,
                                  style: TextStyle(
                                      fontSize: SizeConfig.blockSizeVertical * 1.5),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Address",
                            style: TextStyle(color: Colors.black),
                          ),
                          padding: EdgeInsets.only(
                              bottom: SizeConfig.screenHeight * 0.01),
                          margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.05),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                              bottom: SizeConfig.blockSizeVertical),
                          child: TextFormField(
                            focusNode: addressFn,
                            controller: addressController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
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
                              addressFn.unfocus();
                              FocusScope.of(context).requestFocus(cityFn);
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
                          margin:
                          EdgeInsets.only(left: SizeConfig.screenWidth * 0.05),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                              bottom: SizeConfig.blockSizeVertical),
                          child: TextFormField(
                            focusNode: cityFn,
                            controller: cityController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
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
                              cityFn.unfocus();
                              FocusScope.of(context).requestFocus(stateFn);
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
                                        bottom: SizeConfig.screenHeight * 0.01),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.35,
                                    height: SizeConfig.blockSizeVertical * 4.5,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5)),
                                    child: TextFormField(
                                      focusNode: stateFn,
                                      controller: stateController,
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
                                        stateFn.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(countryFn);
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
                              SizedBox(height: 10,),
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
                                     padding: EdgeInsets.symmetric(horizontal: 5),
                                        width: 189,
                                     height: SizeConfig.blockSizeVertical * 4.5,
decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),border: Border.all(color:Colors.black)),
                                        child: new DropdownButtonFormField(
decoration: InputDecoration.collapsed(hintText: ""),
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
                          margin: EdgeInsets.only(
                              left: SizeConfig.screenWidth * 0.05,
                              right: SizeConfig.screenWidth * 0.05,
                              top: SizeConfig.blockSizeVertical * 1.5),
                          child: MaterialButton(
                            color: Color(0XFFfee715),
                            onPressed: () {setState(() {

                              isLoading=true;
                            });
                            uploadImage();
                            },
                            child: isLoading ? CircularProgressIndicator(
                              valueColor:
                              new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            )
                                : Text("Save Changes"),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            minWidth: SizeConfig.screenWidth,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  Future<File> chooseCameraFile() async {
    await ImagePicker.platform
        .pickImage(
      source: ImageSource.camera,
    )
        .then((value) async {
      setState(() {
        FocusScope.of(context).unfocus();
        image = new File(value.path);
      });
      if (image.path != null) {}

    }).catchError((error) {
      print(error.toString());
    });
    return image;
  }

  Future<File> androidchooseImageFile() async {
    await ImagePicker.platform
        .pickImage(
      source: ImageSource.gallery,
    )
        .then((value) async {
      setState(() {
        FocusScope.of(context).unfocus();
        image = new File(value.path);
      });
      if (image.path != null) {}
    }).catchError((error) {
      print(error.toString());
    });
    return image;
  }

  dynamic profile = List();
  Future<void> getprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     token = prefs.getString("usertoken");
    try {
      final response = await http.post(Uri.parse(userprofile), headers: {
        'Authorization': 'Bearer $token',
      });
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        profile = responseJson['data'];
        if(profile['image']==null){
          imagefromserver=null;
        }else{
         setState(() {
           imagefromserver=profile['image'].toString();
           print('adjkdaasdsansan'+imagefromserver);
         });
        }
        // print(loginwithserver['data']['email']);
        print(profile);
        fullNameController = TextEditingController(text: profile["full_name"]);
        // businessNameController =
        //     TextEditingController(text: profile["business_name"]);
        phoneController =
            TextEditingController(text: profile["phone_number"].toString());
        // alternativePhoneController = TextEditingController(
        //     text: profile["alternative_phone_number"].toString());

        // experienceController = TextEditingController(
        //     text: profile["years_of_experience"].toString());
        //  streetController = TextEditingController(text: profile["street_name"]);
        cityController = TextEditingController(text: profile["city"]);
        stateController = TextEditingController(text: profile["state"]);
        countryController = TextEditingController(text: profile["country"]);
        // buildingController =
        //     TextEditingController(text: profile["building_description"]);
        usernameController = TextEditingController(text: profile["name"]);
        emailController = TextEditingController(text: profile["email"]);
        addressController = TextEditingController(text: profile["address"]);
       _mySelection=profile['country'];
        genderhint=profile['gender'];
        // selectedGender = selectedGender(gender: 'Male');
        //  phoneController=TextEditingController(text: profile["phone_number"]);
        // Navigator.of(context).pushNamed('/CustomerLogin');
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
  Future<dynamic> uploadImage() async {
    if (image == null) {
      print("mkflfae");
      var url = userupdateprofile;
      Map<String, String> headers = { 'Authorization': 'Bearer $token',};
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);


      request.fields['full_name'] = fullNameController.text;
      request.fields['phone_number'] = phoneController.text;
      request.fields['name'] = usernameController.text;
      request.fields['email'] = emailController.text;
      request.fields['gender'] = selectedGender==null?genderhint:selectedGender.gender;
      request.fields['state'] = stateController.text;
      request.fields['address'] = addressController.text;
      request.fields['city'] = cityController.text;
      request.fields['country'] = _mySelection;
      request.fields['country_code'] = "+91";

      var res = await request.send();
      if (res.statusCode == 200) {
        setState(() {
          isLoading = true;
        });
        Fluttertoast.showToast(
            msg: "Profile Succesfully Uploaded",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[400],
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      } else {
        setState(() {
          isLoading = true;
        });
        Fluttertoast.showToast(
            msg: "Something Went Wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return res.reasonPhrase;
    }
    else {
      var url = userupdateprofile;
      Map<String, String> headers = { 'Authorization': 'Bearer $token',};
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      request.files.add(await http.MultipartFile.fromPath(
        'profile_image',
        image.path,
      ));

      request.fields['full_name'] = fullNameController.text;
      request.fields['phone_number'] = phoneController.text;
      request.fields['name'] = usernameController.text;
      request.fields['email'] = emailController.text;
      request.fields['gender'] = selectedGender==null?genderhint:selectedGender.gender;
      request.fields['state'] = stateController.text;
      request.fields['address'] = addressController.text;
      request.fields['city'] =  cityController.text;
      request.fields['country'] = _mySelection;
      request.fields['country_code'] = "+91";

      var res = await request.send();
      if (res.statusCode == 200) {
        setState(() {
          isLoading = true;
        });
        Fluttertoast.showToast(
            msg: "Profile Succesfully Uploaded",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[400],
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
      } else {
        setState(() {
          isLoading = true;
        });
        Fluttertoast.showToast(
            msg: "Something Went Wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      return res.reasonPhrase;

    }
    //  print(sellerid);
    setState(() {
      isLoading = true;
    });
  }}

class Gender {
  const Gender({this.gender});
  final String gender;
}
