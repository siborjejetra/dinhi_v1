import 'package:Dinhi_v1/Buyer/checkout.dart';
import 'package:Dinhi_v1/Buyer/listitem.dart';
import 'package:flutter/material.dart';
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
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CartChild(userDetails: userMap));
  }
}

class CartChild extends StatefulWidget {
  final Map<dynamic, dynamic> userDetails;
  const CartChild({Key? key, required this.userDetails}) : super(key: key);

  @override
  State<CartChild> createState() => _CartChildState();
}

class _CartChildState extends State<CartChild> {
  List<dynamic> cart = [];
  int count = 1;
  double total = 0.0; // Initialize total to 0.0

  void updateTotal(double updatedTotalCart) {
    setState(() {
      total = updatedTotalCart; // Update the total value
    });
  }

  List<String>? productID = [];
  List products = [];

  @override
  void initState() {
    // TODO: implement initState
    db.readProducts().then((docs) {
      setState(() {
        products = docs;
        total = calculateTotalCart();
      });
    });
    super.initState();
  }

  double calculateTotalCart() {
    double total = 0.0;
    productID = widget.userDetails['cart'];
    cart = storeUserCart(products, productID);
    for (var item in cart) {
      double price = double.parse(item['price']);
      int quantity = int.parse(item['quantity']);
      total += price * quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    Map userDetails = widget.userDetails;
    productID = widget.userDetails['cart'];
    cart = storeUserCart(products, productID);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 236, 163),
      appBar: buildAppbar(context, 'My Cart', false),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
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
                                child: CustomListItem(
                                    cart: cart[index],
                                    totalCart: total,
                                    updateTotal: updateTotal),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 200),
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
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 111, 174, 23),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              total.toString(),
              style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 14),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 50)),
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
                          child: const Text(
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
                Navigator.of(context).pop();
                Get.to(CheckoutParent(userMap: userDetails));
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

  List<dynamic> genList(int items) {
    List countList = [];
    var count = 1;
    for (var i = 0; i < items; i++) {
      countList.add(count);
    }
    return countList;
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
