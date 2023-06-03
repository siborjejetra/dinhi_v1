import 'package:Dinhi_v1/utils/user_preference.dart';
import 'package:Dinhi_v1/Buyer/viewproduct.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ViewAllProdParent extends StatelessWidget {
  final List<String>? userProducts;
  final Map userDetails;
  const ViewAllProdParent(
      {Key? key, required this.userProducts, required this.userDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ViewAllProdChild(
            userProds: userProducts, userDetails: userDetails));
  }
}

class ViewAllProdChild extends StatefulWidget {
  const ViewAllProdChild(
      {Key? key, required this.userProds, required this.userDetails})
      : super(key: key);
  final List<String>? userProds;
  final Map userDetails;

  @override
  State<ViewAllProdChild> createState() => _ViewAllProdChildState();
}

class _ViewAllProdChildState extends State<ViewAllProdChild> {
  List products = [];

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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      body: SafeArea(
          child: Padding(
              padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: Container(
                  child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                primary: false,
                crossAxisCount: 2,
                children: <Widget>[
                  for (int i = 0; i < products.length; i++)
                    InkWell(
                        onTap: () {
                          Get.to(() => ViewProductParent(
                              productMap: products[i],
                              userDetails: widget.userDetails));
                        },
                        child: buildCard(
                            products[i]['image'],
                            products[i]['name'],
                            products[i]['price'],
                            products[i]['unit'])),
                ],
              )))),
    );
  }
}
