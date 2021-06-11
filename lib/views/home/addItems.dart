import 'package:flutter/material.dart';

class AddItems extends StatefulWidget {
  const AddItems({ Key key }) : super(key: key);

  @override
  _AddItemsState createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5BBA6F),
      appBar: AppBar(
        title: Text('Issue a book'),
        backgroundColor: Color(0xff3FA34D),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(27.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "Book Issued",
                  style: TextStyle(
                      color: Color(0xff2A9134),
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              TextField(
                  onChanged: (value) {
                    
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Name of the Book",
                    hintStyle: TextStyle(fontSize: 18, color: Color(0xff054A29)),
                    alignLabelWithHint: true,
                  ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "on",
                  style: TextStyle(
                      color: Color(0xff137547),
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              TextField(
                  onChanged: (value) {
                    
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Name of the Book",
                    hintStyle: TextStyle(fontSize: 18, color: Color(0xffCDC5B4)),
                    alignLabelWithHint: true,
                  ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26, horizontal: 36),
                child: Text(
                  "by",
                  style: TextStyle(
                      color: Color(0xffB59DA4),
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0),
                ),
              ),
              TextField(
                  onChanged: (value) {
                    
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Name of the Student",
                    hintStyle: TextStyle(fontSize: 18, color: Color(0xffCDC5B4)),
                    alignLabelWithHint: true,
                  ),
              ),
              Padding(
                padding: EdgeInsets.all(37),
                child: RaisedButton(
                onPressed: () {
                  
                },
                child: Text(
                  'Issue the book',
                  style: TextStyle(color: Color(0xffB59DA4)),
                ),
                color: Color(0xff85756E),
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.0),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}