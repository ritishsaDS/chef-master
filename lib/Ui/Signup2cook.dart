import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_chef/Ui/Customer/Login.dart';
import 'package:flutter_chef/Ui/Signup3cook.dart';
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
import 'package:flutter_chef/Utils/Constants.dart';
import 'LoginScreen.dart';

class SignUp2Cook extends StatefulWidget {
  String name;
  String business;
  String phone;
  String alternative;
  String email;
  String gender;
  String dob;
  SignUp2Cook({this.gender,this.email,this.name,this.business,this.dob,this.phone,this.alternative});
  @override
  _SignUp2CookState createState() => _SignUp2CookState();
}

class _SignUp2CookState extends State<SignUp2Cook> {
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
                                'Bussiness Info',
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
                                  "Years Of Experience",
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
                                  focusNode: experienceFocusNode,
                                  controller: experienceController,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(top: 10.0, left: 4.0),
                                      isDense: true,
                                      hintText:
                                      "APPROX. YEARS OF EXPERIENCE AS A COOK",
                                      hintStyle: TextStyle(
                                          fontSize:
                                          SizeConfig.blockSizeVertical * 1.5),
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
                                    experienceFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(streetFocusNode);
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
                                  "Currency",
                                  style: TextStyle(color: Colors.black),
                                ),
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.screenHeight * 0.01),
                                margin: EdgeInsets.only(
                                    left: SizeConfig.screenWidth * 0.05,
                                    top: SizeConfig.blockSizeVertical * 1.5),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0),border: Border.all(color:Colors.black)),

                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration.collapsed(hintText: ''),
                                  items: <String>['Pound', 'Euro', 'Dollar', 'Yen'].map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,

                                      child: new Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (newvalue) {
                                    setState(() {
                                     currencyyy=newvalue;
                                     print(currencyyy);
                                    });
                                  },
                                value: currencyyy,
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Summary Bio",
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
                                  //  focusNode: summarycontroller,
                                  controller: summarycontroller,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.multiline,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.only(top: 10.0, left: 4.0),
                                      isDense: true,
                                      hintText:
                                      "PROVIDE SUMMARY OF YOUR PROFESSIONAL EXPERIENCE",
                                      hintStyle: TextStyle(
                                          fontSize:
                                          SizeConfig.blockSizeVertical * 1.2),
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
                                    experienceFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(streetFocusNode);
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
                                  top: SizeConfig.blockSizeVertical * 2,
                                  bottom: SizeConfig.blockSizeVertical * 2,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.25,
                                      height: SizeConfig.blockSizeVertical * 0.1,
                                      color: Colors.grey,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: SizeConfig.blockSizeHorizontal,
                                        right: SizeConfig.blockSizeHorizontal,
                                      ),
                                      child: Text(
                                        "Business Address",
                                        style: TextStyle(
                                            fontSize:
                                            SizeConfig.blockSizeVertical * 1.5),
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.25,
                                      height: SizeConfig.blockSizeVertical * 0.1,
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Street Name",
                                  style: TextStyle(color: Colors.black),
                                ),
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.screenHeight * 0.01),
                                margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.05,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.05,
                                  right: SizeConfig.screenWidth * 0.05,
                                ),
                                child: TextFormField(
                                  focusNode: streetFocusNode,
                                  controller: streetController,
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
                                    streetFocusNode.unfocus();
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
                                  top: SizeConfig.blockSizeVertical * 1.5,
                                ),
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
                                  textCapitalization: TextCapitalization.words,
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
                                margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical,
                                  left: SizeConfig.screenWidth * 0.05,
                                  right: SizeConfig.screenWidth * 0.05,
                                ),
                                child: Text(
                                  'If no street address, use box below to describe the'
                                      ' building where the food will be cooked. Then click the '
                                      '"Gen GPS" button below.',
                                  style: TextStyle(
                                    fontSize: SizeConfig.blockSizeVertical * 1.5,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Describe Building",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    Text(
                                      "(Max. 2000 Characters)",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize:
                                          SizeConfig.blockSizeVertical * 1.3),
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
                                  focusNode: buildingFocusNode,
                                  textCapitalization: TextCapitalization.words,
                                  controller: buildingController,
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
                                    buildingFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(gpsFocusNode);
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth * 0.3,
                                      child: MaterialButton(
                                        color: Color(0XFFFEE715),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        onPressed: () {
                                          getCurrentLocation();
                                        },
                                        child: Text("Gen. GPS"),
                                      ),
                                    ),
                                    Container(
                                      width: SizeConfig.screenWidth * 0.34,
                                      margin: EdgeInsets.only(
                                        left: SizeConfig.screenWidth * 0.035,
                                      ),
                                      child: TextFormField(
                                        focusNode: gpsFocusNode,
                                        controller: gpsController,
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
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[800],
                                                  style: BorderStyle.solid,
                                                  width: 1.0),
                                            ),
                                            errorStyle:
                                            TextStyle(color: Colors.red)),
                                        onFieldSubmitted: (term) {
                                          gpsFocusNode.unfocus();
                                          FocusScope.of(context)
                                              .requestFocus(pwdFocusNode);
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
                              // Container(
                              //   child: Text(
                              //     "Password",
                              //     style: TextStyle(color: Colors.black),
                              //   ),
                              //   padding: EdgeInsets.only(
                              //       bottom: SizeConfig.screenHeight * 0.01),
                              //   margin: EdgeInsets.only(
                              //       left: SizeConfig.screenWidth * 0.05,
                              //       top: SizeConfig.blockSizeVertical * 1.5),
                              // ),
                              // Container(
                              //   margin: EdgeInsets.only(
                              //     left: SizeConfig.screenWidth * 0.05,
                              //     right: SizeConfig.screenWidth * 0.05,
                              //   ),
                              //   child: TextFormField(
                              //     focusNode: pwdFocusNode,
                              //     controller: pwdController,
                              //     textInputAction: TextInputAction.next,
                              //     keyboardType: TextInputType.text,
                              //     obscureText: true,
                              //
                              //     style: TextStyle(color: Colors.black),
                              //     cursorColor: Colors.black,
                              //     decoration: InputDecoration(
                              //         contentPadding:
                              //         EdgeInsets.only(top: 10.0, left: 4.0),
                              //         isDense: true,
                              //         floatingLabelBehavior:
                              //         FloatingLabelBehavior.always,
                              //         enabledBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Colors.grey[800],
                              //                 style: BorderStyle.solid,
                              //                 width: 1.0)),
                              //         focusedBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Colors.grey[800],
                              //                 style: BorderStyle.solid,
                              //                 width: 1.0)),
                              //         errorBorder: OutlineInputBorder(
                              //           borderSide: BorderSide(
                              //               color: Colors.grey[800],
                              //               style: BorderStyle.solid,
                              //               width: 1.0),
                              //         ),
                              //         focusedErrorBorder: OutlineInputBorder(
                              //           borderSide: BorderSide(
                              //               color: Colors.grey[800],
                              //               style: BorderStyle.solid,
                              //               width: 1.0),
                              //         ),
                              //         errorStyle: TextStyle(color: Colors.red),errorMaxLines: 5),
                              //
                              //     onFieldSubmitted: (term) {
                              //       pwdFocusNode.unfocus();
                              //       FocusScope.of(context)
                              //           .requestFocus(cPwdFocusNode);
                              //     },
                              //     validator: (value) {
                              //       if (value.isEmpty)
                              //         return "This field is required";
                              //       else if (validateStructure(value) == false) {
                              //         return " password must be at least 8 characters "
                              //             "must contain at least one uppercase, one lowercase, one Special Character and one digit.";
                              //       } else
                              //         return null;
                              //     },
                              //   ),
                              // ),
                              // Container(
                              //   child: Text(
                              //     "Re-enter Password",
                              //     style: TextStyle(color: Colors.black),
                              //   ),
                              //   padding: EdgeInsets.only(
                              //       bottom: SizeConfig.screenHeight * 0.01),
                              //   margin: EdgeInsets.only(
                              //       left: SizeConfig.screenWidth * 0.05,
                              //       top: SizeConfig.blockSizeVertical * 1.5),
                              // ),
                              // Container(
                              //   margin: EdgeInsets.only(
                              //     left: SizeConfig.screenWidth * 0.05,
                              //     right: SizeConfig.screenWidth * 0.05,
                              //   ),
                              //   child: TextFormField(
                              //     focusNode: cPwdFocusNode,
                              //     controller: cPwdController,
                              //     textInputAction: TextInputAction.next,
                              //     keyboardType: TextInputType.text,
                              //     obscureText: true,
                              //     style: TextStyle(color: Colors.black),
                              //     cursorColor: Colors.black,
                              //     decoration: InputDecoration(
                              //         contentPadding:
                              //         EdgeInsets.only(top: 10.0, left: 4.0),
                              //         isDense: true,
                              //         floatingLabelBehavior:
                              //         FloatingLabelBehavior.always,
                              //         enabledBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Colors.grey[800],
                              //                 style: BorderStyle.solid,
                              //                 width: 1.0)),
                              //         focusedBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Colors.grey[800],
                              //                 style: BorderStyle.solid,
                              //                 width: 1.0)),
                              //         errorBorder: OutlineInputBorder(
                              //           borderSide: BorderSide(
                              //               color: Colors.grey[800],
                              //               style: BorderStyle.solid,
                              //               width: 1.0),
                              //         ),
                              //         focusedErrorBorder: OutlineInputBorder(
                              //           borderSide: BorderSide(
                              //               color: Colors.grey[800],
                              //               style: BorderStyle.solid,
                              //               width: 1.0),
                              //         ),
                              //         errorStyle: TextStyle(color: Colors.red)),
                              //     onFieldSubmitted: (term) {
                              //       cPwdFocusNode.unfocus();
                              //     },
                              //     validator: (value) {
                              //       if (value.isEmpty)
                              //         return "This field is required";
                              //       else if (value != pwdController.text)
                              //         return "Password Mismatch";
                              //       else
                              //         return null;
                              //     },
                              //   ),
                              // ),
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
                                      : Text("Sign Up Now"),
                                  color: Color(0XFFfee715),
                                  onPressed: () {
    if (signUpFormKey.currentState.validate()) {
      signUpFormKey.currentState.save();
      if (_mySelection == null) {
        showToast("Please Select Country");
      }
      setState(() {
        isLoading = true;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Signup3Cook(
        experience:experienceController.text,
        summary:summarycontroller.text,
        street:streetController.text,
        city:cityController.text,
        state:stateController.text,
        country:_mySelection,
        building:buildingController.text,
          name    :widget.name,
          business:widget.business,
          phone   :widget.phone,
          alternative:widget.alternative,
          email    :widget.email,
          gender   :widget.gender,
          dob      :widget.dob


      )));
    }

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
      if(_mySelection==null){
        showToast("Please Select Country");
      }
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