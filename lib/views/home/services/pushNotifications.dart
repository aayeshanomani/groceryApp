import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  Future initialize() async {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");
    },
     onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");
    },
     onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    });
    
  }
}
