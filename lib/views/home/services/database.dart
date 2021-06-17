import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'helper.dart';

class Database {
  addUser(Map<String, dynamic> userData, String username) {
    bool add;
    FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .set(userData, SetOptions(merge: true))
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
        .where("status", isEqualTo: "confirmed")
        .orderBy("date", descending: true)
        .orderBy("time", descending: true)
        .snapshots();
  }

  getDeliveredOrders() {
    return FirebaseFirestore.instance
        .collection("ordersPlaced")
        .where("status", isEqualTo: "delivered")
        .orderBy("date", descending: true)
        .orderBy("time", descending: true)
        .snapshots();
  }

  getYourOrders() {
    return FirebaseFirestore.instance
        .collection("ordersPlaced")
        .where("username", isEqualTo: username)
        .orderBy("date", descending: true)
        .orderBy("time", descending: true)
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

  getSpecOrderAdmin(String username, String name, String date, String time) {
    return FirebaseFirestore.instance
        .collection("ordersPlaced")
        .where("username", isEqualTo: username)
        .where("name", isEqualTo: name)
        .where("date", isEqualTo: date)
        .where("time", isEqualTo: time)
        .snapshots();
  }

  orderDelivered(String uid) {
    FirebaseFirestore.instance
        .collection("ordersPlaced")
        .doc(uid)
        .set({"status": "delivered"}, SetOptions(merge: true));
  }

  addAdminToken(String token) {
    FirebaseFirestore.instance
        .collection("adminTokens")
        .doc(username)
        .set({"token": token}, SetOptions(merge: true));
  }

  addCustomerToken(String token) {
    FirebaseFirestore.instance
        .collection("cusTokens")
        .doc(username)
        .set({"token": token}, SetOptions(merge: true));
  }

  getUser(String username) {
    return FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .snapshots();
  }

  getAddresses() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .collection("addresses")
        .snapshots();
  }

  saveAddress(Map data) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .collection("addresses")
        .doc()
        .set(data);
  }

  deleteAddress(String docId) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(username)
        .collection("addresses")
        .doc(docId)
        .delete();
  }
}
