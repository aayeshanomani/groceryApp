import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/adminhome.dart';
import 'package:grocery_home/views/home/home.dart';
import 'package:grocery_home/views/home/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grocery_home/views/home/services/helper.dart';
import 'package:grocery_home/views/home/services/pushNotifications.dart';



void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (isLoggedIn == false) {
    isLoggedIn = await Helper.getUserloggedIn();
  }
  if (isLoggedIn == null) {
    isLoggedIn = false;
  } else {
    username = await Helper.getUsername();
  }
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};



class MyApp extends StatelessWidget {
  

  MaterialColor rosemadder = MaterialColor(0xffC2CFB2, color);

  MaterialColor darkSeaGreen = MaterialColor(0xff86BA90, color);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grocery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: rosemadder,
        accentColor: darkSeaGreen,
      ),
      home: isLoggedIn
          ? username == 'admin'
              ? adminHome()
              : Home()
          : Login(),
    );
  }
}
