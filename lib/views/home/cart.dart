import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_home/views/home/addressPage.dart';
import 'package:grocery_home/views/home/paymentPage.dart';
import 'package:grocery_home/views/home/services/database.dart';

import 'common/loading.dart';

class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

double amount;

class _CartState extends State<Cart> {
  @override
  void initState() {
    amount = 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                StreamBuilder(
                  stream: Database().getCart(),
                  builder: (context, snapshot) {
                    amount = 0;
                    for (var i = 0; i < snapshot.data.documents.length; i++) {
                      amount = amount +
                          int.parse(snapshot.data.documents[i]["price"]) *
                              snapshot.data.documents[i]["quan"];
                    }
                    if (!snapshot.hasData) return Loading();
                    if (snapshot.data.documents.length == 0)
                      return Container(
                        height: 299,
                        child: Center(
                          child: Text("Ooh! Seems like your cart is empty."),
                        ),
                      );
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          for (var i = 0;
                              i < snapshot.data.documents.length;
                              i++)
                            StreamBuilder(
                                stream: Database().getVeggie(),
                                builder: (context, snapshot2) {
                                  if (!snapshot2.hasData) return Container();
                                  var j;
                                  for (j = 0;
                                      j < snapshot2.data.documents.length;
                                      j++) {
                                    if (snapshot.data.documents[i]["name"] ==
                                        snapshot2.data.documents[j]
                                            ["vegName"]) {
                                      return Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xffC6D8D3),
                                            borderRadius:
                                                BorderRadius.circular(7),
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            snapshot2.data
                                                                    .documents[
                                                                j]['photo']),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        snapshot2.data
                                                                .documents[j]
                                                            ['vegName'],
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Rs. " +
                                                            snapshot2.data
                                                                    .documents[
                                                                j]['price'] +
                                                            " /Kg",
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Text(
                                                        "Min. Quantity: " +
                                                            snapshot2.data
                                                                    .documents[j]
                                                                ['minQuantity'],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffDDD1C7),
                                                        border: Border.all(
                                                            color: Color(
                                                                0xff817F75)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0.0),
                                                            margin:
                                                                EdgeInsets.all(
                                                                    0),
                                                            child: IconButton(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            0.0),
                                                                icon: Icon(
                                                                  Icons.remove,
                                                                  size: 18,
                                                                ),
                                                                onPressed: () {
                                                                  if (snapshot
                                                                          .data
                                                                          .documents[i]["quan"] ==
                                                                      1) {
                                                                    Database().delItemFromCart(snapshot
                                                                            .data
                                                                            .documents[i]
                                                                        [
                                                                        "name"]);
                                                                  } else if (snapshot
                                                                          .data
                                                                          .documents[i]["quan"] >
                                                                      1) {
                                                                    Map<String,
                                                                            dynamic>
                                                                        sata = {
                                                                      "name": snapshot2
                                                                          .data
                                                                          .documents[j]["vegName"],
                                                                      "quan":
                                                                          snapshot.data.documents[i]["quan"] -
                                                                              1,
                                                                      "price": snapshot2
                                                                          .data
                                                                          .documents[j]["price"]
                                                                    };
                                                                    Database().addToCart(
                                                                        snapshot2
                                                                            .data
                                                                            .documents[j]["vegName"],
                                                                        sata);
                                                                  }
                                                                }),
                                                          ),
                                                        ),
                                                        Text(snapshot
                                                            .data
                                                            .documents[i]
                                                                ["quan"]
                                                            .toString()),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          margin:
                                                              EdgeInsets.all(0),
                                                          child: IconButton(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(0.0),
                                                              icon: Icon(
                                                                Icons.add,
                                                                size: 18,
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  Map<String,
                                                                          dynamic>
                                                                      sata = {
                                                                    "name": snapshot2
                                                                            .data
                                                                            .documents[j]
                                                                        [
                                                                        "vegName"],
                                                                    "quan": snapshot
                                                                            .data
                                                                            .documents[i]["quan"] +
                                                                        1,
                                                                    "price": snapshot2
                                                                            .data
                                                                            .documents[j]
                                                                        [
                                                                        "price"]
                                                                  };
                                                                  Database().addToCart(
                                                                      snapshot2
                                                                          .data
                                                                          .documents[j]["vegName"],
                                                                      sata);
                                                                });
                                                              }),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  }

                                  return Container();
                                }),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              child: Text(
                                "Total amount: " + amount.toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xff848C8E)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddressPage(amount: amount,)));
                                },
                                child: Text("Confirm Order"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Color(0xff8DB580)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Continue Shopping"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(FontAwesomeIcons.arrowRight),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
