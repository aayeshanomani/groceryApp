import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/adminhome.dart';
import 'package:grocery_home/views/home/common/widget.dart';
import 'package:grocery_home/views/home/services/database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart';

class AddItems extends StatefulWidget {
  const AddItems({Key key}) : super(key: key);

  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  PickedFile imageFile;
  Future _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  bool load = false;
  String name = "", price = "", minq = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        title: Text('Add Vegetable'),
        backgroundColor: Color(0xff6D3D14),
      ),
      body: ModalProgressHUD(
        inAsyncCall: load,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(27.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                  child: Text(
                    "Vegetable",
                    style: TextStyle(
                        color: Color(0xff551B14),
                        fontSize: 28,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                      borderRadius: BorderRadius.circular(72),
                    ),
                    hintText: "Name of the Vegetable",
                    hintStyle:
                        TextStyle(fontSize: 18, color: Color(0xff551B14)),
                    alignLabelWithHint: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                  child: Text(
                    "Price per Kg",
                    style: TextStyle(
                        color: Color(0xff551B14),
                        fontSize: 28,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      price = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                      borderRadius: BorderRadius.circular(72),
                    ),
                    hintText: "Price of the Vegetable",
                    hintStyle:
                        TextStyle(fontSize: 18, color: Color(0xff551B14)),
                    alignLabelWithHint: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                  child: Text(
                    "Minimum quantity allowed",
                    style: TextStyle(
                        color: Color(0xff551B14),
                        fontSize: 28,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0),
                  ),
                ),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      minq = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                      borderRadius: BorderRadius.circular(72),
                    ),
                    hintText: "Min. Quantity",
                    hintStyle:
                        TextStyle(fontSize: 18, color: Color(0xff551B14)),
                    alignLabelWithHint: true,
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 47.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Card(
                            child: (imageFile == null)
                                ? Text("Choose Image")
                                : Image.file(File(imageFile.path)),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              _showChoiceDialog(context);
                            },
                            child: Text("Select Image"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(37),
                  child: RaisedButton(
                      onPressed: () async {
                        setState(() {
                          load = true;
                        });
                        uploadImageToFirebase(context);
                      },
                      child: Text(
                        'Add the Vegetable',
                        style: TextStyle(color: Color(0xff412234)),
                      ),
                      color: Color(0xffEAD7D7),
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = pickedFile;
    });

    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
    Navigator.pop(context);
  }

  String uploadImageToFirebase(BuildContext context) {
    File _imageFile = File(imageFile.path);
    String fileName = basename(_imageFile.path);
    String url;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putFile(_imageFile);
    uploadTask.then((res) async {
      url = await res.ref.getDownloadURL();
      url = url.toString();
      print(url);

      if (name != "" && price != "" && minq != "") {
        Map<String, dynamic> data = {
          "vegName": name,
          "price": price,
          "minQuantity": minq,
          "photo": url,
        };

        Database().uploadVeggie(data, name);
        showMyDialog(context, "Success", "Vegetable added to database")
            .then((value) {
          setState(() {
            load = false;
            Navigator.pop(context);
          });
        });
      }
    });
  }
}
