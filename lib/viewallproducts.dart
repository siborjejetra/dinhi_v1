import 'package:Dinhi_v1/addproduct.dart';
import 'package:Dinhi_v1/utils/user_preference.dart';
import 'package:Dinhi_v1/viewproduct.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ViewAllProdParent extends StatelessWidget {
  const ViewAllProdParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ViewAllProdChild()
      );
  }
}

class ViewAllProdChild extends StatefulWidget {
  const ViewAllProdChild({Key? key}) : super(key: key);

  @override
  State<ViewAllProdChild> createState() => _ViewAllProdChildState();
}

class _ViewAllProdChildState extends State<ViewAllProdChild> {
  List products = [];

  @override
  void initState() {
    // TODO: implement initState
    db.readProducts().then((docs)
    {
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
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 9, 117, 8),
                  borderRadius: BorderRadius.circular(8)
                ),
                height: 50,
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add,
                      color: Colors.white
                    ),
                    Column(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Get.to(const ProductParent());
                            },
                          child: Text(
                            'ADD PRODUCT',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              letterSpacing: 2.2,
                              color: Colors.white,
                              fontSize: 20
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container( 
                child: GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 2,
                  children: <Widget>[
                    for (int i=0; i<products.length; i++)
                    InkWell(
                      onTap: () {Get.to(() => ViewProductParent(productMap: products[i]));},
                      child: buildCard(products[i]['image'], products[i]['name'], products[i]['price'], products[i]['unit'])
                    ),
                  ],)
                ),
              )
            ]
          )
        ),
      )
    );
  }
}