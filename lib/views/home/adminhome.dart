import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/addItems.dart';
import 'package:grocery_home/views/home/common/widget.dart';
import 'package:grocery_home/views/home/services/helper.dart';

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
        title: Text("Admin Panel"),
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
                child: Text("Add Items"),
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