import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ProductParent extends StatelessWidget {
  const ProductParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body:ProductChild());
  }
}

class ProductChild extends StatefulWidget {
  const ProductChild({Key? key}) : super(key: key);

  @override
  State<ProductChild> createState() => _ProductChildState();
}

class _ProductChildState extends State<ProductChild> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [Text('Helloooo'), MaterialButton(onPressed:(){
            Get.back();
          })],
        )
      ),
    );
  }
}