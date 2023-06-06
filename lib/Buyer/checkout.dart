import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets.dart';

class CheckoutParent extends StatelessWidget {
  final Map<dynamic, dynamic> userMap;
  const CheckoutParent({
    Key? key,
    required this.userMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CheckoutChild(userDetails: userMap));
  }
}

class CheckoutChild extends StatefulWidget {
  final Map<dynamic, dynamic> userDetails;
  const CheckoutChild({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  State<CheckoutChild> createState() => _CheckoutChildState();
}

class _CheckoutChildState extends State<CheckoutChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 236, 163),
        appBar: buildAppbar(context, 'Checkout', false),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 6, 88, 6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color.fromARGB(255, 236, 236, 163)),
                ),
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    child: Icon(
                      IconData(0xe3ab, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    ), //BoxDecoration
                  ),
                  title: Text(
                      widget.userDetails['firstname'] +
                          ' ' +
                          widget.userDetails['lastname'] +
                          ' | ' +
                          widget.userDetails['cellnumber'],
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14)),
                  subtitle: Text(widget.userDetails['address'],
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontSize: 12)),
                ),
              ),
              SizedBox(height: 20),
              //insert all products that will be bought
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 9, 117, 8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color.fromARGB(255, 236, 236, 163)),
                ),
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    child: Icon(
                      IconData(0xe40a, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    ), //BoxDecoration
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Shipping Fee',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18)),
                      Text('₱ 90.00',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontSize: 18))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 9, 117, 8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color.fromARGB(255, 236, 236, 163)),
                ),
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    child: Icon(
                      IconData(0xe481, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    ), //BoxDecoration
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mode of Payment',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18)),
                      //edit to dropdown
                      Text('GCash',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontSize: 18))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 9, 117, 8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color.fromARGB(255, 236, 236, 163)),
                ),
                child: ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    child: Icon(
                      Icons.attach_money,
                      color: Colors.white,
                    ), //BoxDecoration
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Payment',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18)),
                      //edit to computer price
                      Text('₱ 10 Million',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontSize: 18))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
