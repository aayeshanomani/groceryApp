import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/common/loading.dart';
import 'package:grocery_home/views/home/services/database.dart';
import 'package:grocery_home/views/home/services/helper.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key key}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

bool load = false;

//TO BE UPDATED WITH ACTUAL PAYMENT

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: load,
        child: StreamBuilder(
            stream: Database().getCart(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Loading();
              return Center(
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      load = true;
                      var i;
                      for (i = 0; i < snapshot.data.documents.length; i++) {
                        Map<String, dynamic> data = {
                          "name": snapshot.data.documents[i]["name"],
                          "price": snapshot.data.documents[i]["price"],
                          "quan": snapshot.data.documents[i]["quan"],
                          "username": username,
                          "date": DateTime.now().day.toString() +
                              "-" +
                              DateTime.now().month.toString() +
                              "-" +
                              DateTime.now().year.toString(),
                          "time": DateTime.now().hour.toString() +
                              ":" +
                              DateTime.now().minute.toString() +
                              " hours",
                          "amountPaid":
                              int.parse(snapshot.data.documents[i]["price"]) *
                                  snapshot.data.documents[i]["quan"],
                          "address": "",
                          "urgent": "no",
                        };

                        print(data.toString());
                        Database().placeOrder(data);
                        Database().delItemFromCart(data["name"]);
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Pay and place order"),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
