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
  int count = 1;

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Map userDetails = widget.userDetails;
    productID = widget.userDetails['cart'];
    cart = storeUserCart(products, productID);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      appBar: buildAppbar(context, 'My Cart', false),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: Container(
                  child: cart.isNotEmpty
                      ? ListView.builder(
                          primary: false,
                          itemCount: cart.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    print(cart[index]['seller_id']);
                                  },
                                  title: Text(cart[index]['name']),
                                  subtitle: Text(cart[index]['price'] +
                                      '/' +
                                      cart[index]['unit']),
                                  leading: Container(
                                    width: 60,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              cart[index]['image']),
                                          fit: BoxFit.scaleDown),
                                      borderRadius: BorderRadius.circular(20),
                                    ), //BoxDecoration
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          setState(() {
                                            if (cart[index]['count'] > 0) {
                                              cart[index]['count']--;
                                            }
                                          });
                                        },
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Text(
                                          cart[index]['count'].toString(),
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            cart[index]['count']++;
                                          });
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: () {
                                          setState(() {
                                            deleteItem(index);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 200),
                            child: Column(
                              children: const [
                                Text(
                                  'Empty Cart',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      color: Colors.black,
                                      fontSize: 30),
                                ),
                                Text(
                                  'Please continue shopping',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      color: Colors.black54,
                                      fontSize: 25),
                                ),
                              ],
                            ),
                          ),
                        )))),
      bottomNavigationBar: Container(
        // padding: EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 111, 174, 23),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Total: 12312312',
                style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14),
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 50)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ))),
                onPressed: () {
                  // Perform checkout logic here
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text(
                          'Checkout',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                        content: const Text('Order placed successfully.',
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.black,
                                fontSize: 14)),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Color.fromARGB(255, 111, 174, 23),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: const Text('CHECKOUT',
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 9, 117, 8),
                        letterSpacing: 2.2,
                        fontSize: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<dynamic> storeUserCart(List products, List<String>? productID) {
    List storage = [];
    int count = 1;
    for (var i = 0; i < products.length; i++) {
      if (productID != null) {
        for (var j = 0; j < productID.length; j++) {
          if (products[i]['id'] == productID[j]) {
            products[i]['count'] = count;
            storage.add(products[i]);
          }
        }
      } else {
        return storage;
      }
    }
    return storage;
  }

  void deleteItem(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  // Make list of counts for calculation
  // Make map in calculation of total

  // Map<dynamic, dynamic> calculateTotal(int count) {
  //   for (var i)
  // }
}
