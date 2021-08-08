import 'dart:convert';
import 'package:flutter_chef/Ui/Customer/forgetcust.dart';
import 'package:flutter_chef/Ui/HomePage.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Api.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  FocusNode pwdFocusNode;
  FocusNode userFocusNode;
  bool _rememberMe = false;
  bool isLoading = false;
  bool isError = false;
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
    } else {}
  }

  dynamic loginwithserver = new List();
  signin() async {
    try {
      final response = await http.post(Uri.parse(loginuser), body: {
        "email": usernameController.text,
        "password": pwdController.text,
      });

      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        loginwithserver = responseJson;
        // print(loginwithserver['data']['email']);
        print(loginwithserver);

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("usertoken", loginwithserver['access_token']);

        preferences.setString("login", "/CustomerLogin");
        showToast("Login Succesfully");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => CustomerHomePage())); // showToast("");
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
                                    if (value.isEmpty)
                                      return "This field is required";
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
                                    GestureDetector(onTap:(){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgetPasswordCust()));
                                    },child: Text("Forget?")),
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
                                    Container(
                                      child: Image(
                                        image:
                                        AssetImage('assets/icons/google.png'),
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
                                            .pushNamed('/CustomerSignUp');
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
}
