import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/services/database.dart';
import 'package:grocery_home/views/home/services/helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'common/widget.dart';

class PhotoPage extends StatefulWidget {
  const PhotoPage({Key key}) : super(key: key);

  @override
  _PhotoPageState createState() => _PhotoPageState();
}

bool load = false;
PickedFile imageFile1, imageFile2, imageFile3;

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xff0A8754),
          title: Center(child: Text("Upload Photo")),
        ),
        body: ModalProgressHUD(
            inAsyncCall: load,
            child: SingleChildScrollView(
                child: StreamBuilder(
                    stream: Database().getUser(username),
                    builder: (context, snapshot) {
                      return Column(children: [
                        Image.asset(
                          "assets/uploadPhoto.jpg",
                          fit: BoxFit.cover,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                            "We need 3 photos of you to complete the profile."),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 47.0),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Card(
                                    child: (imageFile1 == null)
                                        ? Text("Image 1")
                                        : Container(
                                            height: 188,
                                            child: Image.file(
                                                File(imageFile1.path)),
                                          ),
                                  ),
                                  RaisedButton(
                                    onPressed: () async {
                                      _openCamera(context, 1);
                                    },
                                    child: Text("Select Image"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 47.0),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Card(
                                    child: (imageFile2 == null)
                                        ? Text("Image 2")
                                        : Container(
                                            height: 188,
                                            child: Image.file(
                                                File(imageFile2.path)),
                                          ),
                                  ),
                                  RaisedButton(
                                    onPressed: () async {
                                      _openCamera(context, 2);
                                    },
                                    child: Text("Select Image"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 47.0),
                            child: Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Card(
                                    child: (imageFile3 == null)
                                        ? Text("Image 3")
                                        : Container(
                                            height: 188,
                                            child: Image.file(
                                                File(imageFile3.path)),
                                          ),
                                  ),
                                  RaisedButton(
                                    onPressed: () async {
                                      _openCamera(context, 3);
                                    },
                                    child: Text("Select Image"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(37.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xffF9C80E)),
                              onPressed: () {
                                setState(() {
                                  load = true;
                                });
                                uploadImageToFirebase(context);
                              },
                              child: Text("Upload Photos")),
                        ),
                        SizedBox(
                          height: 83,
                        ),
                      ]);
                    }))));
  }

  void _openCamera(BuildContext context, int c) async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );

    if (c == 1) {
      setState(() {
        imageFile1 = pickedFile;
      });
    } else if (c == 2) {
      setState(() {
        imageFile2 = pickedFile;
      });
    } else if (c == 3) {
      setState(() {
        imageFile3 = pickedFile;
      });
    }
  }

  String uploadImageToFirebase(BuildContext context) {
    if (imageFile1 == null || imageFile2 == null || imageFile3 == null) {
      showMyDialog(context, "Error", "Image file not uploaded");
      setState(() {
        load = false;
      });
    }
    File _imageFile1 = File(imageFile1.path);
    File _imageFile2 = File(imageFile2.path);
    File _imageFile3 = File(imageFile3.path);

    String fileName1 = basename(_imageFile1.path);
    String fileName2 = basename(_imageFile2.path);
    String fileName3 = basename(_imageFile3.path);

    String url1 = "";
    String url2 = "";
    String url3 = "";

    Reference firebaseStorageRef1 =
        FirebaseStorage.instance.ref().child('uploads/$username/$fileName1');
    Reference firebaseStorageRef2 =
        FirebaseStorage.instance.ref().child('uploads/$username/$fileName2');
    Reference firebaseStorageRef3 =
        FirebaseStorage.instance.ref().child('uploads/$username/$fileName3');

    UploadTask uploadTask = firebaseStorageRef1.putFile(_imageFile1);
    uploadTask.then((res) async {
      url1 = await res.ref.getDownloadURL();
      url1 = url1.toString();
      print(url1);

      UploadTask uploadTask2 = firebaseStorageRef1.putFile(_imageFile2);
      uploadTask2.then((res) async {
        url2 = await res.ref.getDownloadURL();
        url2 = url2.toString();
        print(url2);

        UploadTask uploadTask3 = firebaseStorageRef1.putFile(_imageFile3);
        uploadTask3.then((res) async {
          url3 = await res.ref.getDownloadURL();
          url3 = url3.toString();
          print(url3);

          if (url3 != "" && url2 != "" && url1 != "") {
            Map<String, dynamic> data = {
              "photo1": url1,
              "photo2": url2,
              "photo3": url3
            };

            Database().addUser(data, username);
            showMyDialog(context, "Success", "Photos added.").then((value) {
              setState(() {
                load = false;
                Navigator.pop(context);
              });
            });
          } else {
            showMyDialog(context, "Error", "Fill in all the fields.");
          }
        });
      });
    });
  }
}
