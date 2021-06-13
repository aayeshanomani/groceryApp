import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'helper.dart';

class Database {
  addUser(Map<String, dynamic> userData, String username) {
    bool add;
    FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .set(userData)
        .then((value) {
      print("User added.");
    }).catchError((err) {
      print(err.toString());
    });
  }

  Future<bool> checkUsername(String username) async {
    final result = await FirebaseFirestore.instance
        .collection("users")
        .where('username', isEqualTo: username)
        .get();
    print(result);
    return result.docs.isEmpty;
  }

  Future<bool> checkEmail(String email) async {
    final result = await FirebaseFirestore.instance
        .collection("users")
        .where('email', isEqualTo: email)
        .get();
    print(result);
    return result.docs.isEmpty;
  }

  Future<bool> checkPassword(String username, String password) async {
    final result = await FirebaseFirestore.instance
        .collection("users")
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get();
    print(result);
    return result.docs.isEmpty;
  }

  uploadVeggie(Map data, String name) {
    FirebaseFirestore.instance
        .collection("vegetables")
        .doc(name)
        .set(data, SetOptions(merge: true))
        .then((value) {
      print("Veggie added.");
    }).catchError((err) {
      print(err.toString());
    });
  }

  getVeggie() {
    return FirebaseFirestore.instance.collection("vegetables").snapshots();
  }

  delVeggie(String name) {
    FirebaseFirestore.instance.collection("vegetables").doc(name).delete();
  }

  addToCart(String name, Map data) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .collection("cart")
        .doc(name)
        .set(data, SetOptions(merge: true));
  }

  getCart() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .collection("cart")
        .snapshots();
  }

  delItemFromCart(String name) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .collection("cart")
        .doc(name)
        .delete();
  }

  placeOrder(Map data) {
    FirebaseFirestore.instance
        .collection("ordersPlaced")
        .doc()
        .set(data, SetOptions(merge: true));
  }

  getOrders() {
    return FirebaseFirestore.instance
        .collection("ordersPlaced")
        .orderBy("date", descending: true)
        .orderBy("time", descending: true)
        .snapshots();
  }

  getYourOrders() {
    return FirebaseFirestore.instance
        .collection("ordersPlaced")
        .where("username", isEqualTo: username)
        .orderBy("date")
        .orderBy("time")
        .snapshots();
  }

  getVeg(String name) {
    return FirebaseFirestore.instance
        .collection("vegetables")
        .where("vegName", isEqualTo: name)
        .snapshots();
  }

  getSpecOrder(String name, String date, String time) {
    return FirebaseFirestore.instance
        .collection("ordersPlaced")
        .where("username", isEqualTo: username)
        .where("name", isEqualTo: name)
        .where("date", isEqualTo: date)
        .where("time", isEqualTo: time)
        .snapshots();
  }
}
