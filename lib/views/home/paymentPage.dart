import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/common/loading.dart';
import 'package:grocery_home/views/home/services/database.dart';
import 'package:grocery_home/views/home/services/helper.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'common/widget.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key key, this.address, this.amount}) : super(key: key);
  final String address;
  final double amount;

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

bool load = false;

//TO BE UPDATED WITH ACTUAL PAYMENT

class _PaymentPageState extends State<PaymentPage> {
  Razorpay razorpay;

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      load = false;
    });

    super.initState();
    razorpay = new Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  Map<String, dynamic> data;

  @override
  void dispose() {
    // TODO: implement dispose
    razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ModalProgressHUD(
          inAsyncCall: load,
          child: StreamBuilder(
              stream: Database().getCart(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Loading();
                return Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/payment.jpg",
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 83,
                      ),
                      Text(
                        "Order Summary",
                        style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i = 0;
                              i < snapshot.data.documents.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      (i + 1).toString() +
                                          ". Vegetable: " +
                                          snapshot.data.documents[i]['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "\t Price: Rs. " +
                                          snapshot.data.documents[i]['price'] +
                                          " /Kg",
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "\t Quantity: " +
                                          snapshot.data.documents[i]['quan']
                                              .toString(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Divider(
                        thickness: 6,
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Text(
                        "Total bill amount: " + widget.amount.toString(),
                        style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w800),
                      ),
                      SizedBox(
                        height: 38,
                      ),
                      Container(
                        child: StreamBuilder(
                            stream: Database().getUser(username),
                            builder: (context, snapshot2) {
                              return Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      checkOut(
                                          snapshot2.data.documents[0]["email"],
                                          snapshot2.data.documents[0]
                                              ["phoneNumber"]);
                                      var i;
                                      for (i = 0;
                                          i < snapshot.data.documents.length;
                                          i++) {
                                        data = {
                                          "name": snapshot.data.documents[i]
                                              ["name"],
                                          "price": snapshot.data.documents[i]
                                              ["price"],
                                          "quan": snapshot.data.documents[i]
                                              ["quan"],
                                          "username": username,
                                          "date": DateTime.now()
                                                  .year
                                                  .toString() +
                                              "-" +
                                              DateTime.now().month.toString() +
                                              "-" +
                                              DateTime.now().day.toString(),
                                          "time": DateTime.now()
                                                  .hour
                                                  .toString() +
                                              ":" +
                                              DateTime.now().minute.toString() +
                                              " hours",
                                          "totalAmount": int.parse(snapshot
                                                  .data.documents[i]["price"]) *
                                              snapshot.data.documents[i]
                                                  ["quan"],
                                          "payMethod": "Paid",
                                          "address": widget.address,
                                          "urgent": "no",
                                          "status": "confirmed"
                                        };

                                        print(data.toString());
                                      }
                                    },
                                    child: Text("Pay and place order"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        bool codValid =
                                            await Database().getTotCashOnDel();
                                        if (codValid) {
                                          var i;
                                          for (i = 0;
                                              i <
                                                  snapshot
                                                      .data.documents.length;
                                              i++) {
                                            data = {
                                              "name": snapshot.data.documents[i]
                                                  ["name"],
                                              "price": snapshot
                                                  .data.documents[i]["price"],
                                              "quan": snapshot.data.documents[i]
                                                  ["quan"],
                                              "username": username,
                                              "date": DateTime.now()
                                                      .year
                                                      .toString() +
                                                  "-" +
                                                  DateTime.now()
                                                      .month
                                                      .toString() +
                                                  "-" +
                                                  DateTime.now().day.toString(),
                                              "time": DateTime.now()
                                                      .hour
                                                      .toString() +
                                                  ":" +
                                                  DateTime.now()
                                                      .minute
                                                      .toString() +
                                                  " hours",
                                              "totalAmount": int.parse(snapshot
                                                      .data
                                                      .documents[i]["price"]) *
                                                  snapshot.data.documents[i]
                                                      ["quan"],
                                              "payMethod": "CASH ON DELIVERY",
                                              "address": widget.address,
                                              "urgent": "no",
                                              "status": "confirmed"
                                            };

                                            print(data.toString());

                                            await Database().increaseCodCount();

                                            Database().placeOrder(data);
                                            Database()
                                                .delItemFromCart(data["name"]);
                                            showMyDialog(context, "Success",
                                                    "Order placed successfully")
                                                .then((value) {
                                              Navigator.pop(context);
                                            });
                                          }
                                        } else {
                                          showMyDialog(context, "Error",
                                              "Cannot place COD orders right now.");
                                        }
                                      },
                                      child: Text(
                                        "Choose cash on delivery",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Color(0xff26532B)),
                                    ),
                                  )
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 73,
                      )
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // orderId = 12123;
    // razorpayId = response.paymentId;

    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIosWeb: 4);
    Database().placeOrder(data);
    Database().delItemFromCart(data["name"]);
    showMyDialog(context, "Success", "Order placed successfully").then((value) {
      Navigator.pop(context);
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIosWeb: 4);
  }

  void checkOut(String email, String phoneNumber) {
    var options = {
      "key": "rzp_test_IqSDgl2pq1jlOw",
      "amount": int.parse((widget.amount * 100).toString().split('.')[0]),
      "name": "Tharakari Mandi",
      "description": "Payment for vegetables",
      "prefill": {
        "contact": "+91" + phoneNumber,
        "email": email,
      },
      "external": {
        "wallets": ["paytm"]
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }
}
