import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[400],
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container
              (
               
                child: Center(
                  child: SpinKitFadingCircle
                  (
                    color: Color(0xff688E26),
                    size: 50.0,
                  ),
                ),
              ),
            ),
            
          ],
        )
      ),
    );
  }
}