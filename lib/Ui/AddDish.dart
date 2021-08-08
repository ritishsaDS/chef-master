import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Actionsheet.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/NavigationBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/adddishrepo.dart';
import 'package:flutter_chef/Utils/listTileAddDish.dart';
import 'package:flutter_chef/Utils/models/adddishmodule.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class AddDish extends StatefulWidget {
  const AddDish({Key key}) : super(key: key);

  @override
  _AddDishState createState() => _AddDishState();
}

class _AddDishState extends State<AddDish> {
  final addusernotesrepo = Adddishrepo();
  bool breakfast = false;
  bool lunch = false;
  bool dinner = false;
  var full;
  String name;
  String description;
  String price;
  String timeTaken;
  String status;
  List cat=[];
  String category;
  List<dishIngredient> ingredient = [];
  var nameTECs = <TextEditingController>[];
  var ageTECs = <TextEditingController>[];
  var jobTECs = <TextEditingController>[];
  var cards = <Card>[];

  final _formKey = GlobalKey<FormState>();

String ingredientnamestring;
  String quantitystring;
  String unitsstrimg;
  String requiredstring;

  List <String> ingredientname=[];
  List <String> quantity=[];
  List <String> units=[];
  List <int> required=[];
  // _onDone() {

  //   List<PersonEntry> entries = [];
  //   for (int i = 0; i < cards.length; i++) {
  //     var name = nameTECs[i].text;
  //     var age = ageTECs[i].text;
  //     var job = jobTECs[i].text;
  //     entries+= (PersonEntry(name, age, job));
  //     print(entries);
  //
  //
  // }
   // Navigator.pop(context, entries);

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var jobController = TextEditingController();
  File _image;
  File _cameraImage;
  File _video;
  File _cameraVideo;
bool isLoading=false;
  ImagePicker picker = ImagePicker();

  VideoPlayerController _videoPlayerController;
  VideoPlayerController _cameraVideoPlayerController;

  // This funcion will helps you to pick and Image from Gallery
  _pickImageFromGallery() async {
    PickedFile pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    File image = File(pickedFile.path);
print(image);
    setState(() {
      _image = image;
    });
  }

  // This funcion will helps you to pick and Image from Camera
  _pickImageFromCamera() async {
    PickedFile pickedFile =
    await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    File image = File(pickedFile.path);
    print(image);
    setState(() {
      _cameraImage = image;
    });
  }

  // This funcion will helps you to pick a Video File
  _pickVideo() async {
    PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
    _video = File(pickedFile.path);
    print(_video);
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

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    cards.add(createCard());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0XFFFEE715),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text("Add New Dish",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),),
      ),
    //  bottomNavigationBar: navBar(1, context),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.blockSizeVertical * 5,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                border: Border.all(
                  color: Color(0XFFFEE715),
                )
              ),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Dish Name",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onChanged: (value){
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
            GestureDetector(
              onTap: (){
                showAlertDialog(context);
                },
              child: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _image != null
                        ? Image.file(
                        File(_image.path,),height: SizeConfig.screenHeight * 0.29,width:SizeConfig.screenWidth,fit: BoxFit.fitWidth,)
                        : _video!=null? _videoPlayerController.value.isInitialized
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
                    Text("Add Dish Image/Video",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 3,
                      color: Colors.grey
                    ),):Text("Add Dish Image/Video",
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
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Image.asset('assets/icons/delete icon.png',
                  // height: SizeConfig.blockSizeVertical * 2.5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Time   ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color(0XFFFEE715),
                          )
                        ),
                        width: SizeConfig.screenWidth * 0.3,
                        height: SizeConfig.blockSizeVertical * 5,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(

                            border: InputBorder.none,
                           contentPadding: EdgeInsets.all(15)
                          ),

                          cursorColor: Colors.black,
                          cursorHeight: SizeConfig.blockSizeVertical * 2,
                          onChanged: (value){
                            setState(() {
                              timeTaken=value;
                            });
                          },
                        ),
                      ),
                    ],
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
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical,
                      right: SizeConfig.blockSizeHorizontal,
                    ),
                    width: SizeConfig.screenWidth * 0.35,),
                  Text("Ingredients",style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      fontWeight: FontWeight.bold
                  ),),
                  Container(
                    child: Image.asset('assets/bg/right line.png',),
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical,
                      left: SizeConfig.blockSizeHorizontal,
                    ),
                    width: SizeConfig.screenWidth * 0.35,),
                ],
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [

                Container(
                  height: 200,
                  child: ListView.builder(
                    itemCount: cards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return cards[index];
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical
                  ),
                  child: MaterialButton(onPressed: (){
                    setState(() => cards.add(createCard()));
                  },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                  minWidth: SizeConfig.screenWidth,
                  color: Colors.white,
                  child: Text("Add Ingredient",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * 0.05,
                    vertical: SizeConfig.blockSizeVertical
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: Color(0XFFFEE715),
                    ),
                    color: Colors.white
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Your Comments Here",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 1.50
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: SizeConfig.blockSizeVertical,
                        horizontal: SizeConfig.screenWidth * 0.05
                      )
                    ),
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Container(
                      //   width:SizeConfig.screenWidth * 0.3,
                      //   child: CheckboxListTile(value: breakfast, onChanged: (value){
                      //     setState(() {
                      //       breakfast = value;
                      //     });
                      //   },
                      //   dense: true,
                      //   title: Text("Breakfast",style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: SizeConfig.blockSizeVertical * 1.25
                      //   ),),
                      //   activeColor: Colors.black,
                      //   checkColor: Colors.white,
                      //     contentPadding: EdgeInsets.zero,
                      //     controlAffinity: ListTileControlAffinity.leading,
                      //   ),
                      // ),
                      // Container(
                      //   width:SizeConfig.screenWidth * 0.3,
                      //   child: CheckboxListTile(value: lunch, onChanged: (value){
                      //     setState(() {
                      //       lunch = value;
                      //     });
                      //   },
                      //     dense: true,
                      //     title: Text("Lunch",style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: SizeConfig.blockSizeVertical * 1.25
                      //     ),),
                      //     activeColor: Colors.black,
                      //     checkColor: Colors.white,
                      //     contentPadding: EdgeInsets.zero,
                      //     controlAffinity: ListTileControlAffinity.leading,
                      //   ),
                      // ),
                      // Container(
                      //   width:SizeConfig.screenWidth * 0.3,
                      //   child: CheckboxListTile(value: dinner, onChanged: (value){
                      //     setState(() {
                      //       dinner = value;
                      //     });
                      //   },
                      //     dense: true,
                      //     title: Text("Dinner",style: TextStyle(
                      //         color: Colors.black,
                      //         fontSize: SizeConfig.blockSizeVertical * 1.25
                      //     ),),
                      //     activeColor: Colors.black,
                      //     checkColor: Colors.white,
                      //     contentPadding: EdgeInsets.zero,
                      //     controlAffinity: ListTileControlAffinity.leading,
                      //   ),
                      // )
                      InkWell(
                        onTap: (){
                          if(breakfast == true)
                            setState(() {
                              breakfast = false;
                            });
                          else
                            setState(() {
                              breakfast = true;
                            });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                activeColor: Colors.black,
                                checkColor: Colors.white,
                                value: breakfast,
                                onChanged: (value){
                                  setState(() {

                                    breakfast = value;
                                    cat.add("Breakfast");
                                  });
                                },
                              ),
                              Text("Breakfast")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      InkWell(
                        onTap: (){
                          if(lunch == true)
                            setState(() {
                              lunch = false;
                            });
                          else
                            setState(() {
                              breakfast=false;
                              dinner=false;
                              lunch = true;
                            });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                activeColor: Colors.black,
                                checkColor: Colors.white,
                                value: lunch,
                                onChanged: (value){
                                  setState(() {

                                    lunch = value;
                                    cat.add("lunch");
                                  });
                                },
                              ),
                              Text("Lunch")
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      InkWell(
                        onTap: (){
                          if(dinner == true)
                            setState(() {
                              dinner = false;
                            });
                          else
                            setState(() {

                              dinner = true;
                            });
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Checkbox(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                activeColor: Colors.black,
                                checkColor: Colors.white,
                                value: dinner,
                                onChanged: (value){
                                  setState(() {

                                    dinner = value;
                                    cat.add("dinner");
                                  });
                                },
                              ),
                              Text("Dinner")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical,
                    horizontal: SizeConfig.screenWidth * 0.05,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0XFFFEE715),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: SizeConfig.blockSizeVertical * 6,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.2,
                      ),
                      Text("PRICE",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.2,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.black
                              ),
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(13)
                              ),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.number,
                              cursorHeight: SizeConfig.blockSizeVertical * 2,
                              onChanged: (value){
                                setState(() {
                                  price=value;
                                });
                              },
                            ),
                            height: SizeConfig.blockSizeVertical * 4,
                            alignment: Alignment.center,
                            width: SizeConfig.screenWidth * 0.15,
                          ),
                          SizedBox(
                            width: SizeConfig.blockSizeHorizontal * 2,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 5,),
                                Text(Constants().currency),
                                Icon(Icons.arrow_drop_down,color: Colors.black,
                                size: SizeConfig.blockSizeVertical * 3,)
                              ],
                            ),
                            height: SizeConfig.blockSizeVertical * 4,
                            alignment: Alignment.center,
                            width: SizeConfig.screenWidth * 0.12,
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: SizeConfig.screenWidth,
                  alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: () async {
setState(() {
  isLoading=true;
});
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      var token=  prefs.getString("token");
                      //_onDone();
                     // Navigator.of(context).pushNamed('/Ingredients');
if(price==null){
  setState(() {
    isLoading=false;
  });
  showToast("Please Enter Price");
}
else if(timeTaken==null){
  setState(() {
    isLoading=false;
  });
  showToast("Please Enter Time");
}
else if(name==null){
  setState(() {
    isLoading=false;
  });
  showToast("Please Enter Name");
}

            //           print(ingredientname);
            //           print(ingredientname[0]);
                     else{
  for(int i=0;i<cards.length;i++){



      var ing = dishIngredient(name:nameTECs[i].text,quantity: int.parse(ageTECs[i].text),units: "kg",required: 1);
      ingredient.add(ing);

  }

  var categoryfood;
  if(lunch==true){
    setState(() {
      categoryfood="lunch";
    });
  }
  if(breakfast==true){
    setState(() {
      categoryfood="Breakfast";
    });
  }
  else{
    setState(() {
      categoryfood="Dinner";
    });
  }
  full = Adddishmodel(name: name, description: "description", price: int.parse(price),image:_image!=null?_image.path:"",
      timeTaken: int.parse(timeTaken), status: "Active", category:cat, ingredient: ingredient,video: _video!=null?_video:"");
  Adddishrepo.diomwthod(token, full,context);
}
                    },
                    color: Color(0XFFFEE715),
                    child:  isLoading
                        ? CircularProgressIndicator(
                      valueColor:
                      new AlwaysStoppedAnimation<Color>(
                          Colors.white),
                    )
                        : Text("Upload"),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                    minWidth: SizeConfig.screenWidth * 0.4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
  Card createCard() {
    var nameController = TextEditingController();
    var ageController = TextEditingController();
    var jobController = TextEditingController();
    nameTECs.add(nameController);
    ageTECs.add(ageController);
    jobTECs.add(jobController);
    // nameTECs.add(nameController);
    // ageTECs.add(ageController);
    // jobTECs.add(jobController);
    return Card(
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(

            margin: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical,
                horizontal: SizeConfig.screenWidth * 0.05
            ),
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0.5,
                    spreadRadius: 0.5,
                    offset: Offset(1,1),
                  ),
                ]
            ),
            height: SizeConfig.blockSizeVertical * 6,
            child:  Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: SizeConfig.screenWidth * 0.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text( '${cards.length + 1}'),
                        Container(
                          color: Color(0XFFFEE715),
                          height: SizeConfig.blockSizeVertical * 6,
                          width: SizeConfig.blockSizeHorizontal * 0.4,
                        ),
                       Container(
                         width: 100,
                           child: TextFormField(

                             controller: nameController,
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               hintText: "Item Name",

                               hintStyle: TextStyle(
                                   color: Colors.grey,
                                   fontSize: SizeConfig.blockSizeVertical * 1.25
                               ),
                               contentPadding: EdgeInsets.all(10),
                             ),
                             textAlign: TextAlign.center,
                             cursorHeight: SizeConfig.blockSizeVertical * 2,
                             cursorColor: Colors.black,
                             onFieldSubmitted: (value){
                               setState(() {
                                 ingredientnamestring=value;
                               });
                               ingredientname.add(ingredientnamestring);
                             },
                           ))
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Color(0XFFFEE715),
                            ),
                          ),
                          alignment: Alignment.center,
                          width: SizeConfig.screenWidth * 0.2,
                          height: SizeConfig.blockSizeVertical * 3,
                          child: TextField(
                            controller: ageController,
                          keyboardType:  TextInputType.phone,
                            maxLength: 4,
                            buildCounter: (BuildContext context,
                                {int currentLength,
                                  int maxLength,
                                  bool isFocused}) =>
                            null,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Qty.",
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: SizeConfig.blockSizeVertical * 1.25
                              ),
                              contentPadding: EdgeInsets.all(10),
                            ),
                            textAlign: TextAlign.center,
                            cursorHeight: SizeConfig.blockSizeVertical * 2,
                            cursorColor: Colors.black,

                            onSubmitted: (value){
                              setState(() {
                                quantitystring=value;
                              });
                              quantity.add(quantitystring);
},

                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  color: Color(0XFFFEE715),
                                  width: SizeConfig.blockSizeHorizontal * 0.4
                              )),
                          alignment: Alignment.center,
                          width: SizeConfig.screenWidth * 0.15,
                          height: SizeConfig.blockSizeVertical * 3,
                          child: Row(
                            children: [
                              Text("  kg  ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),),
                              Icon(Icons.arrow_drop_down,
                                color: Colors.black,
                                size: SizeConfig.blockSizeVertical * 2,)
                            ],
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.blockSizeHorizontal * 2,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0XFFFEE715),
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              )
                          ),
                          alignment: Alignment.center,
                          width: SizeConfig.blockSizeHorizontal * 8,
                          height: SizeConfig.blockSizeVertical * 6,
                          child: RotatedBox(
                            child: Text("Req.",style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),),
                            quarterTurns: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("Video"),
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
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
    );
    Widget Nobutton = TextButton(
      child: Text("Image"),
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
        showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => ActionSheet()
                .actionSheet(context, onCamera: () {
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
              _pickImageFromCamera();
            }, onGallery: () {
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
              _pickImageFromGallery();
            }, text: "Select profile image"));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add dish"),
      content: Text("What You want to add"),
      actions: [
        okButton,
        Nobutton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }



}
class PersonEntry {
  final String name;
  final String qty;
  final String studyJob;

  PersonEntry(this.name, this.qty, this.studyJob);
  @override
  String toString() {
    return 'name= $name, age= $qty, study job= $studyJob';
  }
}
