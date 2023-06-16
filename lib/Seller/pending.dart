import 'dart:io';

import 'package:Dinhi_v1/Seller/orderlist.dart';
import 'package:Dinhi_v1/Seller/riderlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../utils/user_preference.dart';
import '../widgets.dart';
import 'listitem.dart';

class OrderParent extends StatelessWidget {
  final Map transaction;
  const OrderParent({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OrderChild(transaction: transaction));
  }
}

class OrderChild extends StatefulWidget {
  final Map transaction;
  const OrderChild({Key? key, required this.transaction}) : super(key: key);

  @override
  State<OrderChild> createState() => _OrderChildState();
}

class _OrderChildState extends State<OrderChild> {
  Map transDeets = {};
  List users = [];
  Map userDeets = {};
  String text = '';

  @override
  void initState() {
    // TODO: implement initState
    db.readUsers().then((docs) {
      setState(() {
        users = docs;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    transDeets = widget.transaction;
    userDeets = storeUserDeets(users, transDeets['buyer_id']);
    // print(transDeets);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      appBar: buildAppbar(context, 'Order Details', false),
      body: SafeArea(
          child: Column(children: <Widget>[
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
                userDeets['firstname'] +
                    ' ' +
                    userDeets['lastname'] +
                    ' | ' +
                    userDeets['cellnumber'],
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14)),
            subtitle: Text(userDeets['address'],
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontSize: 12)),
          ),
        ),
        SizedBox(height: 5),
        Center(
          child: Text(
            'Product List',
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                letterSpacing: 2.2,
                color: Color.fromARGB(255, 6, 88, 6)),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 6, 88, 6),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color.fromARGB(255, 236, 236, 163)),
            ),
            child: ListView.builder(
              primary: false,
              itemCount: transDeets['products'].length,
              itemBuilder: (context, index) {
                print(transDeets['total']);
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: ListItem(
                      cart: transDeets['products'][index],
                      totalCart: transDeets['total'].toString(),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 6, 88, 6),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color.fromARGB(255, 236, 236, 163)),
              ),
              child: (transDeets['notes'] == 'Order Placed')
                  ? ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        child: Icon(
                          IconData(0xf0555, fontFamily: 'MaterialIcons'),
                          color: Colors.white,
                        ), //BoxDecoration
                      ),
                      title: Text('Is this available?',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14)),
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check),
                            color: Color.fromARGB(255, 171, 195, 47),
                            onPressed: () {
                              setState(() {
                                text = 'Order Confirmed';
                              });

                              Map<String, dynamic> newTransaction = {};
                              newTransaction['notes'] = text;
                              newTransaction['status'] = 'Pending';

                              db
                                  .editTransaction(
                                      transDeets, newTransaction, null)
                                  .then((value) {
                                Get.back();
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            color: Colors.red,
                            onPressed: () {
                              setState(() {
                                text =
                                    'Sorry. There seems to have some issue in this order. I\'ll cancel this order for now. Thank you.';
                              });

                              Map<String, dynamic> newTransaction = {};
                              newTransaction['notes'] = text;
                              newTransaction['status'] = 'Cancelled';

                              db
                                  .editTransaction(
                                      transDeets, newTransaction, null)
                                  .then((value) {
                                Get.back();
                              });
                            },
                          ),
                        ],
                      ))
                  : ListTile(
                      leading: Container(
                        width: 60,
                        height: 60,
                        child: Icon(
                          IconData(0xe3e0, fontFamily: 'MaterialIcons'),
                          color: Colors.white,
                        ), //BoxDecoration
                      ),
                      title: Text('Waiting for response from buyer..',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14)),
                    )),
        ),
      ])),
    );
  }
}

Map<dynamic, dynamic> storeUserDeets(List users, String userID) {
  Map storage = {};
  for (var i = 0; i < users.length; i++) {
    if (users[i]['id'] == userID) {
      storage = users[i];
    }
  }
  return storage;
}
