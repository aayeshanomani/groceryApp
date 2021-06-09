import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/home.dart';
import 'package:grocery_home/views/home/services/database.dart';
import 'package:grocery_home/views/home/services/helper.dart';
import 'package:grocery_home/views/home/signup.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email, _password, _username;
  final auth = FirebaseAuth.instance;

  bool login = false;

  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog(String title, String message) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xff0A8754),
        title: Center(child: Text("Login")),
      ),
      body: ModalProgressHUD(
        inAsyncCall: login,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/icon.jpeg",
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: "Username",
                        ),
                        onChanged: (val) {
                          setState(() {
                            _username = val.trim();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                        ),
                        onChanged: (val) {
                          setState(() {
                            _password = val.trim();
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              login = !login;
                              if (await Database()
                                  .checkPassword(_username, _password)) {
                                _showMyDialog(
                                    "Error", "No such User Credentials");
                              } else {
                                isLoggedIn = true;
                                await Helper.saveUserloggedIn(true);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              }
                            },
                            child: Text("Sign in"),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffDFA06E))),
                        TextButton(
                          onPressed: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Text("New User? Sign up"),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
