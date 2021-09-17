import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Widget listTileOrders(
//   dishname,
//      customername,
//      image,
//     )
// {
class listTileOrders extends StatefulWidget{
  var dishname;
  var    customername;
  var orderid;
  var     image;
  listTileOrders({this.orderid,this.image,this.dishname,this.customername});
  @override
  _listTileOrdersState createState() => _listTileOrdersState();
}

class _listTileOrdersState extends State<listTileOrders> {
  bool   isLoading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 1.5,
      ),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
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
      height: SizeConfig.blockSizeVertical * 9,
      child: ListTile(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${widget.dishname}",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.blockSizeVertical * 2
                ),),
                Text("28/03/2021 \t 11:30 AM",style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical,
                  color: Colors.blue,
                ) ,)
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order By \n${widget.customername}",style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical,
                  color: Colors.grey,
                ) ,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0XFFFEE715),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: SizeConfig.blockSizeHorizontal * 10,
                      height: SizeConfig.blockSizeVertical * 2.5,
                      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                      child: ImageIcon(
                        AssetImage('assets/icons/wrong.png'),
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal,
                    ),
                    GestureDetector(
                      onTap: (){
                        updatedishstatus(status:2);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0XFFFEE715),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: SizeConfig.blockSizeHorizontal * 10,
                        height: SizeConfig.blockSizeVertical * 2.5,
                        padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal),
                        child: ImageIcon(
                          AssetImage('assets/icons/tick.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios,color: Colors.black,),
        leading: Container(
          width: SizeConfig.blockSizeHorizontal * 12,
          height: SizeConfig.blockSizeVertical * 6,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network('https://i.pinimg.com/originals/31/ac/7d/31ac7d17b45a6b900090f8a237baa7e4.jpg',fit: BoxFit.cover,),
          ),
        ),
      ),
    );
  }
dynamic cookfromserver=new List();
  Future<void> updatedishstatus({int status}) async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    try {
      final response = await post(Uri.parse("https://royalgujarati.com/chief/public/api/update_order_status"),body: (
          {
            "order_id":widget.orderid.toString(),
            "status":status.toString()
          }
      ));
         print("bjkb" + response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
print(responseJson['msg']);
     showToast(responseJson['msg']);
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
}
