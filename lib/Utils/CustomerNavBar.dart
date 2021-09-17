import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/Customer/Cust_Cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'Api.dart';

class Customerbottom extends StatefulWidget{
  Customerbottom({this.index});
  int index;
  @override
  _CustomerbottomState createState() => _CustomerbottomState();
}

class _CustomerbottomState extends State<Customerbottom> {
  bool  isError = true;
  bool isLoading = false;
  @override
  void initState(){
    getprofile();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return  CurvedNavigationBar(
     index: widget.index,
     height: 50.0,
     items: <Widget>[
       InkWell(
         child: ImageIcon(AssetImage('assets/icons/home icon.png')),
         onTap: () {
           Navigator.of(context).pushNamed('/CustomerHomePage');
         },
       ),
       InkWell(
         child: ImageIcon(AssetImage('assets/icons/cart icon.png')),
         onTap: () {
           Navigator.of(context).pushNamed('/Cart');
         },
       ),
       InkWell(
         child: ImageIcon(AssetImage('assets/icons/orders icon.png')),
         onTap: () {
           Navigator.of(context).pushNamed('/CustomerOrders');
         },
       ),
       InkWell(
         child: ImageIcon(AssetImage('assets/icons/wallet icon.png')),
         onTap: () {
           Navigator.of(context).pushNamed('/Wallet');
         },
       ),
       InkWell(child:         imagefromserver==null?    ImageIcon( AssetImage("assets/icons/profile icon.png")):Container(
    height: 40,
           width: 40,
           decoration: BoxDecoration(
    image: DecorationImage(
    image: NetworkImage(imagefromserver),
    fit: BoxFit.fill),
    shape: BoxShape.circle,)),

         onTap: (){
           Navigator.of(context).pushNamed('/CustomerProfile');
         },),


     ],

     color: Color(0XFFfee715),
     buttonBackgroundColor: Colors.white,
     backgroundColor: Colors.white,
     animationCurve: Curves.easeInOut,
     animationDuration: Duration(milliseconds: 600),
     onTap: (int i) {},
     letIndexChange: (index) => true,
   );
  }
  dynamic profile = List();
  var imagefromserver;
  Future<void> getprofile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var  token = prefs.getString("usertoken");
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
SharedPreferences prefs=await SharedPreferences.getInstance();
prefs.setString("Name", profile['name']);

        // alternativePhoneController = TextEditingController(
        //     text: profile["alternative_phone_number"].toString());

        // experienceController = TextEditingController(
        //     text: profile["years_of_experience"].toString());
        //  streetController = TextEditingController(text: profile["street_name"]);

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
}
