import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_home/main.dart';
import 'package:grocery_home/utils/colors_utils.dart';
import 'package:grocery_home/utils/string_utils.dart';
import 'package:grocery_home/views/home/login.dart';
import 'package:grocery_home/views/home/services/database.dart';
import 'package:grocery_home/views/home/services/helper.dart';
import 'package:grocery_home/views/home/widgets/home_appbar.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:grocery_home/views/home/widgets/home_shopbycategory.dart';
import 'package:grocery_home/views/home/widgets/home_showrecentorders.dart';

import 'common/loading.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<StatefulWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: ColorsUtils.HomeBgColor,
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: showBody(),
      drawer: Drawer(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ListView(
              children: [
                Container(
                  height: 150,
                  width: 10,
                ),
                ListTile(
                  dense: true,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  title: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FontAwesomeIcons.home,
                        color: Color(0xffA10702),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Dashboard",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),
                ListTile(
                  dense: true,
                  onTap: () async {
                    isLoggedIn = false;
                    await Helper.saveUserloggedIn(false);
                    username = "";
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  title: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FontAwesomeIcons.signOutAlt,
                        color: Color(0xffA10702),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Sign Out",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget image_carousel = new Container(
    height: 200.0,
    child: new Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('assets/offers/Offer1.jpg'),
        AssetImage('assets/offers/Offer2.jpg'),
        AssetImage('assets/offers/Offer3.jpg'),
        AssetImage('assets/offers/Offer4.jpg'),
        AssetImage('assets/offers/Offer5.jpg'),
      ],
      autoplay: true,
      animationCurve: Curves.fastLinearToSlowEaseIn,
      animationDuration: Duration(milliseconds: 1000),
      dotSize: 4.0,
      indicatorBgPadding: 2.0,
    ),
  );

  Widget showBody() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: ListView(
        children: <Widget>[
          image_carousel,
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Text(
              StringUtils.ShopByCategory,
              style: TextStyle(
                  color: ColorsUtils.Black,
                  fontSize: 20.0,
                  fontFamily: StringUtils.Montserrat,
                  fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(height: 20.0),
          HomeShopByCategory(),
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Today's Deals",
                  style: TextStyle(
                      color: ColorsUtils.Black,
                      fontSize: 20.0,
                      fontFamily: StringUtils.Montserrat,
                      fontWeight: FontWeight.w700),
                ),
                FlatButton(
                    onPressed: _showAllBtnTapped,
                    child: Text(
                      StringUtils.Show_All,
                      style: TextStyle(
                          color: ColorsUtils.PrimaryColor,
                          fontSize: 18.0,
                          fontFamily: StringUtils.Montserrat,
                          fontWeight: FontWeight.w400),
                    ))
              ],
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: StreamBuilder(
                  stream: Database().getVeggie(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Loading();
                    if (snapshot.data.documents.length == 0)
                      return Container(
                        height: 299,
                        child: Center(
                          child: Text("No deals yet"),
                        ),
                      );
                    return Container(
                      child: Column(
                        children: <Widget>[
                          for (var i = 0; i < snapshot.data.documents.length; i++)
                            Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xffF2C078),
                                  borderRadius: BorderRadius.circular(37),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(snapshot
                                                  .data.documents[i]['photo']),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(28)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data.documents[i]
                                                  ['vegName'],
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Rs. " +
                                                  snapshot.data.documents[i]
                                                      ['price'] +
                                                  " /Kg",
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Min. Quantity: " +
                                                  snapshot.data.documents[i]
                                                      ['price'],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {}),
                                    )
                                  ],
                                ),
                              ),
                            )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _showAllBtnTapped() {}
}
