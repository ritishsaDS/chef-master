import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/listTileMyFavourites.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFavourite extends StatefulWidget {
  const MyFavourite({Key key}) : super(key: key);

  @override
  _MyFavouriteState createState() => _MyFavouriteState();
}

class _MyFavouriteState extends State<MyFavourite> {
  bool breakfast = false;
  bool lunch = false;
  bool dinner = false;
  bool isLoading = false;
  bool isError = false;
  @override
  void initState() {
    getWishlistfroserver();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFFFEE715),
        title: Text("My Favourite",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),),
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Customerbottom(index:0),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0XFFFEE715),
                      width: 1.5
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              margin: EdgeInsets.only(
                left: SizeConfig.screenWidth * 0.05,
                right: SizeConfig.screenWidth * 0.05,
                top: SizeConfig.blockSizeVertical * 2,
              ),
              height: SizeConfig.blockSizeVertical * 5,
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width:SizeConfig.screenWidth * 0.2,
                    padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: SizeConfig.blockSizeVertical * 1.5,
                        ),
                      ),
                      cursorColor: Colors.black,
                    ),
                  ),
                  Container(
                    color: Color(0XFFFEE715),
                    width: SizeConfig.blockSizeHorizontal * 10,
                    height: SizeConfig.blockSizeVertical * 5,
                    padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                    child: Align(child: Icon(Icons.search,color: Colors.black,),
                      alignment: Alignment.center,),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.screenWidth * 0.05,
                  right: SizeConfig.screenWidth * 0.05,
                  top: SizeConfig.blockSizeVertical
              ),
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    minWidth: SizeConfig.screenWidth * 0.28,
                    height: SizeConfig.blockSizeVertical * 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: breakfast==true?Color(0XFFfee715):Colors.white,
                    onPressed: (){
                      setState(() {
                        lunch = false;
                        breakfast = true;
                        dinner = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Image.asset('assets/icons/breakfast icon.png'),
                        Image.asset('assets/icons/breakfast icon.png',
                          height: SizeConfig.blockSizeVertical * 2,),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal,
                        ),
                        Text("Breakfast",style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 1.5,
                            fontWeight: breakfast==true?FontWeight.bold:FontWeight.normal
                        ),),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: SizeConfig.screenWidth * 0.28,
                    height: SizeConfig.blockSizeVertical * 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: lunch==true?Color(0XFFfee715):Colors.white,
                    onPressed: (){
                      setState(() {
                        lunch = true;
                        breakfast = false;
                        dinner = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Image.asset('assets/icons/breakfast icon.png'),
                        Image.asset('assets/icons/lunch icon.png',
                          height: SizeConfig.blockSizeVertical * 2,),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal,
                        ),
                        Text("Lunch",style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 1.5,
                            fontWeight: lunch==true?FontWeight.bold:FontWeight.normal
                        ),),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: SizeConfig.screenWidth * 0.28,
                    height: SizeConfig.blockSizeVertical * 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: dinner==true?Color(0XFFfee715):Colors.white,
                    onPressed: (){
                      setState(() {
                        dinner = true;
                        breakfast = false;
                        lunch = false;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //Image.asset('assets/icons/breakfast icon.png'),
                        Image.asset('assets/icons/dinner icon.png',
                          height: SizeConfig.blockSizeVertical * 2,),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal,
                        ),
                        Text("Dinner",style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 1.5,
                            fontWeight: dinner==true?FontWeight.bold:FontWeight.normal
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: showFavouriteitem(),


            ),
          ],
        ),
      ),
    ));
  }


  dynamic wishlistarray = new List();
  void getWishlistfroserver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("usertoken");
    var Userid = prefs.getInt("Userid");
    print(token);
   // print(widget.id.toString());
    print(Userid.toString());
    var link="https://royalgujarati.com/chief/public/api/get_wishlist";
    try {
      final response = await post(Uri.parse(link),body: {

        "user_id":
        Userid.toString(),


      });
      print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        wishlistarray = responseJson['data'];
        //showToast("Dish Added to Wishlist Successfully");
        print(wishlistarray);

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

List<Widget>  showFavouriteitem() {
    List <Widget> wishlist=List();
    for(int i=0; i<wishlistarray.length;i++){
      wishlist.add(
        myFavouritesCard(context,wishlistarray[i]['name'],wishlistarray[i]['id'],wishlistarray[i]['image'],wishlistarray[i]['price'],wishlistarray[i]["time_taken"],),
      );
    }
    return wishlist;
}

}
