import 'dart:io';

import 'package:Dinhi_v1/Seller/orderlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../utils/user_preference.dart';
import '../widgets.dart';

class RiderListParent extends StatelessWidget {
  final Map transaction;
  final File? seller_proof;
  final Map sellerDeets;
  const RiderListParent(
      {Key? key,
      required this.transaction,
      required this.seller_proof,
      required this.sellerDeets})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: RiderListChild(
          transaction: transaction,
          seller_proof: seller_proof,
          sellerDeets: sellerDeets,
        ));
  }
}

class RiderListChild extends StatefulWidget {
  final Map transaction;
  final File? seller_proof;
  final Map sellerDeets;
  const RiderListChild(
      {Key? key,
      required this.transaction,
      required this.seller_proof,
      required this.sellerDeets})
      : super(key: key);

  @override
  State<RiderListChild> createState() => _RiderListChildState();
}

class _RiderListChildState extends State<RiderListChild> {
  List users = [];
  List riders = [];
  List<String> orderlist = [];
  Map transaction = {};
  Map sellerDeets = {};
  File? inputImage;
  int? _selectedOption;
  var element;

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
    transaction = widget.transaction;
    sellerDeets = widget.sellerDeets;
    List dynamiclist = sellerDeets['orderlist'];
    orderlist = dynamiclist.cast<String>();
    riders = storeUserDeets(users);
    inputImage = widget.seller_proof;

    // print(riders);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 236, 163),
        appBar: buildAppbar(context, 'Courier List', false),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: riders.isNotEmpty
                    ? ListView.builder(
                        // shrinkWrap: true,
                        itemCount: riders.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: RadioListTile(
                                value: index,
                                groupValue: _selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedOption = value as int?;
                                    print(_selectedOption);
                                  });
                                },
                                activeColor: Color.fromARGB(255, 111, 174, 23),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                toggleable: true,
                                title: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              riders[index]['image']),
                                          fit: BoxFit.scaleDown,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                            riders[index]['firstname'] +
                                                ' ' +
                                                riders[index]['lastname'] +
                                                ' | ' +
                                                riders[index]['cellnumber'],
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 111, 174, 23),
                                                fontSize: 14)),
                                        Text(
                                            'Plate Number: ' +
                                                riders[index]['plate_no'],
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                color: Color.fromARGB(
                                                    255, 111, 174, 23))),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          // ));
                        },
                      )
                    : Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 200),
                          child: Column(
                            children: const [
                              Text(
                                'No Available Rider',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    color: Colors.black,
                                    fontSize: 30),
                              ),
                              Text(
                                'Please wait or reload page',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: "Montserrat",
                                    color: Colors.black54,
                                    fontSize: 25),
                              ),
                            ],
                          ),
                        ),
                      ))),
        bottomNavigationBar:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 111, 174, 23)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ))),
            onPressed: () {
              Map<String, dynamic> newTransaction = {};
              newTransaction = {...transaction};
              newTransaction['courier_id'] = riders[_selectedOption!]['id'];
              db
                  .sellerEditTransaction(
                      transaction, newTransaction, inputImage)
                  .then((value) {
                print(value);
                db.addTransactiontoCourier(value['id'], value['courier_id']);
                Get.to(OrderListParent(orderlist: orderlist));
              });
            },
            child: const Text(
              'SELECT',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  letterSpacing: 2.2,
                  color: Colors.white),
            ),
          ),
          OutlinedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50)),
                  elevation: MaterialStateProperty.all(2),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ))),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    letterSpacing: 2.2,
                    color: Color.fromARGB(255, 111, 174, 23)),
              ))
        ]));
  }
}

List storeUserDeets(List users) {
  List storage = [];
  for (var i = 0; i < users.length; i++) {
    if (users[i]['usertype'] == 'Courier') {
      storage.add(users[i]);
    }
  }
  return storage;
}
