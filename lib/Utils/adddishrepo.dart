import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/MyDishes.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'Api.dart';

import 'package:flutter_chef/Utils/models/adddishmodule.dart';

import 'BottomNavigation.dart';
import 'models/adddishmodule.dart';
import 'models/adddishmodule.dart';
class Adddishrepo {

  static Future<void> diomwthod(token,Adddishmodel adddishmodel,context) async {

    print(adddishmodelToJson(adddishmodel));
    print(adddishmodelToJson(adddishmodel));
    final map= {adddishmodelToJson(adddishmodel)};
    try {
      Dio dio=Dio();



      final response = await dio.post(("https://royalgujarati.com/chief/public/api/chef/add-dish"),
          options: Options(
            headers: {"Authorization": "Bearer $token"},
          ),
          data: adddishmodelToJson(adddishmodel));

    // body: {
    //
    //     "name":  "dd",
    //     "description": "adddishmodel.description",
    //     "price":" adddishmodel.price",
    //     "time_taken": "adddishmodel.timeTaken" ,
    //     "status": "adddishmodel.status",
    //     "category": "adddishmodel",
    //     "dish_image":"adddishmodel.dishImage",
    //     "ingredient":"dvf",
    //     "video":""
    //   });

print(response.statusCode);
      if (response.statusCode == 200)
      {
       // final responseJson = jsonDecode(response.data);
print(response.data);
      //  loginwithserver = responseJson;
        // print(loginwithserver['data']['email']);
       // print(loginwithserver);

        // SharedPreferences preferences = await SharedPreferences.getInstance();
        //
        // preferences.setString("token", loginwithserver['token']['original']['access_token']);
        // preferences.setInt("chefid", loginwithserver['data'][0]['id']);
        // // preferences.setString("token", loginwithserver['token']['original']['access_token']);
        // print(preferences.getInt("chefid"));
        // print( preferences.getString("token"));
         showToast("Dish added Successfully");
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyBottomBarDemo()));
        // preferences.setString("login", "cook");


        // showToast("");
        //savedata();

      } else {
        print("bjkb" + response.statusMessage);
        //showToast("Mismatch Credentials");

      }
    } catch (e) {
      print(e);

    }
  }
  //static Future<>adddish()
//   static Future<bool> addusernotes(
//       String token, Adddishmodel addNotes ) async {
//     //print("sdakcdml"+toJson(addNotes));
//    // print( adddishmodelToJson(addNotes).toString());
//     {
//       var url = userupdateprofile;
//       Map<String, String> headers = { 'Authorization': 'Bearer $token',"Content-Type":"application/json"};
//       var request = http.MultipartRequest('POST', Uri.parse(url));
//       request.headers.addAll(headers);
//
//       request.files.add(await http.MultipartFile.fromString(
//         add
//       ));
// request.files.add(addNotes as String);
//       request.fields['name'] = addNotes.name;
//       request.fields['description'] = addNotes.description;
//       request.fields['price'] = addNotes.price.toString();
//       request.fields['time_taken'] = addNotes.timeTaken.toString();
//       request.fields['category'] = addNotes.category;
//       request.fields['status'] = addNotes.status;
//       //request.files['dish_ingredients'] = addNotes.ingredient ;
//       for (String item in addNotes) {
//         request.files.add(http.MultipartFile.fromString('manage_tag_model', item));
//       }
//
//       var res = await request.send();
//       print(request.fields);
//       if (res.statusCode == 200) {
//         Fluttertoast.showToast(
//             msg: "Profile Succesfully Uploaded",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.green[400],
//             textColor: Colors.white,
//             fontSize: 16.0);
//         //Navigator.pop(context);
//       } else {
//         Fluttertoast.showToast(
//             msg: "Something Went Wrong",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0);
//       }
//      // return res.reasonPhrase;
//     }}

  // static Future<void> diomwthod(token,Adddishmodel adddishmodel,context) async {
  //   print(json.encode(adddishmodel.ingredient));
  //   print(adddishmodel.image);
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       try {
  //         var dio = Dio();
  //         FormData formData = new FormData.fromMap(  {
  //           // "image": await MultipartFile.fromFile(adddishmodel.image.toString().replaceAll("'File:", ""),),
  //           "name": adddishmodel.name ,
  //           "description": adddishmodel.description,
  //           "price": adddishmodel.price ,
  //           "time_taken": adddishmodel.timeTaken ,
  //           "status": adddishmodel.status,
  //           "category":  ["breakfast", "lunch", "dinner"],
  //           "dish_image":adddishmodel.image,
  //           "ingredient": json.encode(adddishmodel.ingredient),
  //         });
  //         // if (adddishmodel.image != null && adddishmodel.image != "" ) {
  //         //   var mcDocsFileName = adddishmodel.image.split('/').last;
  //         //
  //         //   if (!adddishmodel.image.contains("."))
  //         //   {
  //         //     print("adddish");
  //         //     mcDocsFileName = adddishmodel.image + ".jpg";
  //         //   }
  //         //   formData.files.add(MapEntry("dish_image",
  //         //       await MultipartFile.fromFile(adddishmodel.image,filename: mcDocsFileName)));
  //         // }
  //         // else{
  //         //   if (adddishmodel.video != null && adddishmodel.video != "" ) {
  //         //     var mcDocsFileName = adddishmodel.video.split('/').last;
  //         //     if (!adddishmodel.video.contains("."))
  //         //     {
  //         //       print("adddish");
  //         //       mcDocsFileName = adddishmodel.video + ".mp4";
  //         //     }
  //         //     formData.files.add(MapEntry("video",
  //         //         await MultipartFile.fromFile(adddishmodel.video,filename: mcDocsFileName)));
  //         //   }
  //         // }
  //         print(formData);
  //         final response = await dio.post(chefaddish,
  //             data: formData,
  //             options: Options(
  //               headers: {'Authorization': 'Bearer $token'},
  //             ));
  //         print(response.statusCode);
  //         showToast("Dish Added Succesfully");
  //         Navigator.push(context, MaterialPageRoute(builder: (context)=>MyDishes(sort:"")));
  //       } catch (error, stacktrace) {
  //         print(error);
  //         //return CreatePostModel(message: error.toString());
  //       }
  //     }
  //   } on SocketException catch (_) {
  //     Fluttertoast.showToast(
  //         msg: "No Internet Connection",
  //         toastLength: Toast.LENGTH_LONG,
  //         gravity: ToastGravity.CENTER,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);
  //   }
  // }
}