import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/addAddressPage.dart';
import 'package:grocery_home/views/home/common/loading.dart';
import 'package:grocery_home/views/home/paymentPage.dart';
import 'package:grocery_home/views/home/services/database.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key key}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Address"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: Database().getAddresses(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Loading();
                if (snapshot.data.documents.length == 0) {
                  return Container(
                    height: 500,
                    child: Center(child: Text("No saved addresses yet")),
                  );
                }
                return Container(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (var i = 0; i < snapshot.data.documents.length; i++)
                          Container(
                              width: MediaQuery.of(context).size.width / 1.1,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xffD4AFB9),
                                  ),
                                  onPressed: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Name: " +
                                              snapshot.data.documents[i]
                                                  ["name"]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Address Line 1: " +
                                                  snapshot.data.documents[i]
                                                      ["addLine1"]),
                                              Text("Address Line 2: " +
                                                  snapshot.data.documents[i]
                                                      ["addLine2"]),
                                              Text("Landmark: " +
                                                  snapshot.data.documents[i]
                                                      ["landmark"]),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Pincode: " +
                                                  snapshot.data.documents[i]
                                                      ["pincode"]),
                                              Text("City: " +
                                                  snapshot.data.documents[i]
                                                      ["city"]),
                                              Text("State: " +
                                                  snapshot.data.documents[i]
                                                      ["state"]),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Phone Number: " +
                                              snapshot.data.documents[i]
                                                  ["phno"]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("Address Type: " +
                                              snapshot.data.documents[i]
                                                  ["type"]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => PaymentPage(
                                                                  address: "Name: " +
                                                                      snapshot.data.documents[i][
                                                                          "name"] +
                                                                      '\n' +
                                                                      "Address Line 1: " +
                                                                      snapshot.data.documents[i][
                                                                          "addLine1"] +
                                                                      '\n' +
                                                                      "Address Line 2: " +
                                                                      snapshot.data.documents[i][
                                                                          "addLine2"] +
                                                                      '\n' +
                                                                      "Landmark: " +
                                                                      snapshot.data
                                                                              .documents[i]
                                                                          [
                                                                          "landmark"] +
                                                                      '\n' +
                                                                      "Pincode: " +
                                                                      snapshot
                                                                          .data
                                                                          .documents[i]["pincode"] +
                                                                      "\n" +
                                                                      "City: " +
                                                                      snapshot.data.documents[i]["city"] +
                                                                      "\n" +
                                                                      "State: " +
                                                                      snapshot.data.documents[i]["state"] +
                                                                      '\n' +
                                                                      "Phone Number: " +
                                                                      snapshot.data.documents[i]["phno"] +
                                                                      '\n' +
                                                                      "Address Type: " +
                                                                      snapshot.data.documents[i]["type"] +
                                                                      "\n")));
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            primary: Color(
                                                                0xff9CADCE)),
                                                    child:
                                                        Text("Select Address")),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Database().deleteAddress(
                                                        snapshot
                                                            .data
                                                            .documents[i]
                                                            .documentID);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Color(
                                                              0xff0A0908)),
                                                  child: Text(
                                                    "Delete Address",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                      ],
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddAddress()));
                },
                style: ElevatedButton.styleFrom(primary: Color(0xffD1CFE2)),
                child: Text("Add Address")),
            SizedBox(
              height: 38,
            )
          ],
        ),
      ),
    );
  }
}
