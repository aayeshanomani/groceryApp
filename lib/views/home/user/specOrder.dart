import 'package:flutter/material.dart';
import 'package:grocery_home/views/home/services/database.dart';

class SpecOrder extends StatefulWidget {
  final name, date, time;

  const SpecOrder({Key key, this.name, this.date, this.time}) : super(key: key);

  @override
  _SpecOrderState createState() => _SpecOrderState();
}

class _SpecOrderState extends State<SpecOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 65.0),
          child: ElevatedButton(
            style:
                ElevatedButton.styleFrom(primary: Colors.white, elevation: 2),
            onPressed: () {},
            child: StreamBuilder(
              stream: Database()
                  .getSpecOrder(widget.name, widget.date, widget.time),
              builder: (context, snapshot) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        StreamBuilder(
                            stream: Database().getVeg(widget.name),
                            builder: (context, snapshot2) {
                              if (!snapshot2.hasData) return Container();
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Container(
                                  width: 300,
                                  height: 300,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(snapshot2
                                            .data.documents[0]['photo']),
                                      ),
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                              );
                            }),
                            Padding(
                                          padding: const EdgeInsets.all(17.0),
                                          child: Text(
                                            snapshot.data.documents[0]['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Cost: Rs. " +
                                                snapshot.data.documents[0]
                                                    ['price'] +
                                                " /Kg",
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Quantity Ordered: " +
                                                snapshot.data.documents[0]
                                                    ['quan'].toString()
                                                ,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xffCCF5AC),
                                              borderRadius: BorderRadius.circular(4)
                                            ),
                                            
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Total Amount Paid: Rs. " +
                                                    snapshot.data.documents[0]
                                                        ['amountPaid'].toString()
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Date of Order: " +
                                                snapshot.data.documents[0]
                                                    ['date']
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Time of Order: " +
                                                snapshot.data.documents[0]
                                                    ['time']
                                          ),
                                        ),
                                        
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Delivery address: " +
                                                snapshot.data.documents[0]
                                                    ['address']
                                          ),
                                        ),
                                        
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Status: "
                                          ),
                                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
