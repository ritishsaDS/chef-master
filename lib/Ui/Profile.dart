import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/NavigationBar.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_chef/Utils/Actionsheet.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();
  bool yesCheckbox = false;
  bool noCheckbox = false;
  Gender selectedGender;
  var gendervalue;
  List<Gender> genders = <Gender>[
    Gender(gender: 'Male'),
    Gender(gender: 'Female'),
    Gender(gender: 'Other')
  ];

  DateTime selectedDob = DateTime.now();
  String date = DateTime.now().toString();
var genderhint="";
  TextEditingController fullNameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
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
  TextEditingController summary = TextEditingController();
  LatLng latlong = null;
  CameraPosition _cameraPosition;
  GoogleMapController _controller;
  Set<Marker> _markers = {};
  List<Address> results = [];
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
var _mySelection;
  FocusNode cPwdFocusNode;
  bool isError = false;
  bool isLoading = false;
  var token;
  final String url = "http://chief.uplosse.com/api/country-list";

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

      address = " $address, ${first.locality}";
      address = " $address, ${first.countryName}";
      address = " $address, ${first.postalCode}";

      gpsController.text = address;
      gpsController.text = address.toString().replaceAll(" ", "").replaceAll("null", "");
    }
  }

  @override
  void initState() {
    updateprofile();
    getCurrentLocation();
    // TODO: implement initState
    super.initState();
    getprofile();
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
var imagefromserver;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
        //  bottomNavigationBar: navBar(4, context),
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
                              businessNameFocusNode.unfocus();
                              FocusScope.of(context).requestFocus(phoneFocusNode);
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
                          ),
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
                                  focusNode: phoneFocusNode,
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
                                    phoneFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(alternativePhoneFocusNode);
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
                          child: Container(
                            //todo: implement dropdown
                            child: Text(
                              "Alternative Phone",
                              style: TextStyle(color: Colors.black),
                            ),
                            padding: EdgeInsets.only(
                                bottom: SizeConfig.screenHeight * 0.01),
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockSizeVertical * 1.5),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.05,
                            right: SizeConfig.screenWidth * 0.05,
                          ),
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
                                  focusNode: alternativePhoneFocusNode,
                                  controller: alternativePhoneController,
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
                                    alternativePhoneFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(emailFocusNode);
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
                              emailFocusNode.unfocus();
                              FocusScope.of(context).requestFocus(genderFocusNode);
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "Gender",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    padding: EdgeInsets.only(
                                        bottom: SizeConfig.screenHeight * 0.01),
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.screenWidth * 0.05,
                                        top: SizeConfig.blockSizeVertical * 1.5),
                                  ),
                                  Container(
                                    width: SizeConfig.screenWidth * 0.35,
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.screenWidth * 0.05,
                                      right: SizeConfig.screenWidth * 0.05,
                                    ),
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
                                        genderhint,
                                        style: TextStyle(
                                            fontSize:
                                            SizeConfig.blockSizeVertical * 1.5),
                                      ),
                                      value: selectedGender,
                                      onChanged: (Gender value) {
                                        setState(() {
                                          selectedGender = value;
                                          print(selectedGender.gender);
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
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      "DOB",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    padding: EdgeInsets.only(
                                        bottom: SizeConfig.screenHeight * 0.01),
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.screenWidth * 0.05,
                                        top: SizeConfig.blockSizeVertical * 1.5),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      selectDate(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: SizeConfig.blockSizeVertical * 4,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey[800],
                                          ),
                                          borderRadius: BorderRadius.circular(5)),
                                      width: SizeConfig.screenWidth * 0.35,
                                      margin: EdgeInsets.only(
                                        left: SizeConfig.screenWidth * 0.05,
                                        right: SizeConfig.screenWidth * 0.05,
                                      ),
                                      child: Text(
                                        "${selectedDob.toLocal()}".split(' ')[0],
                                        style: TextStyle(
                                            fontSize:
                                            SizeConfig.blockSizeVertical * 1.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
                                hintText: "APPROX. YEARS OF EXPERIENCE AS A COOK",
                                hintStyle: TextStyle(
                                    fontSize: SizeConfig.blockSizeVertical * 1.5),
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
                              experienceFocusNode.unfocus();
                              FocusScope.of(context).requestFocus(streetFocusNode);
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
controller: summary,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                            maxLines: 3,
                            style: TextStyle(color: Colors.black),
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.only(top: 10.0, left: 4.0),
                                isDense: true,
                                hintText:
                                "PROVIDE SUMMARY OF YOUR PROFESSIONAL EXPEREINCE",
                                hintStyle: TextStyle(
                                    fontSize: SizeConfig.blockSizeVertical * 1.2),
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
                              experienceFocusNode.unfocus();
                              FocusScope.of(context).requestFocus(streetFocusNode);
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
                                width: SizeConfig.screenWidth * 0.26,
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
                                      fontSize: SizeConfig.blockSizeVertical * 1.5),
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth * 0.26,
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
                              streetFocusNode.unfocus();
                              FocusScope.of(context).requestFocus(cityFocusNode);
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
                              cityFocusNode.unfocus();
                              FocusScope.of(context).requestFocus(stateFocusNode);
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
                                     // focusNode: s,
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
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    height: SizeConfig.blockSizeVertical * 4.5,
                                    width: 189,
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
                            focusNode: buildingFocusNode,
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
                              buildingFocusNode.unfocus();
                              FocusScope.of(context).requestFocus(gpsFocusNode);
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
                              Container(
                                child: MaterialButton(
                                  color: Color(0XFFFEE715),
                                  minWidth: SizeConfig.screenWidth * 0.35,
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
                                width: SizeConfig.screenWidth * 0.35,
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
                        Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical,
                            left: SizeConfig.screenWidth * 0.05,
                            right: SizeConfig.screenWidth * 0.05,
                          ),
                          child: Text(
                            "Do you want your picture displayed to the customers",
                            style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockSizeVertical,
                            left: SizeConfig.screenWidth * 0.05,
                            right: SizeConfig.screenWidth * 0.05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.05,
                                    height: SizeConfig.screenHeight * 0.05,
                                    child: Checkbox(
                                      focusColor: Colors.black,
                                      hoverColor: Colors.black,
                                      checkColor: Colors.white,
                                      activeColor: Colors.black,
                                      value: yesCheckbox,
                                      onChanged: (value) => setState(() {
                                        yesCheckbox = !yesCheckbox;
                                      }),
                                    ),
                                  ),
                                  Text(
                                    " Yes",
                                    style: TextStyle(fontFamily: 'OpenSans'),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.screenWidth * 0.05,
                                    height: SizeConfig.screenHeight * 0.05,
                                    child: Checkbox(
                                      focusColor: Colors.black,
                                      hoverColor: Colors.black,
                                      checkColor: Colors.white,
                                      activeColor: Colors.black,
                                      value: noCheckbox,
                                      onChanged: (value) => setState(() {
                                        noCheckbox = !noCheckbox;
                                      }),
                                    ),
                                  ),
                                  Text(
                                    " No",
                                    style: TextStyle(fontFamily: 'OpenSans'),
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
                            bottom: SizeConfig.blockSizeVertical * 5,
                          ),
                          child: MaterialButton(
                              color: Color(0XFFfee715),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            minWidth: SizeConfig.screenWidth,
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

                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  dynamic profile = List();
  Future<void> getprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     token = prefs.getString("token");
    try {
      final response = await http.post(Uri.parse(chefprofile), headers: {
        'Authorization': 'Bearer $token',
      });
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        profile = responseJson['data'];
        if(profile['profile_image']==null){
          imagefromserver=null;
        }else{
          setState(() {
            imagefromserver=profile['profile_image'].toString();
            print('adjkdaasdsansan'+imagefromserver);
          });
        }
        // print(loginwithserver['data']['email']);
        print(profile);
        fullNameController = TextEditingController(text: profile["full_name"]);
        businessNameController =
            TextEditingController(text: profile["business_name"]);
        phoneController =
            TextEditingController(text: profile["phone_number"].toString());
        alternativePhoneController = TextEditingController(
            text: profile["alternative_phone_number"].toString());

        experienceController = TextEditingController(
            text: profile["years_of_experience"].toString());
        streetController = TextEditingController(text: profile["street_name"]);
        cityController = TextEditingController(text: profile["city"]);
        stateController = TextEditingController(text: profile["state"]);
        countryController = TextEditingController(text: profile["country"]);
        buildingController =
            TextEditingController(text: profile["building_description"]);
        summary=TextEditingController(text: profile['building_description']);
        emailController = TextEditingController(text: profile["email"]);
        _mySelection=profile['country'];
        genderhint=profile['gender'];
        if(profile['gender']=="Male"){
          print("vdas");
          selectedGender.gender="Male";
        }
        else{}
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
  File image;
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


  void updateprofile()async {
    print("update");

    try {
      final response = await http.get(Uri.parse(url));

      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        profile = responseJson['data'];

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

  dynamic updateprofilefromsever=new List();
  Future<dynamic> uploadImage() async {
    if (image == null) {
      print(selectedGender);

      Map<String, String> headers = { 'Authorization': 'Bearer $token',};
      var request = http.MultipartRequest('POST', Uri.parse(chefupdateprofile));
      request.headers.addAll(headers);


      request.fields['full_name'] = fullNameController.text;
      request.fields['phone_number'] = (phoneController.text);
      request.fields['business_name'] = businessNameController.text;
      request.fields['email'] = emailController.text;
     request.fields['gender'] = selectedGender==null?genderhint:selectedGender.gender;
     request.fields['years_of_experience'] = experienceController.text;
      request.fields['state'] = stateController.text;
      request.fields['street_name'] = streetController.text;
      request.fields['city'] = cityController.text;
      request.fields['country'] = countryController.text;
      request.fields['dob']="1999-12-12";
      request.fields['country_code'] = "91";

      var res = await request.send();
      print(res.statusCode);
      print(res.reasonPhrase);
      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Profile Succesfully Uploaded",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[400],
            textColor: Colors.white,
            fontSize: 16.0);
      //  Navigator.pop(context);
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
      print(image.path);
      var url = chefupdateprofile;
      Map<String, String> headers = { 'Authorization': 'Bearer $token',};
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      request.files.add(await http.MultipartFile.fromPath(
        'profile_image',
        image.path,
      ));

      request.fields['full_name'] = fullNameController.text;
      request.fields['phone_number'] = (phoneController.text);
      request.fields['business_name'] = businessNameController.text;
      request.fields['email'] = emailController.text;
      request.fields['gender'] = selectedGender==null?genderhint:selectedGender.gender;
      request.fields['years_of_experience'] = experienceController.text;
      request.fields['state'] = stateController.text;
      request.fields['street_name'] = streetController.text;
      request.fields['city'] = cityController.text;
      request.fields['country'] = countryController.text;
      request.fields['dob']="1999-12-12";
      request.fields['country_code'] = "91";

      var res = await request.send();
      print(res.statusCode);
      if (res.statusCode == 200) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(
            msg: "Profile Succesfully Uploaded",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[400],
            textColor: Colors.white,
            fontSize: 16.0);
       // Navigator.pop(context);
      } else {
        setState(() {
          isLoading = true;
        });
        Fluttertoast.showToast(
            msg: res.reasonPhrase,
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
   Gender({this.gender});
  String gender;
}
