import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/home.dart';
import 'package:grocery_home/views/home/login.dart';
import 'package:grocery_home/views/home/services/database.dart';
import 'package:grocery_home/views/home/services/helper.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _email, _password, _username, _confirmPassword;
  final auth = FirebaseAuth.instance;

  bool signup = false;

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
        inAsyncCall: signup,
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Email",
                        ),
                        onChanged: (val) {
                          setState(() {
                            _email = val.trim();
                          });
                        },
                      ),
                    ),
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
                            _password = val;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm Password",
                        ),
                        onChanged: (val) {
                          setState(() {
                            _confirmPassword = val;
                          });
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              signup = !signup;
                              if (!await Database().checkEmail(_email)) {
                                _showMyDialog(
                                    "Error", "The Email already exists");
                              } else if (!await Database()
                                  .checkUsername(_username)) {
                                _showMyDialog(
                                    "Error", "The Username already exists");
                              } else if (_password != _confirmPassword) {
                                _showMyDialog(
                                    "Error", "Passwords should match");
                              } else {
                                Map<String, dynamic> userData = {
                                  "username": _username,
                                  "email": _email,
                                  "password": _password
                                };

                                Database().addUser(userData, _username);

                                isLoggedIn = true;
                                Helper.saveUserloggedIn(true);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home()));
                              }
                            },
                            child: Text("Sign up"),
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xffDFA06E))),
                        TextButton(
                          onPressed: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: Text("Old User? Sign in"),
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
