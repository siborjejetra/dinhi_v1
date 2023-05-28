import 'package:Dinhi_v1/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../database.dart';

class ViewProductParent extends StatelessWidget {
  final Map productMap;
  ViewProductParent({required this.productMap});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'View Product',
      home: ViewProductChild(
        productDetails: productMap,
      ),
    );
  }
}

class ViewProductChild extends StatefulWidget {
  final Map productDetails;
  ViewProductChild({required this.productDetails});

  @override
  State<ViewProductChild> createState() => _ViewProductChildState();
}

class _ViewProductChildState extends State<ViewProductChild> {
  Database db = Database();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 236, 163),
        appBar: buildAppbar(context, 'View Product', true),
        body: Container(
            padding: EdgeInsets.all(10),
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
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(171, 195, 47, 1),
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
                                fontSize: 20,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            )
                          ])),
                  const SizedBox(height: 10),
                  Container(
                      padding: EdgeInsets.all(10),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton('CHAT SELLER', widget.productDetails),
                      buildButton('ADD TO CART', widget.productDetails),
                      buildButton('BUY NOW', widget.productDetails)
                    ],
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
        Container(
            height: 24,
            child: VerticalDivider(
              color: Colors.black,
            )),
        const SizedBox(width: 15),
        TextButton(
            onPressed: () {},
            child: const Text(
              'View Reviews',
              style: const TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(171, 195, 47, 1),
              ),
            ))
      ],
    );
  }

  Widget buildButton(String text, Map prodDetails) {
    // add void onPressed as parameter later
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Color.fromARGB(255, 111, 174, 23)),
          // padding:MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ))),
      onPressed: () {
        if (text == 'CHAT SELLER') {
          ///
        } else if (text == 'ADD TO CART') {
          // db.addToCart()
        } else if (text == 'BUY NOW') {
          ///
        } else {
          ///
        }
      },
      child: Text(
        text,
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
            letterSpacing: 2.2,
            color: Colors.white),
      ),
    );
  }
}
