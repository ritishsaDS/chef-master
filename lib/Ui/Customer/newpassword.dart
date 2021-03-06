import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:http/http.dart';

class NewPasswordCust extends StatefulWidget {
  String phone;
   NewPasswordCust({this.phone}) ;

  @override
  _NewPasswordCustState createState() => _NewPasswordCustState();
}

class _NewPasswordCustState extends State<NewPasswordCust> {

  TextEditingController fgPwd = TextEditingController();
  TextEditingController rePwd = TextEditingController();
bool isError = false;
 bool isLoading = false;
  FocusNode fgPwdFn;
  FocusNode rePwdFn;
  GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fgPwdFn = FocusNode();
    rePwdFn = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    fgPwdFn.dispose();
    rePwdFn.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg/bg .png'),
                fit: BoxFit.fill,
              )),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Form(
              key: signUpFormKey,
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
                      top: SizeConfig.screenHeight * 0.15,
                    ),
                    height: SizeConfig.screenHeight * 0.4,
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
                                'Forgot Password',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.04,
                        ),
                        Form(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "New Password",
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
                                  focusNode: fgPwdFn,
                                  controller: fgPwd,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                                      isDense: true,
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
                                    fgPwdFn.unfocus();
                                    FocusScope.of(context)
                                        .requestFocus(rePwdFn);
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
                                  "Re-enter Password",
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
                                  focusNode: rePwdFn,
                                  controller: rePwd,
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                      contentPadding:
                                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
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
                                    rePwdFn.unfocus();
                                  },
                                  validator: (value) {
                                    if (value.isEmpty){
                                      return "This field is required";}
                                    else if(
                                    rePwd.text!=fgPwd.text
                                    ){
                                      return "Password MisMatch";
                                    }
                                    else{
                                      return null;}
                                  },
                                ),
                              ),
                              Container(
                                width: SizeConfig.screenWidth,
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockSizeVertical
                                ),
                                alignment: Alignment.center,
                                child: MaterialButton(
                                  onPressed: (){
                                    signup();
                                  },
                                  child: Text("Forgot"),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  color: Color(0XFFFEE715),
                                ),
                              ),
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
        ),
      ),
    ));
  }
  dynamic registerwithserver = new List();
  signup() async {

if(signUpFormKey.currentState.validate()){
  signUpFormKey.currentState.save();

      try {
        final response = await post(Uri.parse("https://royalgujarati.com/chief/public/api/user/reset-password"), body: {
          "phone_number":widget.phone, "secret_key":"6183", "password":rePwd.text, "confirm_password":fgPwd.text
        });
        print("bjkb" + response.statusCode.toString());
        if (response.statusCode == 200) {
          final responseJson = json.decode(response.body);

          registerwithserver = responseJson;
          // print(loginwithserver['data']['email']);
          print(registerwithserver);
          showToast("Password Update");
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
  }}
