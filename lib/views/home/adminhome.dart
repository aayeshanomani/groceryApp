import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/addItems.dart';
import 'package:grocery_home/views/home/common/widget.dart';
import 'package:grocery_home/views/home/services/database.dart';
import 'package:grocery_home/views/home/services/helper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_home/views/home/user/admin/ordersDelivered.dart';
import 'package:grocery_home/views/home/user/admin/ordersPlaced.dart';

import 'common/loading.dart';
import 'login.dart';

class adminHome extends StatefulWidget {
  const adminHome({Key key}) : super(key: key);

  @override
  _adminHomeState createState() => _adminHomeState();
}

Future _showMyDialog(
    BuildContext context, String title, String message, String name) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(message),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Database().delVeggie(name);
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
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
                        MaterialPageRoute(builder: (context) => adminHome()));
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OrdersPlaced()));
                  },
                  title: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FontAwesomeIcons.starOfLife,
                        color: Color(0xffA10702),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Orders Placed",
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OrdersDelivered()));
                  },
                  title: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        FontAwesomeIcons.levelDownAlt,
                        color: Color(0xffA10702),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Orders Delivered",
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
      body: SingleChildScrollView(
        child: Container(
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
                child: Container(
                  child: StreamBuilder(
                    stream: Database().getVeggie(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Loading();
                      if (snapshot.data.documents.length == 0)
                        return Container(
                          height: 299,
                          child: Center(
                            child: Text("No vegetables yet"),
                          ),
                        );
                      return Container(
                        child: Column(
                          children: <Widget>[
                            for (var i = 0;
                                i < snapshot.data.documents.length;
                                i++)
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
                                                        ['minQuantity'],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {
                                              _showMyDialog(
                                                  context,
                                                  "Are you sure?",
                                                  "Are you sure you want to delete " +
                                                      snapshot.data.documents[i]
                                                          ["vegName"],
                                                  snapshot.data.documents[i]
                                                      ["vegName"]);
                                            }),
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
      ),
    );
  }
}
