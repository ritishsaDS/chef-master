import 'package:flutter/material.dart';
import 'package:flutter_chef/Ui/MyDishesIngredientsScreen.dart';
import 'package:flutter_chef/Utils/Constants.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';

class Listtilemydish extends StatelessWidget{
  String name;
  String image;
  int price;
  int timetaken;
  dynamic dish_ingredients;
  int id;
  Listtilemydish({this.price,this.name,this.image,this.timetaken,this.dish_ingredients,this.id});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
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
              offset: Offset(1, 1),
            ),
          ]),
      //  height: SizeConfig.blockSizeVertical * 9,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>Ingredients(
              dish_ingredients:   dish_ingredients,
                  price:price,
            time:timetaken,
            name:name,
              id:id
          )));
        //  Navigator.of(context).pushNamed('/Ingredients');
        },
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 2),
                ),
                Row(
                  children: [
                    Container(
                      margin:
                      EdgeInsets.only(right: SizeConfig.blockSizeHorizontal),
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey[800],
                        size: SizeConfig.blockSizeVertical * 2,
                      ),
                    ),
                    Container(
                      margin:
                      EdgeInsets.only(left: SizeConfig.blockSizeHorizontal),
                      child: Icon(Icons.delete,
                          color: Colors.grey[800],
                          size: SizeConfig.blockSizeVertical * 2),
                    ),
                  ],
                ),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Time \n${timetaken.toString()}",
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: SizeConfig.blockSizeVertical * 2.5,
                  width: SizeConfig.blockSizeHorizontal * 20,
                  child: MaterialButton(
                    onPressed: () {},
                    color: Color(0XFFFEE715),
                    child: Text(
                      Constants().currency+price.toString(),
                      style:
                      TextStyle(fontSize: SizeConfig.blockSizeVertical * 1.5),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3)),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.black,
        ),
        leading: Container(
          width: SizeConfig.blockSizeHorizontal * 12,
          height: SizeConfig.blockSizeVertical * 6,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(5),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );

  }
}