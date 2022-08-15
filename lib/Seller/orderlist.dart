import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class OrderListParent extends StatelessWidget {
  const OrderListParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body:OrderListChild());
  }
}

class OrderListChild extends StatefulWidget {
  const OrderListChild({Key? key}) : super(key: key);

  @override
  State<OrderListChild> createState() => _OrderListChildState();
}

class _OrderListChildState extends State<OrderListChild> {
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