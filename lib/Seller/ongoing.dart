import 'dart:io';

import 'package:Dinhi_v1/Seller/orderlist.dart';
import 'package:Dinhi_v1/Seller/riderlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/user_preference.dart';
import '../widgets.dart';
import '../zoomphoto.dart';
import 'listitem.dart';

class OngoingParent extends StatelessWidget {
  final Map transaction;
  const OngoingParent({Key? key, required this.transaction}) : super(key: key);

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
    print(userDeets);
    // print(transDeets);

    TextEditingController textController = new TextEditingController();

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
                itemCount: transDeets['itemList'].length,
                itemBuilder: (context, index) {
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
                      IconData(0xe481, fontFamily: 'MaterialIcons'),
                      color: Colors.white,
                    ), //BoxDecoration
                  ),
                  title: Text('Seller Proof',
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14)),
                  trailing: InkWell(
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
                ),
              ),
            ],
          )
        ]),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 111, 174, 23)),
            padding:
                MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ))),
        onPressed: () {
          if (inputImage != null) {
            // Add the calculation of quantity deducted by count or deletion of product if out of stock
            Map<String, dynamic> newTransaction = {};
            newTransaction = {...transDeets};
            newTransaction['status'] = 'Ongoing';
            Get.to(RiderListParent(
              transaction: newTransaction,
              seller_proof: inputImage,
            ));
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
                              color: Color.fromARGB(255, 111, 174, 23),
                            ),
                          )),
                    ],
                  );
                });
          }
        },
        child: const Text(
          'CONFIRM',
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              letterSpacing: 2.2,
              color: Colors.white),
        ),
      ),
    );
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
