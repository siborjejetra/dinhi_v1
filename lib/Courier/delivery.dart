import 'dart:io';

import 'package:Dinhi_v1/Courier/deliverylist.dart';
import 'package:Dinhi_v1/Seller/orderlist.dart';
import 'package:Dinhi_v1/Seller/riderlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/user_preference.dart';
import '../widgets.dart';
import '../Courier/listitem.dart';
import '../zoomphoto.dart';

class DeliveryParent extends StatelessWidget {
  final Map transaction;
  const DeliveryParent({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DeliveryChild(transaction: transaction));
  }
}

class DeliveryChild extends StatefulWidget {
  final Map transaction;
  const DeliveryChild({Key? key, required this.transaction}) : super(key: key);

  @override
  State<DeliveryChild> createState() => _DeliveryChildState();
}

class _DeliveryChildState extends State<DeliveryChild> {
  Map transDeets = {};
  List users = [];
  Map userDeets = {};
  String text = '';

  File? inputImage;

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
    Map courierDeets = storeUserDeets(users, transDeets['courier_id']);
    Map<String, dynamic> newTransaction = {};
    // print(transDeets);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 236, 163),
        appBar: buildAppbar(context, 'Delivery Information', false),
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
                itemCount: transDeets['itemList'].length,
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
                        cart: transDeets['itemList'][index],
                        totalCart: transDeets['total'],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 5),
          Column(
            children: [
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
                      IconData(0xe4b7, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    ), //BoxDecoration
                  ),
                  title: Text('Proof of Payment',
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14)),
                  trailing: InkWell(
                    child: Image.network(
                      transDeets['buyer_proof']!,
                      width: 60,
                      height: 60,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ZoomablePhotoView(
                              imageUrl: transDeets['buyer_proof']),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 5),
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
                      IconData(0xe4b7, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    ), //BoxDecoration
                  ),
                  title: Text('Item Image',
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14)),
                  trailing: InkWell(
                    child: Image.network(
                      transDeets['seller_proof']!,
                      width: 60,
                      height: 60,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ZoomablePhotoView(
                              imageUrl: transDeets['seller_proof']),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ])),
        bottomNavigationBar: text.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 111, 174, 23)),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 50)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ))),
                    onPressed: () {
                      newTransaction['notes'] = 'Ready to Ship';
                      db
                          .courierEditTransaction(
                              transDeets, newTransaction, courierDeets)
                          .then((value) {
                        Get.to(DeliveryListParent(
                            deliverylist: value['deliverylist']));
                      });
                    },
                    child: const Text(
                      'ACCEPT',
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Montserrat',
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  ),
                  OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.redAccent),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 50)),
                          elevation: MaterialStateProperty.all(2),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ))),
                      onPressed: () {
                        newTransaction['notes'] =
                            'The rider refused to deliver this order due to some reasons.';
                        db
                            .courierEditTransaction(
                                transDeets, newTransaction, courierDeets)
                            .then((value) {
                          Get.to(DeliveryListParent(
                              deliverylist: value['deliverylist']));
                        });
                      },
                      child: const Text(
                        'REJECT',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            letterSpacing: 2.2,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ))
                ],
              )
            : Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 111, 174, 23),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'PROOF OF DELIVERY',
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                    InkWell(
                      child: inputImage != null
                          ? Image.file(
                              inputImage!,
                              width: 60,
                              height: 60,
                            )
                          : Icon(
                              IconData(0xe048, fontFamily: 'MaterialIcons'),
                              color: Colors.white,
                            ),
                      onTap: () {
                        pickImage(ImageSource.gallery);
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(horizontal: 50)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ))),
                      onPressed: () {
                        if (inputImage != null) {
                          Map<String, dynamic> newTransaction = {};
                          newTransaction = {...transDeets};
                          newTransaction['status'] = 'Completed';
                          db
                              .addCourierProofTransaction(
                                  transDeets, newTransaction, inputImage)
                              .then((value) => DeliveryListParent(
                                  deliverylist: userDeets['deliverylist']));
                        } else {
                          // Show dialogue saying "Please provide seller proof"
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('No uploaded image',
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 20)),
                                  content: const Text(
                                      'Please provide seller proof before you proceed.',
                                      style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Colors.black,
                                          fontSize: 14)),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            color: Color.fromARGB(
                                                255, 111, 174, 23),
                                          ),
                                        )),
                                  ],
                                );
                              });
                        }
                      },
                      child: const Text('PRODUCT DELIVERED',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 9, 117, 8),
                              letterSpacing: 2.2,
                              fontSize: 12)),
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

Map<dynamic, dynamic> storeUserDeets(List users, String userID) {
  Map storage = {};
  for (var i = 0; i < users.length; i++) {
    if (users[i]['id'] == userID) {
      storage = users[i];
    }
  }
  return storage;
}
