import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/addItems.dart';
import 'package:grocery_home/views/home/common/widget.dart';
import 'package:grocery_home/views/home/services/helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'login.dart';

class adminHome extends StatefulWidget {
  const adminHome({Key key}) : super(key: key);

  @override
  _adminHomeState createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(""),
        backgroundColor: Color(0xffF2C078),
        elevation: 0.0,
        shadowColor: Colors.black,
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Icon(Icons.menu_book),
            iconSize: 50,
            color: Colors.black,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),
      drawer: Drawer(
        child: TextButton(
          child: Text(isLoggedIn ? "Sign Out" : "Sign In"),
          onPressed: () async {
            isLoggedIn = false;
            await Helper.saveUserloggedIn(false);
            username = "";
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Login()));
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Center(
                child: Text(
                  "Admin Panel",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 24),
                ),
              ),
              height: 80,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color(0xffF2C078),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(26),
                      bottomRight: Radius.circular(26))),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                  child: Text(
                "Items Added",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: ElevatedButton(
                child: Text(
                  "Add Items",
                  style: TextStyle(color: Color(0xff550527)),
                ),
                style: ElevatedButton.styleFrom(primary: Color(0xffFAEDCA)),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddItems()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
