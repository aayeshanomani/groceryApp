import 'package:flutter/material.dart';
import 'package:grocery_home/utils/colors_utils.dart';
import 'package:grocery_home/utils/string_utils.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      backgroundColor: Colors.white,
     
      title: Text(
        "Home"
      ),
    );
  }

  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}