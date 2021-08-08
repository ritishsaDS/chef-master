import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/Customer/CookDetails.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

import 'Constants.dart';
class topcookcard extends StatefulWidget {
  String name;
  String image;
  dynamic price;
  String chefname;

  topcookcard({this.chefname, this.image, this.name, this.price});

  @override
  _mostsellingdishesState createState() => _mostsellingdishesState();
}

class _mostsellingdishesState extends State<topcookcard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CookDetails()));
      },
      child: Container(
        width: SizeConfig.screenWidth * 0.85,
        height: SizeConfig.screenHeight * 0.3,
        margin: EdgeInsets.only(
          bottom: SizeConfig.blockSizeVertical,
          top: SizeConfig.blockSizeVertical,
          left: SizeConfig.screenWidth * 0.05,
          right: SizeConfig.screenWidth * 0.05,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0XFFDDDDDD),
                  blurRadius: 8,
                  spreadRadius: 2,
                  offset: Offset(
                      2.0,
                      2.0
                  )

              )
            ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: SizeConfig.screenHeight * 0.23,
              child: Stack(fit: StackFit.expand,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.network(
                        'https://c4.wallpaperflare.com/wallpaper/284/422/497/cook-foreman-kitchen-dishes-wallpaper-preview.jpg',
                        fit: BoxFit.fill,
                      )),
                  //todo: design favourite icon
                ],
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
                        top: SizeConfig.blockSizeVertical * 0.5,
                        left: SizeConfig.blockSizeVertical
                    ),
                    child: Text(widget.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 2,
                      ),),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        right: SizeConfig.blockSizeHorizontal * 5
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star_sharp, color: Colors.yellow[600],
                          size: SizeConfig.blockSizeVertical * 2,),
                        Text("4.5", style: TextStyle(
                            fontSize: SizeConfig.blockSizeVertical * 1.25,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    )

    ;
  }
}
