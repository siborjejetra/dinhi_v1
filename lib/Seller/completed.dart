import 'dart:io';

import 'package:Dinhi_v1/Seller/orderlist.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../Seller/listitem.dart';
import '../utils/user_preference.dart';
import '../widgets.dart';
import '../zoomphoto.dart';

class CompletedParent extends StatelessWidget {
  final Map transaction;
  final List<String>? orderlist;
  const CompletedParent(
      {Key? key, required this.transaction, required this.orderlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CompletedChild(
          transaction: transaction,
          orderlist: orderlist,
        ));
  }
}

class CompletedChild extends StatefulWidget {
  final Map transaction;
  final List<String>? orderlist;
  const CompletedChild(
      {Key? key, required this.transaction, required this.orderlist})
      : super(key: key);

  @override
  State<CompletedChild> createState() => _CompletedChildState();
}

class _CompletedChildState extends State<CompletedChild> {
  Map transDeets = {};
  List users = [];
  Map userDeets = {};
  Map sellerDeets = {};

  String text = '';
  String courier_id = '';
  List<String>? orderlist = [];

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
    sellerDeets = storeUserDeets(users, transDeets['products'][0]['seller_id']);
    courier_id = transDeets['courier_id'];
    orderlist = transDeets['orderlist'];
    print(sellerDeets);
    // print(transDeets);

    TextEditingController textController = new TextEditingController();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 111, 174, 23),
        centerTitle: true,
        title: const Text('Order Details'),
        leading: IconButton(
          onPressed: () {
            Get.to(OrderListParent(
              orderlist: widget.orderlist!,
            ));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
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
                  trailing: Image.network(
                    transDeets['seller_proof'],
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
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
                  title: Text('Proof of Delivery',
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14)),
                  trailing: Image.network(
                    transDeets['courier_proof'],
                    width: 60,
                    height: 60,
                  ),
                ),
              ),
            ],
          )
        ]),
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
