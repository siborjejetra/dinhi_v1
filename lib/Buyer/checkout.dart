import 'dart:io';

import 'package:Dinhi_v1/Buyer/listitemcheckout.dart';
import 'package:Dinhi_v1/utils/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets.dart';

class CheckoutParent extends StatelessWidget {
  final Map<dynamic, dynamic> userMap;
  final Map transaction;

  // final Map<dynamic, dynamic> transactionMap;
  const CheckoutParent(
      {Key? key, required this.userMap, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CheckoutChild(
          userDetails: userMap, transDetails: transaction,
          // transDetails: transactionMap,
        ));
  }
}

class CheckoutChild extends StatefulWidget {
  final Map<dynamic, dynamic> userDetails;
  final Map transDetails;

  // final Map<dynamic, dynamic> transDetails;
  CheckoutChild(
      {Key? key, required this.userDetails, required this.transDetails})
      : super(key: key);

  @override
  State<CheckoutChild> createState() => _CheckoutChildState();
}

class _CheckoutChildState extends State<CheckoutChild> {
  List products = [];
  List productMap = [];
  List<dynamic> cart = [];

  File? inputImage;
  String path = '';
  bool hasUploaded = false;

  @override
  void initState() {
    // TODO: implement initState
    db.readProducts().then((docs) {
      setState(() {
        products = docs;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productMap = widget.transDetails['products'];
    print(productMap);
    // cart = storeUserCart(products, productMap);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 236, 163),
        appBar: buildAppbar(context, 'Checkout', false),
        body: SafeArea(
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
              //List ng products
              Expanded(
                child: ListView.builder(
                  primary: false,
                  itemCount: productMap.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ListItemCheckout(
                          cart: productMap[index],
                          totalCart: widget.transDetails['total'],
                        ),
                      ),
                    );
                  },
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
                child: Column(
                  children: [
                    ListTile(
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
                                  fontSize: 14)),
                          Text('₱ 90.00',
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  color: Colors.white,
                                  fontSize: 14))
                        ],
                      ),
                    ),
                    ListTile(
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
                                  fontSize: 14)),
                          //edit to dropdown
                          Text('GCash',
                              style: TextStyle(
                                  fontFamily: "Montserrat",
                                  color: Colors.white,
                                  fontSize: 14)),
                          IconButton(
                              onPressed: () {
                                pickImage(ImageSource.gallery);
                              },
                              icon: Icon(IconData(0xe048,
                                  fontFamily: 'MaterialIcons')))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
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
                      Text('Total Payment:',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18)),
                      //edit to computer price
                    ],
                  ),
                  subtitle: Text(
                      '₱ ' +
                          (double.parse(widget.transDetails['total']) + 90.00)
                              .toString() +
                          '.00',
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontSize: 18)),
                  trailing: OutlinedButton(
                    onPressed: () {
                      db
                          .createTransaction(
                              widget.userDetails['id'],
                              widget.transDetails['count'].toString(),
                              "",
                              widget.transDetails['products'],
                              "Pending",
                              widget.transDetails['total'].toString())
                          .then((value) {
                        print("HELLLOOOO" +
                            widget.userDetails['id'].toString() +
                            widget.transDetails['seller_id'].toString());
                        db.addTransactiontoBuyer(
                          value,
                          widget.userDetails['id'].toString(),
                        );
                        db.addTransactiontoSeller(
                            value, widget.transDetails['seller_id'].toString());
                      });
                    },
                    child: const Text('CHECKOUT',
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2.2,
                            fontSize: 12)),
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(color: Colors.white, width: 2.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Future pickImage(ImageSource source) async {
    try {
      XFile? pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          inputImage = File(pickedImage.path);
        });
      } else
        return;
    } catch (e) {
      // showFailedToChooseDialog(context);
    }
  }
}

List<dynamic> storeUserCart(List products, List<String>? productID) {
  List storage = [];
  for (var i = 0; i < products.length; i++) {
    if (productID != null) {
      for (var j = 0; j < productID.length; j++) {
        if (products[i]['id'] == productID[j]) {
          storage.add(products[i]);
        }
      }
    } else {
      return storage;
    }
  }
  return storage;
}
