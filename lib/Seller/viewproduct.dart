import 'package:Dinhi_v1/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ViewProductParent extends StatelessWidget {
  final Map productMap;
  final Map userMap;
  const ViewProductParent(
      {Key? key, required this.productMap, required this.userMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'View Product',
      home: ViewProductChild(
        productDetails: productMap,
        userDetails: userMap,
      ),
    );
  }
}

class ViewProductChild extends StatefulWidget {
  final Map productDetails;
  final Map userDetails;
  const ViewProductChild(
      {Key? key, required this.productDetails, required this.userDetails})
      : super(key: key);

  @override
  State<ViewProductChild> createState() => _ViewProductChildState();
}

class _ViewProductChildState extends State<ViewProductChild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 236, 163),
        appBar: buildAppbar(context, 'View Product', false),
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
                      buildButton('EDIT PRODUCT'),
                      buildButton('DELETE PRODUCT')
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

  Widget buildButton(String text) {
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
      onPressed: () async {
        if (text == 'EDIT PRODUCT') {
          ///
          print("edit");
        } else if (text == 'DELETE PRODUCT') {
          removeProductFromSeller(
              widget.userDetails['id'], widget.productDetails['id']);
          // Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewProductParent(
                  userMap: widget.userDetails,
                  productMap: widget.productDetails),
            ),
          );
        } else {
          //
        }
      },
      child: Text(
        text,
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
            // letterSpacing: 2.2,
            color: Colors.white),
      ),
    );
  }
}

Future<void> removeProductFromSeller(String sellerId, String productId) async {
  final sellerRef =
      FirebaseFirestore.instance.collection("users").doc(sellerId);

  await FirebaseFirestore.instance.runTransaction((transaction) async {
    final sellerSnapshot = await transaction.get(sellerRef);

    if (sellerSnapshot.exists) {
      final List<dynamic> productsList = sellerSnapshot.data()!['products'];

      // Remove the productId from the productsList
      productsList.remove(productId);

      // Update the seller document with the modified productsList
      transaction.update(sellerRef, {'products': productsList});
    }
  });
}
