import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets.dart';
import 'listitemcheckout.dart';

class PlaceOrderParent extends StatelessWidget {
  final Map<dynamic, dynamic> userMap;
  final Map transaction;
  const PlaceOrderParent(
      {Key? key, required this.userMap, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PlaceOrderChild(
          userMap: userMap, transaction: transaction,
          // transDetails: transactionMap,
        ));
  }
}

class PlaceOrderChild extends StatefulWidget {
  final Map<dynamic, dynamic> userMap;
  final Map transaction;
  const PlaceOrderChild(
      {Key? key, required this.userMap, required this.transaction})
      : super(key: key);

  @override
  State<PlaceOrderChild> createState() => _PlaceOrderChildState();
}

class _PlaceOrderChildState extends State<PlaceOrderChild> {
  Map user = {};
  Map transactionData = {};
  List productMap = [];
  List sellerList = [];

  TextEditingController textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    user = widget.userMap;
    transactionData = widget.transaction;
    productMap = transactionData['products'];
    sellerList = storeSellerId(productMap);
    print(sellerList);
    // cart = storeUserCart(products, productMap);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 236, 163),
        appBar: buildAppbar(context, 'Place Order', false),
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
                      user['firstname'] +
                          ' ' +
                          user['lastname'] +
                          ' | ' +
                          user['cellnumber'],
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 14)),
                  subtitle: Text(user['address'],
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
                          totalCart: '0',
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextField(
                    maxLines: 3,
                    controller: textController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: EdgeInsets.only(bottom: 3, left: 10),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Addtional Notes:',
                    )),
              ),
              SizedBox(height: 5),
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 9, 117, 8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Color.fromARGB(255, 236, 236, 163)),
                ),
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Payment:',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16)),
                      //edit to computer price
                    ],
                  ),
                  subtitle: Text(
                      '₱ ' +
                          (num.parse(transactionData['total']) + 90.00)
                              .toString() +
                          '.00',
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontSize: 14)),
                  trailing: OutlinedButton(
                    onPressed: () {
                      for (var seller in sellerList) {
                        List seller_products = [];
                        for (var product in productMap) {
                          if (seller == product['seller_id']) {
                            seller_products.add(product);
                          }
                        }
                        final Map trans = {
                          'buyer_id': user['id'],
                          'buyer_proof': "",
                          'courier_id': "",
                          'seller_id': seller,
                          'courier_proof': "",
                          'status': "Pending",
                          'products': seller_products,
                          'total': transactionData['total'],
                        };

                        print(trans);
                      }
                    },
                    child: const Text('PLACE ORDER',
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
}

List<dynamic> storeSellerId(List products) {
  List storage = [];
  for (var i = 0; i < products.length; i++) {
    if (storage.isEmpty) {
      storage.add(products[i]['seller_id']);
    } else {
      if (storage.contains(products[i]['seller_id']) == false) {
        storage.add(products[i]['seller_id']);
      }
    }
  }
  return storage;
}
