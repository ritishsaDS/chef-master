import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chef/Utils/CustomerNavBar.dart';
import 'package:flutter_chef/Utils/SizeConfig.dart';
import 'package:flutter_chef/Utils/listTileCustomerDetailOrder.dart';

class CustomerOrderDetail extends StatefulWidget {
  const CustomerOrderDetail({Key key}) : super(key: key);

  @override
  _CustomerOrderDetailState createState() => _CustomerOrderDetailState();
}

class _CustomerOrderDetailState extends State<CustomerOrderDetail> {

  bool ingredients = true;
  bool liveChat = false;
  bool desc = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Customerbottom(index:2),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.more_vert,
          color: Colors.black,
        ),
        centerTitle: true,
        title: ImageIcon(
          AssetImage('assets/icons/my dishes icon.png'),
          color: Colors.black,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.persofoto.com/images/vorher-nachher/passfoto-beispiel-vorher.jpg'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "Dish Name",
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              alignment: Alignment.center,
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
            ),
            Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.3,
              child: Container(
                width: SizeConfig.screenWidth,
                padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeVertical * 2,
                  right: SizeConfig.blockSizeVertical * 2,
                ),
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: Carousel(
                  boxFit: BoxFit.cover,
                  autoplay: true,
                  borderRadius: true,
                  autoplayDuration: Duration(seconds: 3),
                  animationCurve: Curves.fastOutSlowIn,
                  dotSpacing: SizeConfig.blockSizeHorizontal * 3,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 6.0,
                  dotColor: Colors.grey[700],
                  dotIncreasedColor: Color(0XFFFEE715),
                  dotBgColor: Colors.transparent,
                  dotPosition: DotPosition.bottomCenter,
                  //dotVerticalPadding: SizeConfig.blockSizeVertical,
                  showIndicator: true,
                  indicatorBgPadding: 9.0,
                  images: [
                    NetworkImage(
                        'https://www.helpguide.org/wp-content/uploads/table-with-grains-vegetables-fruit-768.jpg'),
                    NetworkImage(
                        'https://scx2.b-cdn.net/gfx/news/hires/2016/howcuttingdo.jpg'),
                    NetworkImage(
                        'https://cdn-a.william-reed.com/var/wrbm_gb_food_pharma/storage/images/publications/food-beverage-nutrition/foodnavigator.com/article/2020/04/22/coronavirus-and-obesity-doctors-take-aim-at-food-industry-over-poor-diets/10933380-3-eng-GB/Coronavirus-and-obesity-Doctors-take-aim-at-food-industry-over-poor-diets_wrbm_large.jpg'),
                    NetworkImage(
                        'https://rs.projects-abroad.net/v1/hero/indian-cuisine-south-africa-food-tours-product-5e146c7a97eb2.[1600].jpeg'),
                    NetworkImage(
                        'https://www.refrigeratedfrozenfood.com/ext/resources/NEW_RD_Website/DefaultImages/default-pasta.jpg?1430942591'),
                    NetworkImage(
                        'https://i.pinimg.com/originals/18/20/fe/1820fe688c159fc88ce4429de5fa05b5.jpg'),
                  ],
                ),
              ),
            ),
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
                vertical: SizeConfig.blockSizeVertical * 2
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MaterialButton(onPressed: (){
                    setState(() {
                      ingredients = true;
                      liveChat = false;
                      desc = false;

                    });
                  },
                  child: Text("Ingredients",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.blockSizeVertical * 1.50,
                    ),
                  ),
                    color: ingredients == true ? Color(0XFFFEE715) : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),),
                  MaterialButton(onPressed: (){
                    setState(() {
                      ingredients = false;
                      liveChat = true;
                      desc = false;

                    });
                  },
                    child: Text("Live Chat",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 1.50,
                      ),
                    ),
                    color: liveChat == true ? Color(0XFFFEE715) : Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),),
                  MaterialButton(onPressed: (){
                    setState(() {
                      ingredients = false;
                      liveChat = false;
                      desc = true;

                    });
                  },
                    child: Text("Description",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.blockSizeVertical * 1.50,
                      ),
                    ),
                    color: desc == true ? Color(0XFFFEE715) : Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical * 1.5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/bg/left line.png',
                    ),
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical,
                      right: SizeConfig.blockSizeHorizontal,
                    ),
                    width: SizeConfig.screenWidth * 0.35,
                  ),
                  if(ingredients==true)
                  Text(
                    "Ingredients",
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        fontWeight: FontWeight.bold),
                  )
                  else if(liveChat == true)
                  Text(
                  "Live Chat",
                  style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 2,
                  fontWeight: FontWeight.bold),
                  )
                  else
                    Text(
                      "Description",
                      style: TextStyle(
                          fontSize: SizeConfig.blockSizeVertical * 2,
                          fontWeight: FontWeight.bold),
                    ),
                  Container(
                    child: Image.asset(
                      'assets/bg/right line.png',
                    ),
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical,
                      left: SizeConfig.blockSizeHorizontal,
                    ),
                    width: SizeConfig.screenWidth * 0.35,
                  ),
                ],
              ),
            ),
            if(ingredients==true)
            Container(
              height: SizeConfig.blockSizeVertical * 4,
              child: ListTile(
                dense: true,
                title: Text("Item Name",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: SizeConfig.blockSizeVertical * 1.25,
                  fontWeight: FontWeight.bold,
                ),),
                leading: Text("Sr No.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: SizeConfig.blockSizeVertical * 1.25,
                    fontWeight: FontWeight.bold,
                  ),),
                trailing: Container(
                  margin: EdgeInsets.only(
                    right: SizeConfig.screenWidth * 0.25
                  ),
                  child: Text("Qty.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: SizeConfig.blockSizeVertical * 1.25,
                      fontWeight: FontWeight.bold,
                    ),),
                ),
              ),
            ),
            if(ingredients == true)
            Container(
              width: SizeConfig.screenWidth,
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.05,
              ),
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  listTileCustomerDetailOrder(context, " 2 Kg.", "1"),
                  listTileCustomerDetailOrder(context, " 200 Gm.", "2"),
                  listTileCustomerDetailOrder(context, " 1 Kg.", "3"),
                  listTileCustomerDetailOrder(context, " 2 Kg.", "4"),
                  listTileCustomerDetailOrder(context, " 2 Kg.", "5"),
                  listTileCustomerDetailOrder(context, " 2 Kg.", "6")

                ],
              ),
            )else if(desc == true)
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                  vertical: SizeConfig.blockSizeVertical,
                  horizontal: SizeConfig.screenWidth * 0.05
                ),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 0.5,
                      spreadRadius: 1,
                      offset: Offset(0,0)
                    ),
                  ]
                ),
                child: Text("Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout."
                    "Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout."
                    "Lorem ipsum is a dummy text used to replace text in some areas just for the purpose of an example. It can be used in publishing and graphic design. It is used to demonstrate the graphics elements of a document, such as font, typography, and layout.",textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: SizeConfig.blockSizeVertical * 1.75,
                  color: Colors.black
                ),),
              ),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
          ],
        ),
      ),
    ));
  }
}
