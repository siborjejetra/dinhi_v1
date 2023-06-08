import 'package:Dinhi_v1/Buyer/listitemcheckout.dart';
import 'package:Dinhi_v1/utils/user_preference.dart';
import 'package:flutter/material.dart';
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
  List<String> productMap = [];
  List<dynamic> cart = [];
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
    productMap = widget.userDetails['cart'];
    cart = storeUserCart(products, productMap);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 236, 163),
        appBar: buildAppbar(context, 'Checkout', false),
        body: SingleChildScrollView(
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

              SizedBox(height: 20),
              //insert all products that will be bought
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
                              fontSize: 18)),
                      Text('₱ 90.00',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontSize: 18))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
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
                              fontSize: 18)),
                      //edit to dropdown
                      Text('GCash',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontSize: 18))
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
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
                      Text('Total Payment',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18)),
                      //edit to computer price
                      Text(widget.transDetails['total'],
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontSize: 18)),
                      ElevatedButton(
                          onPressed: () {
                            print(widget.userDetails['lastname'] as String);
                          },
                          child: Text('asd')),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     primary: false,
              //     itemCount: cart.length,
              //     itemBuilder: (context, index) {
              //       return Padding(
              //         padding: const EdgeInsets.all(4.0),
              //         child: Container(
              //           decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.circular(20),
              //             border: Border.all(color: Colors.grey),
              //           ),
              //           child: ListItemCheckout(
              //             cart: cart[index],
              //             totalCart: widget.transDetails['total'],
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ));
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
