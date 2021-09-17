import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chef/Ui/Customer/newpassword.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

class ForgetPasswordCust extends StatefulWidget {
  const ForgetPasswordCust({Key key}) : super(key: key);

  @override
  _ForgetPasswordCustState createState() => _ForgetPasswordCustState();
}

class _ForgetPasswordCustState extends State<ForgetPasswordCust> {

  GlobalKey<FormState> forgotKey = GlobalKey<FormState>();
  String phoneNo;
  String btn="Send OTP";
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController phn = TextEditingController();
  TextEditingController otp = TextEditingController();

  FocusNode phnFn;
  FocusNode otpFn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phnFn = FocusNode();
    otpFn = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    phnFn.dispose();
    otpFn.dispose();
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
                                "Phone No.",
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
                                focusNode: phnFn,
                                controller: phn,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(color: Colors.black),
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                                    isDense: true,
                                    hintText: "Enter Phone No.",
                                    hintStyle: TextStyle(
                                        fontSize: SizeConfig.blockSizeVertical * 1.5
                                    ),
                                    suffixIcon: Container(
                                      margin: EdgeInsets.only(
                                          right: SizeConfig.blockSizeHorizontal * 2
                                      ),
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        onPressed: (){
                                          verifyPhone();
                                        },
                                        child: Text(btn),
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        padding: EdgeInsets.all(2),
                                        color: Color(0XFFFEE715),
                                        height: SizeConfig.blockSizeVertical,
                                      ),
                                    ),
                                    suffixIconConstraints: BoxConstraints(
                                        maxHeight: SizeConfig.blockSizeVertical * 3,
                                        maxWidth: SizeConfig.screenWidth * 0.25,
                                        minHeight: SizeConfig.blockSizeVertical * 3,
                                        minWidth: SizeConfig.screenWidth * 0.25
                                    ),
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
                                onChanged: (value){
                                  setState(() {
                                    phoneNo=value;
                                    print(value);
                                  });
                                },
                                onFieldSubmitted: (term) {
                                  phnFn.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(otpFn);
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
                              child: GestureDetector(
                               onTap: (){
                                 print("onwejon");
                                 verifyPhone();
                               },
                                child: Text(
                                  "Enter OTP",
                                  style: TextStyle(color: Colors.black),
                                ),
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
                                focusNode: otpFn,
                                controller: otp,
                                textInputAction: TextInputAction.done,

                                keyboardType: TextInputType.number,
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
                                  otpFn.unfocus();
                                },
                                onChanged: (val){
                                  setState(() {
                                    smsOTP=val;
                                  });
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
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockSizeVertical
                              ),
                              alignment: Alignment.center,
                              child: MaterialButton(
                                onPressed: (){
                               //   Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));
                                  signIn();
                                  // _auth.currentUser().then((user) {
                                  //   if (user != null) {
                                  //    // Navigator.of(context).pop();
                                  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust()));
                                  //
                                  //   } else {
                                  //     signIn();
                                  //   }
                                  // });

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
    ));
  }


  Future<void> verifyPhone() async {
    final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
     setState(() {
       btn="Resend OTP";
     });
      // smsOTPDialog(context).then((value) {
      //   print('sign in');
      // });
    };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            //Starts the phone number verification process for the given phone number.
            //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
            this.verificationId = verId;
          },
          codeSent:
          smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 20),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },

          verificationFailed: (AuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e);
    }
  }

  Future<bool> smsOTPDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter SMS Code'),
            content: Container(
              height: 85,
              child: Column(children: [
                TextField(
                  onChanged: (value) {
                    this.smsOTP = value;
                  },
                ),
                (errorMessage != ''
                    ? Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red),
                )
                    : Container())
              ]),
            ),
            contentPadding: EdgeInsets.all(10),
            actions: <Widget>[
              FlatButton(
                child: Text('Done'),
                onPressed: () {
                  _auth.currentUser().then((user) {
                    if (user != null) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));


                      // Navigator.of(context).pop();
                      // Navigator.of(context).pushReplacementNamed('/homepage');
                    } else {
                     // Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));

                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.getCredential(
        verificationId: verificationId,
        smsCode: smsOTP,
      );
      final FirebaseUser user = (await _auth.signInWithCredential(credential)) as FirebaseUser;
      final FirebaseUser currentUser = await _auth.currentUser();
      assert(user.uid == currentUser.uid);
     Navigator.push(context, MaterialPageRoute(builder: (context)=>NewPasswordCust(phone:phoneNo)));
    //  Navigator.of(context).pushReplacementNamed('/homepage');
    } catch (e) {
      handleError(e);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(new FocusNode());
        setState(() {
          errorMessage = 'Invalid Code';
        });
        Navigator.of(context).pop();
        smsOTPDialog(context).then((value) {
          print('sign in');
        });
        break;
      default:
        setState(() {
          errorMessage = error.message;
        });

        break;
    }
  }
}