import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/common/widget.dart';
import 'package:grocery_home/views/home/services/database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key key}) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

String name = "",
    addLine1 = "",
    addLine2 = "",
    pinCode = "",
    landmark = "",
    phoneNumber = "",
    city = "",
    state = "",
    type = "";

bool load = false;

class _AddAddressState extends State<AddAddress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Address"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: load,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Name",
                    ),
                    onChanged: (val) {
                      setState(() {
                        name = val.trim();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Address Line 1",
                    ),
                    onChanged: (val) {
                      setState(() {
                        addLine1 = val.trim();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Address Line 2",
                    ),
                    onChanged: (val) {
                      setState(() {
                        addLine2 = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Landmark (optional)",
                    ),
                    onChanged: (val) {
                      setState(() {
                        landmark = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Pincode",
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        pinCode = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "City",
                    ),
                    onChanged: (val) {
                      setState(() {
                        city = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "State",
                    ),
                    onChanged: (val) {
                      setState(() {
                        state = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (val) {
                      setState(() {
                        phoneNumber = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Address Type: home, office etc.",
                    ),
                    onChanged: (val) {
                      setState(() {
                        type = val;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        if (name != "" &&
                            addLine1 != "" &&
                            addLine2 != "" &&
                            pinCode != "" &&
                            city != "" &&
                            state != "" &&
                            phoneNumber != "") {
                          setState(() {
                            load = true;
                          });
                          Map<String, dynamic> data = {
                            "name": name,
                            "addLine1": addLine1,
                            "addLine2": addLine2,
                            "landmark": landmark,
                            "pincode": pinCode,
                            "city": city,
                            "state": state,
                            "phno": phoneNumber,
                            "type": type
                          };
                          Database().saveAddress(data);
                          showMyDialog(context, "Success", "Address Saved")
                              .then((value) {
                            setState(() {
                              load = false;
                              Navigator.pop(context);
                            });
                          });
                        } else {
                          showMyDialog(
                              context, "Error", "Fill in all the fields.");
                        }
                      },
                      child: Text("Save Address")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
