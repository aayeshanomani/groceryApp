import 'package:flutter/material.dart';
import 'package:grocery_home/models/categories.dart';
import 'package:grocery_home/views/home/model/grocery_categories.dart';
import 'package:grocery_home/views/home/veggie.dart';

class HomeShopByCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeShopByCategoryState();
  }
}

class HomeShopByCategoryState extends State<HomeShopByCategory> {
  List<GroceryCategories> allCategories = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      allCategories = (categories as List).map((i) {
        return GroceryCategories.fromJson(i);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        height: MediaQuery.of(context).size.height / 6,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Vegiie()));
          },
          child: ShopByCategory(
            img: "assets/category/Category4.jpg",
            category_name: "Vegetables",
            color1: Color.fromARGB(100, 0, 0, 0),
            color2: Color.fromARGB(100, 0, 0, 0),
          ),
        ));
  }

  // Function to be called on click
  void _onTileClicked(int index) {
    debugPrint("You tapped on item $index");
  }
}

class ShopByCategory extends StatefulWidget {
  final String img;
  final String category_name;
  final Color color1;
  final Color color2;

  ShopByCategory({
    Key,
    key,
    @required this.img,
    @required this.category_name,
    @required this.color1,
    @required this.color2,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShopByCategoryState();
  }
}

class ShopByCategoryState extends State<ShopByCategory> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(right: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Image.asset(
                widget.img,
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.height / 6,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  stops: [0.2, 0.7],
                  colors: [
                    widget.color1,
                    widget.color2,
                  ],
                  // stops: [0.0, 0.1],
                ),
              ),
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.height / 6,
            ),
            Container(
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.height / 6,
              padding: EdgeInsets.all(1),
              constraints: BoxConstraints(
                minWidth: 20,
                minHeight: 20,
              ),
              child: Center(
                child: Text(
                  widget.category_name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
