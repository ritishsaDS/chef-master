import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chef/Driver/DriverLogin.dart';
import 'package:flutter_chef/Driver/DriverRegister.dart';
import 'package:flutter_chef/Ui/Customer/Login.dart';
import 'package:flutter_chef/Ui/Customer/SignUp.dart';
import 'package:flutter_chef/Ui/Signup2cook.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

import 'LoginScreen.dart';

class SignUpCook extends StatefulWidget {
  @override
  _SignUpCookState createState() => _SignUpCookState();
}

class _SignUpCookState extends State<SignUpCook> {
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  Gender selectedGender;
  List<Gender> genders = <Gender>[
    const Gender(gender: 'Male'),
    const Gender(gender: 'Female'),
    const Gender(gender: 'Other')
  ];

  DateTime selectedDob = DateTime.now();
  String date = DateTime.now().toString();
  bool isLoading = false;
  bool isError = false;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController alternativePhoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController summarycontroller = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController buildingController = TextEditingController();
  TextEditingController gpsController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController cPwdController = TextEditingController();

  FocusNode fullNameFocusNode;
  FocusNode businessNameFocusNode;
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
  LatLng latlong = null;
  CameraPosition _cameraPosition;
  GoogleMapController _controller;
  Set<Marker> _markers = {};
  List<Address> results = [];
  @override
  void initState() {
    updateprofile();
    // TODO: implement initState
    super.initState();
    fullNameFocusNode = FocusNode();
    businessNameFocusNode = FocusNode();
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
    // getCurrentLocation();
  }

  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != PermissionStatus.granted) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission != PermissionStatus.granted) getLocation();
      return;
    }
    getLocation();
  }

  getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);

    setState(() {
      latlong =
      new LatLng(position.latitude, position.longitude); //change location
      _cameraPosition = CameraPosition(target: latlong, zoom: 10.0);
      if (_controller != null)
        _controller
            .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

      _markers.add(Marker(
          markerId: MarkerId("a"),
          draggable: true,
          position: latlong,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          onDragEnd: (_currentlatLng) {
            latlong = _currentlatLng;
          }));
    });

    getCurrentAddress();
  }
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CustomerSignUp()));
          break;
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpCook()));
          break;
        case 2:
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Driverregister()));

      }
    });
  }
  int _radioValue = 1;


  getCurrentAddress() async {
    final coordinates = new Coordinates(latlong.latitude, latlong.longitude);
    results = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = results.first;
    if (first != null) {
      var address;

      address = "${first.locality}";
      address = " $address, ${first.countryName}";
      address = " $address, ${first.postalCode}";
      print(first);
      gpsController.text = address.toString().replaceAll(" ", "").replaceAll("null", "");
      /* if (address.toString().contains("   null")) {
        address.toString().replaceAll("   null", "");
        gpsController.text = address;
      } else {
        gpsController.text = address;
      }*/
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameFocusNode.dispose();
    businessNameFocusNode.dispose();
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
  final String url = "http://chief.uplosse.com/api/country-list";
  var _mySelection;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
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
                                'Sign Up As Cook',
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
                                  "Full Name",
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
                                  focusNode: fullNameFocusNode,
                                  controller: fullNameController,
                                  maxLength: 256,
                                  buildCounter: (BuildContext context,
                                      {int currentLength,
                                        int maxLength,
                                        bool isFocused}) =>
                                  null,
                                  textCapitalization: TextCapitalization.words,
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
                                        .requestFocus(businessNameFocusNode);
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
                                  "Business Name",
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
                                  focusNode: businessNameFocusNode,
                                  controller: businessNameController,
                                  maxLength: 256,
                                  buildCounter: (BuildContext context,
                                      {int currentLength,
                                        int maxLength,
                                        bool isFocused}) =>
                                  null,
                                  textInputAction: TextInputAction.next,
                                  textCapitalization: TextCapitalization.words,
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
                                    businessNameFocusNode.unfocus();
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
                                          child: Text(
                                            "Phone",
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
                                margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.05,
                                  right: SizeConfig.screenWidth * 0.05,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            "Alternative Phone",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                          padding: EdgeInsets.only(
                                              bottom:
                                              SizeConfig.screenHeight * 0.01),
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockSizeVertical *
                                                  1.5),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
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
                                        Container(
                                          width: SizeConfig.screenWidth * 0.40,
                                          margin: EdgeInsets.only(
                                            left: SizeConfig.screenWidth * 0.045,
                                          ),
                                          child: TextFormField(
                                            focusNode: alternativePhoneFocusNode,
                                            buildCounter: (BuildContext context,
                                                {int currentLength,
                                                  int maxLength,
                                                  bool isFocused}) =>
                                            null,
                                            controller: alternativePhoneController,
                                            textInputAction: TextInputAction.next,
                                            keyboardType: TextInputType.phone,
                                            style: TextStyle(color: Colors.black),
                                            maxLength: 10,
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
                                              alternativePhoneFocusNode.unfocus();
                                              FocusScope.of(context)
                                                  .requestFocus(emailFocusNode);
                                            },
                                          ),
                                        ),
                                      ],
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
                                  buildCounter: (BuildContext context,
                                      {int currentLength,
                                        int maxLength,
                                        bool isFocused}) =>
                                  null,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(color: Colors.black),
                                  maxLength: 256,
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        "Gender",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.screenWidth * 0.05,
                                          top: SizeConfig.blockSizeVertical * 1.5),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.screenWidth * 0.35,
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            "DOB",
                                            style: TextStyle(color: Colors.black),
                                          ),
                                        ],
                                      ),
                                      margin: EdgeInsets.only(
                                          right: SizeConfig.screenWidth * 0.05,
                                          top: SizeConfig.blockSizeVertical * 1.5),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.3,
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
                                            errorStyle:
                                            TextStyle(color: Colors.red)),
                                        focusNode: genderFocusNode,
                                        hint: Text(
                                          "Select Gender",
                                          style: TextStyle(
                                            fontSize:
                                            SizeConfig.blockSizeVertical * 1.2,
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
                                                  SizeConfig.blockSizeVertical *
                                                      1.5),
                                              textAlign: TextAlign.center,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        selectDate(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: SizeConfig.screenWidth * 0.3,
                                        child: Text(
                                          "${selectedDob.month}" +
                                              "/" +
                                              "${selectedDob.day}" +
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
                                  ],
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
                                  child: isLoading
                                      ? CircularProgressIndicator(
                                    valueColor:
                                    new AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  )
                                      : Text("Next"),
                                  color: Color(0XFFfee715),
                                  onPressed: () {
    if (signUpFormKey.currentState.validate()) {
      signUpFormKey.currentState.save();
setState(() {
  isLoading=false;
});

        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp2Cook(name:fullNameController.text,business:businessNameController.text,phone:phoneController.text,alternative:alternativePhoneController.text,email:emailController.text,gender:selectedGender.gender,dob:selectedDob.toString())));


    }
    // Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp2Cook()));
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
                                                    1.09),
                                          )
                                        ],
                                      ),
                                      width: SizeConfig.screenWidth * 0.3,
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
                                                    1.09),
                                          )
                                        ],
                                      ),
                                      width: SizeConfig.screenWidth * 0.3,
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
                                        Navigator.of(context).pushNamed('/Login');
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
                ],
              ),
            ),
          ),
        ));
  }

  dynamic registerwithserver = new List();
  signup(fullname, bussinessname, phone, alternativephone, email, experience,
      street, city, state, country) async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.getString("device_id");
    print(selectedDob);
    // print("osnanl" + usernameString);
    // bool isvalid = EmailValidator.validate(usernameString);
    if (signUpFormKey.currentState.validate()) {
      signUpFormKey.currentState.save();

      setState(() {
        isLoading = true;
      });


      try {
        final response = await http.post(Uri.parse(register), body: {
          "full_name": fullNameController.text,
          "business_name": businessNameController.text,
          "country_code": "+91",
          "phone_number": phoneController.text,
          "email": emailController.text,
          "password": pwdController.text,
          "confirm_password": cPwdController.text,
          "gender": selectedGender.gender,
          "dob": selectedDob.toString(),
          "alternative_phone_number": alternativePhoneController.text,
          "years_of_experience": experienceController.text,
          "state": stateController.text,
          "city": cityController.text,
          "country": _mySelection,
          "street_name": streetController.text,
          "description": summarycontroller.text,
          "building_description": buildingController.text
        });
        print("bjkb" + response.statusCode.toString());
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
  dynamic updateprofilefromsever=new List();
  void updateprofile()async {
    print("update");

    try {
      final response = await http.get(Uri.parse(url));

      //  print("bjkb" + response.statusCode.toString());
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
      }
      else if(response.statusCode==400){
        showToast("Email Already Exist");
      }

      else {
        final responseJson = json.decode(response.body);
        print(responseJson.toString());
        print("bjkb" + response.statusCode.toString());



      }
    } catch (e) {
      print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}

class Gender {
  const Gender({this.gender});
  final String gender;
}