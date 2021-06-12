import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_home/views/home/services/database.dart';

import 'cart.dart';
import 'common/loading.dart';

class Vegiie extends StatefulWidget {
  const Vegiie({Key key}) : super(key: key);

  @override
  _VegiieState createState() => _VegiieState();
}

class _VegiieState extends State<Vegiie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB3B5BB),
      appBar: AppBar(
        title: Text("Shop for Vegetables"),
        actions: [
          IconButton(
              icon: Icon(FontAwesomeIcons.cartPlus),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Cart()));
              })
        ],
      ),
      body: SingleChildScrollView(
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
                      child: Text("Nothing yet"),
                    ),
                  );
                return Container(
                  child: Column(
                    children: <Widget>[
                      for (var i = 0; i < snapshot.data.documents.length; i++)
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Container(
                            decoration: BoxDecoration(
                              
                              color: Color(0xffCDFFF9),
                              borderRadius: BorderRadius.circular(7),
                              
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
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data.documents[i]['vegName'],
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
                                Expanded(
                                  child: StreamBuilder(
                                      stream: Database().getCart(),
                                      builder: (context, snapshot2) {
                                        if (!snapshot2.hasData)
                                          return Loading();
                                        var j;
                                        for (j = 0;
                                            j < snapshot2.data.documents.length;
                                            j++) {
                                          if (snapshot2.data.documents[j]
                                                  ["name"] ==
                                              snapshot.data.documents[i]
                                                  ["vegName"]) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xffC5D9E2),
                                                    border: Border.all(
                                                        color:
                                                            Color(0xff817F75)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0.0),
                                                        margin:
                                                            EdgeInsets.all(0),
                                                        child: IconButton(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    0.0),
                                                            icon: Icon(
                                                              Icons.remove,
                                                              size: 18,
                                                            ),
                                                            onPressed: () {
                                                              if (snapshot2.data
                                                                          .documents[j]
                                                                      [
                                                                      "quan"] ==
                                                                  1) {
                                                                Database().delItemFromCart(
                                                                    snapshot2
                                                                            .data
                                                                            .documents[j]
                                                                        [
                                                                        "name"]);
                                                              } else if (snapshot2
                                                                          .data
                                                                          .documents[j]
                                                                      ["quan"] >
                                                                  1) {
                                                                Map<String,
                                                                        dynamic>
                                                                    sata = {
                                                                  "name": snapshot
                                                                          .data
                                                                          .documents[i]
                                                                      [
                                                                      "vegName"],
                                                                  "quan": snapshot2
                                                                          .data
                                                                          .documents[j]["quan"] -
                                                                      1,
                                                                  "price": snapshot
                                                                          .data
                                                                          .documents[
                                                                      i]["price"]
                                                                };
                                                                Database().addToCart(
                                                                    snapshot.data
                                                                            .documents[i]
                                                                        [
                                                                        "vegName"],
                                                                    sata);
                                                              }
                                                            }),
                                                      ),
                                                    ),
                                                    Text(snapshot2.data
                                                        .documents[j]["quan"]
                                                        .toString()),
                                                    Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      margin: EdgeInsets.all(0),
                                                      child: IconButton(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  0.0),
                                                          icon: Icon(
                                                            Icons.add,
                                                            size: 18,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              Map<String,
                                                                      dynamic>
                                                                  sata = {
                                                                "name": snapshot
                                                                        .data
                                                                        .documents[i]
                                                                    ["vegName"],
                                                                "quan": snapshot2
                                                                            .data
                                                                            .documents[j]
                                                                        [
                                                                        "quan"] +
                                                                    1,
                                                                "price": snapshot
                                                                        .data
                                                                        .documents[
                                                                    i]["price"]
                                                              };
                                                              Database().addToCart(
                                                                  snapshot.data
                                                                          .documents[i]
                                                                      [
                                                                      "vegName"],
                                                                  sata);
                                                            });
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                        if (j ==
                                            snapshot2.data.documents.length) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              child: ElevatedButton(
                                                
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 2
                                                ),
                                                onPressed: () {
                                                  Map<String, dynamic> sata = {
                                                    "name": snapshot
                                                            .data.documents[i]
                                                        ["vegName"],
                                                    "quan": 1,
                                                    "price": snapshot.data
                                                        .documents[i]["price"]
                                                  };
                                                  Database().addToCart(
                                                      snapshot.data.documents[i]
                                                          ["vegName"],
                                                      sata);
                                                },
                                                child: Text("Add"),
                                              ),
                                            ),
                                          );
                                        }
                                        return Container();
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
      ),
    );
  }
}
