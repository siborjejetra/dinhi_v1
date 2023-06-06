import 'package:Dinhi_v1/Buyer/counter.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../database.dart';
import 'cart.dart';

class ViewProductParent extends StatelessWidget {
  final Map productMap;
  final Map userDetails;
  const ViewProductParent(
      {Key? key, required this.productMap, required this.userDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'View Product',
      home: ViewProductChild(
        productDetails: productMap,
        userDeets: userDetails,
      ),
    );
  }
}

class ViewProductChild extends StatefulWidget {
  final Map productDetails;
  final Map userDeets;
  const ViewProductChild(
      {Key? key, required this.productDetails, required this.userDeets})
      : super(key: key);

  @override
  State<ViewProductChild> createState() => _ViewProductChildState();
}

class _ViewProductChildState extends State<ViewProductChild> {
  Database db = Database();
  TextEditingController quantityController = TextEditingController();
  int count = 0;
  double total = 10.0;

  void handleCountChanged(int newCount) {
    setState(() {
      count = newCount;
    });
  }

  void handlePriceChanged(double newPrice) {
    setState(() {
      total = newPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var total = widget.productDetails['price'];
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 236, 163),
        appBar: buildAppbar(context, 'View Product', true),
        body: Container(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(children: [
                  Container(
                      width: double.maxFinite,
                      height: 350,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(30)),
                      child: Image.network(
                        widget.productDetails['image'],
                        width: 256,
                        height: 256,
                      ) //Insert product image
                      ),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(171, 195, 47, 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              // Insert product name
                              widget.productDetails['name'],
                              style: const TextStyle(
                                fontSize: 24,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              // Insert product price and unit
                              '₱' +
                                  widget.productDetails['price'] +
                                  '/' +
                                  widget.productDetails['unit'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              // Insert product price and unit
                              widget.productDetails['quantity'] +
                                  ' ' +
                                  widget.productDetails['unit'] +
                                  '/s available',

                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black38,
                              ),
                            )
                          ])),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.all(10),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(8)),
                      child: Column(children: [
                        Text(
                          // Insert description
                          widget.productDetails['description'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        )
                      ])),
                  // const SizedBox(height: 10),
                  buildRatingAndReview(widget.productDetails[
                      'rating']), // Insert product rating and list of reviews
                  const SizedBox(height: 30),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildButton('ADD TO CART', widget.productDetails,
                            widget.userDeets),
                        buildButton(
                            'BUY NOW', widget.productDetails, widget.userDeets)
                      ],
                    ),
                  )
                ]))));
  }

  Widget buildRatingAndReview(String rating) {
    // add list of reviews
    return Row(
      children: [
        RatingBarIndicator(
          rating: double.parse(rating),
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Color.fromRGBO(171, 195, 47, 1),
          ),
          itemCount: 5,
          itemSize: 30.0,
          direction: Axis.horizontal,
        ),
        const SizedBox(width: 10),
        Text(
          rating,
          style: const TextStyle(
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 10),
        const SizedBox(
            height: 24,
            child: VerticalDivider(
              color: Colors.black,
            )),
        const SizedBox(width: 15),
        TextButton(
            onPressed: () {},
            child: const Text(
              'View Reviews',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(171, 195, 47, 1),
              ),
            ))
      ],
    );
  }

  Widget buildButton(
      String text, Map prodDetails, Map<dynamic, dynamic> userDetails) {
    // add void onPressed as parameter later

    var total = prodDetails['price'];
    Map<String, dynamic> cloneMap = {};
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 111, 174, 23)),
          // padding:MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ))),
      onPressed: () {
<<<<<<< HEAD
        if (text == 'ADD TO CART') {
          print(userDetails['cart']);
          print(prodDetails['id']);
=======
        if (text == 'CHAT SELLER') {
          ///
        } else if (text == 'ADD TO CART') {
>>>>>>> 5ee84b26db3916551c54e647a767071b006c09a2
          if (!userDetails['cart'].contains(prodDetails['id'])) {
            db.addToCart(prodDetails['id'], userDetails).then((value) {
              userDetails['cart'] = value;
              cloneMap = {...userDetails};

              Get.to(CartParent(
                  userMap: cloneMap)); // CHANGE THIS TO ALERT DIALOGUE ONLY
            });
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Added to Cart',
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20)),
                  content: const Text('You already added this to your cart.',
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
              },
            );
          }
        } else if (text == 'BUY NOW') {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return SimpleDialog(
                  title: const Text(
                    'Enter quantity',
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                  children: [
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
<<<<<<< HEAD
                          Text(
                            '₱' + total,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.black,
                                fontSize: 14),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: Color.fromARGB(255, 111, 174, 23),
                            ),
                            onPressed: () {
                              setState(() {
                                if (count > 0) {
                                  count--;
                                }
                              });
                            },
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromARGB(255, 111, 174, 23)),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: Text(
                              count.toString(),
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.add,
                                color: Color.fromARGB(255, 111, 174, 23)),
                            onPressed: () {
                              setState(() {
                                count++;
                              });
                            },
=======
                          CounterWidget(
                            onCountChanged: handleCountChanged,
                            onPriceChanged: handlePriceChanged,
>>>>>>> 5ee84b26db3916551c54e647a767071b006c09a2
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // print(quantityController.text);
                          // print(prodDetails);
                          List<String> products = [];
                          products.add(prodDetails['id']);
                          total = count * int.parse(prodDetails['price']);
                          db
                              .createTransaction(
                                  userDetails['id'],
                                  count.toString(),
                                  "",
                                  products,
                                  "Pending",
                                  total.toString())
                              .then((value) {
                            // add to user and buyer order list
                            // print(prodDetails['seller_id'] +
                            //     ' ' +
                            //     userDetails['id'] +
                            //     ' ' +
                            //     value);
                            db.addTransaction(userDetails['id'], value,
                                prodDetails['seller_id']);
                          });
                          // exit modal
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "CONFIRM",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 2.2,
                              fontSize: 14),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 111, 174, 23),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          elevation: 5.0,
                        ),
                      ),
                    )
                  ],
                );
              });
        } else {
          ///
        }
      },
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
            // letterSpacing: 2.2,
            color: Colors.white),
      ),
    );
  }
}

Widget buildTextField(String label, TextEditingController controller) {
  return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.only(bottom: 3, left: 10),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: label,
        hintStyle: const TextStyle(
          fontSize: 16,
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ));
}
