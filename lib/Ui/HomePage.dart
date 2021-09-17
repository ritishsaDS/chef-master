import 'dart:convert';
import 'dart:io';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:flutter_chef/Utils/Actionsheet.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/ListTileOrders.dart';
import 'package:flutter_chef/Utils/NavigationBar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'Customer/Login.dart';
import 'chefsearch.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var search;
  File _video;
  File _cameraVideo;
  bool isLoading=false;
  ImagePicker picker = ImagePicker();
  VideoPlayerController _videoPlayerController;
  VideoPlayerController _cameraVideoPlayerController;
  @override
  void initState() {
    getCookfromServer();
    print("hasc;jklasc"+currencyyy);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(Icons.more_vert,color: Colors.black,),
        centerTitle: true,
        title: ImageIcon(
          AssetImage('assets/icons/my dishes icon.png'),
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
            child: IconButton(icon:Icon(Icons.logout,color:Colors.black),onPressed: () async {
              SharedPreferences prefs=await SharedPreferences.getInstance();
              prefs.clear();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
            },)
          ),
        ],
      ),
     // bottomNavigationBar: navBar(0,context),
      drawer: Drawer(child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Color(0XFFFEE715),
            height: SizeConfig.screenHeight * 0.1,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 2,
                horizontal: SizeConfig.blockSizeHorizontal * 5
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text("June 10,2021",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeVertical * 1.50,
                      ),),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical,
                    ),
                    Text("Hi,Cook Name",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 2,
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),)
                  ],
                ),
                Container(
                  height: SizeConfig.screenHeight * 0.1,
                  width: SizeConfig.screenWidth * 0.1,
                  child: Icon(Icons.menu_rounded,size: SizeConfig.blockSizeVertical * 4,
                    color: Colors.black,),
                ),
              ],
            ),
          ),
          SizedBox(
            height: SizeConfig.blockSizeVertical * 4,
          ),
          ListTile(
            leading: Image.asset('assets/icons/my earnings icon.png',
              height: SizeConfig.blockSizeVertical * 4,),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
            title: Text("My Earnings",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
          ),
          ListTile(
            leading: Image.asset('assets/icons/orders icon.png',
              height: SizeConfig.blockSizeVertical * 4,),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
            title: Text("My Orders",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
          ),
          ListTile(
            leading: Image.asset('assets/icons/my dishes icon.png',
              height: SizeConfig.blockSizeVertical * 4,),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
            title: Text("My Dishes",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
          ),
          ListTile(
            leading: Image.asset('assets/icons/profile icon.png',
              height: SizeConfig.blockSizeVertical * 4,),
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
            title: Text("My Profile",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
          ),
          ListTile(
            leading: Image.asset('assets/icons/logout icon.png',
              height: SizeConfig.blockSizeVertical * 4,),
            onTap: (){
              Navigator.of(context).popAndPushNamed('/Login');
            },
            trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black,),
            title: Text("Logout",
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),),
          ),
        ],
      ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Container(child: Text("My Videos",
          style: TextStyle(
            fontSize: SizeConfig.blockSizeVertical * 2,
            fontWeight: FontWeight.bold,
          ),),
          alignment: Alignment.center,
          padding: EdgeInsets.all(SizeConfig.blockSizeVertical),),
      Container(
        width: SizeConfig.screenWidth,
        height: SizeConfig.screenHeight * 0.3,
        margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.05,
            vertical: SizeConfig.blockSizeVertical
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(
              color: Color(0XFFFEE715),
            )
        ),
        child: GestureDetector(
          onTap: (){
    // Navigator.pop(context);
   // FocusScope.of(context).unfocus();
    showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => ActionSheet()
        .actionSheet(context, onCamera: () {
    Navigator.pop(context);
    FocusScope.of(context).unfocus();
    _pickVideoFromCamera();
    }, onGallery: () {
    Navigator.pop(context);
    FocusScope.of(context).unfocus();
    _pickVideo();
    }, text: "Select Video"));

          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _video!=null? _videoPlayerController.value.isInitialized
                  ?Container(
                height:SizeConfig.screenHeight * 0.29 ,
                child: AspectRatio(
                  aspectRatio:MediaQuery.of(context).size.width/MediaQuery.of(context).size.height
                  ,
                  child: VideoPlayer(_videoPlayerController),
                ),
              ):_cameraVideo!=null?_cameraVideoPlayerController.value.isInitialized
                  ?Container(
                height:SizeConfig.screenHeight * 0.29 ,
                child: AspectRatio(
                  aspectRatio:
                  _cameraVideoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_cameraVideoPlayerController),
                ),
              ):Image.asset(
                  "assets/icons/user.png"):
              Text("Add Video",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 3,
                    color: Colors.grey
                ),):Text("Add  Video",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 3,
                    color: Colors.grey
                ),)
            ],
          ),
        ),

      ),

            Container(
              margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Color(0XFFFEE715),
                            width: 1.5
                        ),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    height: SizeConfig.blockSizeVertical * 4,
                    width: SizeConfig.blockSizeHorizontal * 35,
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockSizeVertical * 2
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:SizeConfig.screenWidth * 0.2,
                          padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Sort By",
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
                          width: SizeConfig.blockSizeHorizontal * 8,
                          height: SizeConfig.blockSizeVertical * 4,
                          padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                          child: Align(child: Icon(Icons.keyboard_arrow_down,color: Colors.black,),
                            alignment: Alignment.center,),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0XFFFEE715),
                        width: 1.5
                      ),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    height: SizeConfig.blockSizeVertical * 4,
                    width: SizeConfig.blockSizeHorizontal * 35,
                    margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeVertical * 2
                    ),
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
                            onChanged: (value){
                              setState(() {
                                search=value;
                              });
                            },
                            cursorColor: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                           Navigator.push(context,MaterialPageRoute(builder: (context)=>chefsearch(sort:search)));
                          },
                          child: Container(
                            color: Color(0XFFFEE715),
                            width: SizeConfig.blockSizeHorizontal * 8,
                            height: SizeConfig.blockSizeVertical * 4,
                            padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                            child: Align(child: Icon(Icons.search,color: Colors.black,),
                            alignment: Alignment.center,),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Image.asset('assets/bg/left line.png',),

                  width: SizeConfig.screenWidth * 0.42,),
                  Text("Orders",style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 2,
                    fontWeight: FontWeight.bold
                  ),),
                  Container(
                    child: Image.asset('assets/bg/right line.png',),

                    width: SizeConfig.screenWidth * 0.42,),
                ],
              ),
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
              children:
                getcookwidget()
               // listTileOrders(),
                // listTileOrders(),
                // listTileOrders(),
                // listTileOrders(),
                // listTileOrders(),
                // listTileOrders(),

            ),
          ],
        ),
      ),
    ));
  }
  _pickVideo() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
    _video = File(pickedFile.path);
    print(_video);
    uploadImage();
    _videoPlayerController = VideoPlayerController.file(_video)
      ..initialize().then((_) {
        setState(() {});
        _videoPlayerController.pause();
      });
  }

  // This funcion will helps you to pick a Video File from Camera
  _pickVideoFromCamera() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.camera);

    _cameraVideo = File(pickedFile.path);
    setState(() {
      _video = _cameraVideo;
    });
    print(_cameraVideo);
    if(_video==null){
      _cameraVideo=null;
    }
    else{
      _videoPlayerController = VideoPlayerController.file(_video)
        ..initialize().then((_) {
          setState(() {});
          _videoPlayerController.play();
        });
    }

    //  Navigator.pop(context);
  }
  dynamic updateprofilefromsever=new List();
  Future<dynamic> uploadImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(_video.path);

  var url="https://royalgujarati.com/chief/public/api/addvideo";
    Map<String, String> headers = { 'Authorization': 'Bearer ${preferences.getString('token')}',};
    var request = http.MultipartRequest('POST', Uri.parse(url));
request.headers.addAll(headers);

    request.files.add(await http.MultipartFile.fromPath(
      'video',
      _video.path,
    ));
    request.fields['user_id'] = preferences.getInt("chefid").toString();

    var res = await request.send();
    print("res.statusCode");
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
  dynamic cookfromserver = [];
  void getCookfromServer() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    try {
      final response = await http.post(Uri.parse("https://royalgujarati.com/chief/public/api/chef_order"),body: (
      {
        "chef_id":prefs.getInt("chefid").toString()
      }
      ));
      //   print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        cookfromserver = responseJson['data'];

        print(cookfromserver);

        setState(() {
          //isError = false;
          isLoading = false;
          print('setstate');
        });
      } else {
        print("bjkb" + response.statusCode.toString());
        // showToast("Mismatch Credentials");
        setState(() {
          //isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
       // isError = true;
        isLoading = false;
      });
    }
  }
  List<Widget> getcookwidget() {
    setState(() {
      isLoading = true;
    });

    List<Widget> productList = new List();
    for (int i = 0; i < cookfromserver.length; i++) {
      productList.add(GestureDetector(
        onTap:() {},

        child: listTileOrders(
          orderid:cookfromserver[i]['id'],
          dishname: cookfromserver[i]['name'],

        customername:  "",
         image: cookfromserver[i]['image'],
        )));
    }
    return productList;
  }
}
