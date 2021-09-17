import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/Customer/CookDetails.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'Constants.dart';

class homepagecook extends StatefulWidget {
  String fullname;
  String phone;
  dynamic id;
  homepagecook({this.fullname, this.phone,this.id});
  @override
  _homepagecookState createState() => _homepagecookState();
}

class _homepagecookState extends State<homepagecook> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CookDetails(name:widget.fullname,phone: widget.phone,id:widget.id)));
      },
      child: Container(
        width: SizeConfig.screenWidth * 0.85,
        height: SizeConfig.screenHeight * 0.3,
        margin: EdgeInsets.only(
          bottom: SizeConfig.blockSizeVertical,
          top: SizeConfig.blockSizeVertical,
          left: SizeConfig.blockSizeHorizontal * 6,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0XFFDDDDDD),
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: Offset(1.0, 1.0))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.22,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        'https://www.thephoblographer.com/wp-content/uploads/2012/10/Chris-Gampat-The-Phoblographer-CAnon-1D-X-and-24-70mm-f2.8-II-Top-Chep-cookoff-at-Photo-Plus-2012-6-of-23ISO-400.jpg',
                        fit: BoxFit.fill,
                      )),
                  //todo: design favourite icon
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 0.5,
                  left: SizeConfig.blockSizeVertical),
              child: Text(
                widget.fullname,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.blockSizeVertical * 2,
                ),
              ),
            ),
            Container(
              height: SizeConfig.blockSizeVertical * 4,
              //color: Colors.pink,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 0.2,
                        left: SizeConfig.blockSizeVertical),
                    child: Text(
                      widget.phone.toString(),
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 1.50,
                          color: Colors.grey),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 5),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_sharp,
                          color: Colors.yellow[600],
                          size: SizeConfig.blockSizeVertical * 2,
                        ),
                        Text(
                          "4.5",
                          style: TextStyle(
                              fontSize: SizeConfig.blockSizeVertical * 1.25,
                              fontWeight: FontWeight.bold),
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
    );
  }
}
