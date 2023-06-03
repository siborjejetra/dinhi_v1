import 'package:Dinhi_v1/Buyer/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../utils/user_preference.dart';
import '../widgets.dart';

class CartParent extends StatelessWidget {
  final Map<dynamic, dynamic> userMap;
  const CartParent({
    Key? key,
    required this.userMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CartChild(userDetails: userMap));
  }
}

class CartChild extends StatefulWidget {
  final Map<dynamic, dynamic> userDetails;
  const CartChild({Key? key, required this.userDetails}) : super(key: key);

  @override
  State<CartChild> createState() => _CartChildState();
}

class _CartChildState extends State<CartChild> {
  List<String>? productID = [];
  List products = [];
  List cart = [];
  bool isChecked = false;

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
    Map userDetails = widget.userDetails;
    productID = widget.userDetails['cart'];
    cart = storeUserCart(products, productID);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: Container(
                  child: ListView(
                primary: false,
                children: <Widget>[
                  for (int i = 0; i < cart.length; i++)
                    InkWell(
                        onTap: () {
                          Get.to(() =>
                              ItemParent()); // add more items in this screen
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(111, 174, 23, 1),
                            border: Border.all(color: Colors.greenAccent),
                            borderRadius: BorderRadius.circular(20),
                          ), //BoxDecoration
                          child: CheckboxListTile(
                            title: Text(cart[i]['name']),
                            subtitle:
                                Text(cart[i]['price'] + '/' + cart[i]['unit']),
                            secondary: Image.network(cart[i]['imagePath']),
                            autofocus: false,
                            activeColor: Colors.black,
                            checkColor: Colors.white,
                            selected: isChecked,
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ), //CheckboxListTile
                        )),
                ],
              )))),
    );
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
}
