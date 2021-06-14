import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_home/views/home/common/loading.dart';
import 'package:grocery_home/views/home/home.dart';
import 'package:grocery_home/views/home/services/database.dart';
import 'package:grocery_home/views/home/adminhome.dart';

import 'specOrder.dart';

class OrdersPlaced extends StatefulWidget {
  const OrdersPlaced({Key key}) : super(key: key);

  @override
  _OrdersPlacedState createState() => _OrdersPlacedState();
}

class _OrdersPlacedState extends State<OrdersPlaced> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffBBD8B3),
        title: Text("Orders Placed"),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: Database().getOrders(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Loading();
            if (snapshot.data.documents.length == 0) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 383,
                      child: Center(
                        child: Text(
                            "Looks like you don't have any orders yet."),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => adminHome()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(FontAwesomeIcons.arrowLeft),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Go Back to Home Page"),
                          )
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Color(0xffF3B61F), elevation: 8),
                    ),
                  )
                ],
              );
            }
            return Container(
              margin: EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  for (var i = 0; i < snapshot.data.documents.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpecOrder(
                                    username: snapshot.data.documents[i]["username"],
                                        name: snapshot.data.documents[i]
                                            ["name"],
                                        date: snapshot.data.documents[i]
                                            ["date"],
                                        time: snapshot.data.documents[i]
                                            ["time"],
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.white, elevation: 2),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: StreamBuilder(
                              stream: Database()
                                  .getVeg(snapshot.data.documents[i]["name"]),
                              builder: (context, snapshot2) {
                                if (!snapshot2.hasData) return Container();
                                return Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(snapshot2
                                                .data.documents[0]['photo']),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data.documents[i]['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Ordered By - "+
                                            snapshot.data.documents[i]['username'],
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
                                            "Date: " +
                                                snapshot.data.documents[i]
                                                    ['date'],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ]);
                              },
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
