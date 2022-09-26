import 'package:Dinhi_v1/addproduct.dart';
import 'package:Dinhi_v1/utils/user_preference.dart';
import 'package:Dinhi_v1/viewproduct.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../model/user.dart';

class ViewAllProdParent extends StatelessWidget {
  final List<String>? userProducts;
  final Map userDetails;
  const ViewAllProdParent({Key? key, required this.userProducts, required this.userDetails}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ViewAllProdChild(userProds: userProducts, userDetails: userDetails)
      );
  }
}

class ViewAllProdChild extends StatefulWidget {
  const ViewAllProdChild({Key? key, required this.userProds, required this.userDetails}) : super(key: key);
  final List<String>? userProds;
  final Map userDetails;
  @override
  State<ViewAllProdChild> createState() => _ViewAllProdChildState();
}

class _ViewAllProdChildState extends State<ViewAllProdChild> {
  List<String>? productID = [];
  List products = [];
  List storage = [];

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
    Map userDetails = widget.userDetails;
    productID = widget.userProds;
    storage = storeUserProd(products, productID);
    // print(productID);
    print(products);
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
                    const Icon(
                      Icons.add,
                      color: Colors.white
                    ),
                    Column(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Get.to(ProductParent(userMap: userDetails));
                            },
                          child: const Text(
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
                  child: storage.isNotEmpty ? GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    primary: false,
                    crossAxisCount: 2,
                    children:<Widget>[
                      for (int i=0; i<storage.length; i++)
                      InkWell(
                        onTap: () {Get.to(() => ViewProductParent(productMap: storage[i]));},
                        child: buildCard(storage[i]['image'], storage[i]['name'], storage[i]['price'], storage[i]['unit'])
                      ),
                    ]
                  ) :
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 200),
                    child: Column(
                      children: const[
                        Text(
                          'No products to display',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.black,
                            fontSize: 30
                          ),
                        ),
                        Text(
                          'Please add products',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.black54,
                            fontSize: 25
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              )
            ]
          )
        ),
      )
    );
  }

  List<dynamic> storeUserProd(List products, List<String>? productID){
    List storage = [];
    for (var i=0; i<products.length; i++){
      if(productID != null){
        for(var j=0; j<productID.length; j++){
          if (products[i]['id'] == productID[j]){
            storage.add(products[i]);
          }
        }
      }else{
        return storage;
      }
    }
    return storage;
  }
}