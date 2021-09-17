import 'dart:convert';
import 'package:flutter_chef/Driver/DriverLogin.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/BottomNavigation.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

import 'Customer/Login.dart';
import 'Forgetchef.dart';



class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  FocusNode pwdFocusNode;
  FocusNode userFocusNode;
  bool _rememberMe = false;
  bool isLoading = false;
  bool isError = false;
  String usernameString = '';
  String passwordString = '';
 // bool isLoading = false;
  bool _isLoggedIn = false;
  GoogleSignInAccount _userObj;
  bool isLoggedIn = false;
  var profileData;
  Map userfb = {};
  //var facebookLogin = FacebookLogin();
  int _radioValue = 1;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  final signInKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
 // bool isError;
  TextEditingController pincontroller = TextEditingController();

 // bool isLoggedIn = false;
 // bool isLoading = false;
  //var profileData;

 // var facebookLogin = FacebookLogin();
  @override
  void initState() {
    super.initState();
    pwdFocusNode = FocusNode();
    userFocusNode = FocusNode();
  }

  @override
  void dispose() {
    pwdFocusNode.dispose();
    userFocusNode.dispose();
    super.dispose();
  }

  validate() {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      signin();
      // Navigator.of(context).pushNamed('/HomePage');
    } else {}
  }

  dynamic loginwithserver = new List();
  signin() async {
    print("kjxkavdk");
    try {
      final response = await http.post(Uri.parse(login), body: {
        "email": usernameController.text,
        "password": pwdController.text,
      });
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200)
      {
        final responseJson = json.decode(response.body);

        loginwithserver = responseJson;
        // print(loginwithserver['data']['email']);
        print(loginwithserver);

        SharedPreferences preferences = await SharedPreferences.getInstance();

        preferences.setString("token", loginwithserver['token']['original']['access_token']);
        preferences.setInt("chefid", loginwithserver['data'][0]['id']);
       // preferences.setString("token", loginwithserver['token']['original']['access_token']);
print(preferences.getInt("chefid"));
print( preferences.getString("token"));
          showToast("Login Successfully");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyBottomBarDemo()));
          preferences.setString("login", "cook");


        // showToast("");
        //savedata();
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
      } else {
        print("bjkb" + response.statusCode.toString());
        showToast("Mismatch Credentials");
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
          body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg/bg .png'),
                  fit: BoxFit.fill,
                )),
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
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
                  Center(child: Text("SignIn As: "),),
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
                      top: SizeConfig.screenHeight * 0.03,
                    ),
                    height: SizeConfig.screenHeight * 0.6,
                    width: SizeConfig.screenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            spreadRadius: 0.1,
                            blurRadius: 0.2,
                            offset: Offset.zero)
                      ],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/bg/login bg tile.png'),
                        fit: BoxFit.fill,
                      ),
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
                                'Sign in',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.07,
                        ),
                        Form(
                          key: loginFormKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "Email",
                                  style: TextStyle(color: Colors.black),
                                ),
                                padding: EdgeInsets.only(
                                    bottom: SizeConfig.screenHeight * 0.01),
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockSizeHorizontal * 8),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: SizeConfig.screenWidth * 0.05,
                                  right: SizeConfig.screenWidth * 0.05,
                                ),
                                child: TextFormField(
                                  focusNode: userFocusNode,
                                  controller: usernameController,
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
                                    userFocusNode.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(pwdFocusNode);
                                  },
                                  validator: (value) {
                                    if (value.isEmpty){
                                      setState(() {
                                        isLoading=false;
                                      });
                                      return "This field is required";
                                    }
                                    else
                                      return null;
                                  },
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
                                    left: SizeConfig.blockSizeHorizontal * 8,
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
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
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
                                    pwdFocusNode.unfocus();
                                  },
                                  validator: (value) {
                                    if (value.isEmpty){
                                      setState(() {
                                        isLoading=false;
                                      });
                                      return "This field is required";
                                    }
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
                                            value: _rememberMe,
                                            onChanged: (value) => setState(() {
                                              _rememberMe = !_rememberMe;
                                            }),
                                          ),
                                        ),
                                        Text(
                                          " Remember Me",
                                          style: TextStyle(fontFamily: 'OpenSans'),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgetPassword()));
                                        },
                                        child: Text("Forget?")),
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
                                  children: <Widget>[
                                    Text("Sign in with OTP"),
                                    Container(
                                      child: MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          validate();
                                          //  Navigator.of(context).pushNamed('/Home');
                                          //validate();
                                        },
                                        height: SizeConfig.blockSizeVertical * 4,
                                        child: isLoading
                                            ? CircularProgressIndicator(
                                          valueColor:
                                          new AlwaysStoppedAnimation<
                                              Color>(Colors.white),
                                        )
                                            : Text("SignIn"),
                                        color: Color(0XFFfee715),
                                      ),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/buttons/sign in button.png'),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  'Sign in with google',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                              Container(
                                height: SizeConfig.blockSizeVertical * 5,
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical * 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(onTap: (){
                                      googlelogin();
                                      // _googleSignIn.signIn().then((userData) {
                                      //   setState(() {
                                      //     _isLoggedIn = true;
                                      //     _userObj = userData;
                                      //     print(_userObj.displayName);
                                      //     if (_userObj.displayName != null) {
                                      //       // signup(_userObj.displayName, _userObj.email,
                                      //       //     "google");
                                      //     }
                                      //   });
                                      // }).catchError((e) {
                                      //   print(e);
                                      // });
                                    },
                                      child: Container(
                                        child: GestureDetector(
    onTap: (){
    googlelogin();},
                                          child: Image(
                                            image:
                                            AssetImage('assets/icons/google.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: SizeConfig.blockSizeHorizontal * 5,
                                    ),
                                    Image(
                                      image: AssetImage('assets/icons/fb.png'),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical * 2,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don't have an account? "),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .pushNamed('/SignUpCook');
                                      },
                                      child: Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
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
  // fblogin() {
  //   FacebookAuth.instance
  //       .login(permissions: ["public_profile", "email"]).then((value) {
  //     FacebookAuth.instance.getUserData().then((userDatas) {
  //       setState(() {
  //         userfb = userDatas;
  //         if (userDatas != null) {
  //           print(userDatas['email']);
  //           if (userDatas['email'] == null) {
  //             showDialog(
  //                 context: context,
  //                 builder: (BuildContext context) {
  //                   return AlertDialog(
  //                     title: Text("Math App Says-\nAuthentication Failed "),
  //                     content: Container(
  //                       height: 100,
  //                       child: Column(
  //                         children: [
  //                           ElevatedButton(
  //                               onPressed: () {},
  //                               child: Text("SignUP Manually"))
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 });
  //           } else {}
  //           //
  //         }

  //         print(userDatas);
  //       });
  //     });
  //   });
  // }

  googlelogin() {
    print("jejk");
    _googleSignIn.signIn().then((userData) {
      setState(() async {
        _isLoggedIn = true;
        _userObj = userData;
        print("jejjjnkjnkek");
        print(_userObj.displayName);
        if (_userObj.displayName != null) {
          // try {
          //   final response = await http.post(checklogin, body: {
          //     "email": _userObj.email,
          //     // "password": "1234",
          //   });
          //   print("bjkb" + response.statusCode.toString());
          //   if (response.statusCode == 200) {
          //     final responseJson = json.decode(response.body);
          //
          //     loginwithserver = responseJson;
          //     print(loginwithserver);
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => PinField(
          //                 email: _userObj.email,
          //                 message: loginwithserver['message'])));
          //     // showToast("");
          //     // savedata();
          //     setState(() {
          //       isError = false;
          //       isLoading = false;
          //       print('setstate');
          //     });
          //   } else {
          //     print("bjkb" + response.statusCode.toString());
          //     showToast("Mismatch Credentials");
          //     setState(() {
          //       isError = true;
          //       isLoading = false;
          //     });
          //   }
          // } catch (e) {
          //   print(e);
          //   setState(() {
          //     isError = true;
          //     isLoading = false;
          //   });
          // }
          // signup(_userObj.displayName, _userObj.email,
          //     "google");
        }
      });
    }).catchError((e) {
      print(e);
    });
  }
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
          break;
        case 1:
          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
          break;
        case 2:
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DriverLogin()));

      }
    });
  }
}
