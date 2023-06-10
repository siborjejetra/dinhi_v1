import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../widgets.dart';

class OrderParent extends StatelessWidget {
  final Map transaction;
  const OrderParent({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: OrderChild(transaction: transaction));
  }
}

class OrderChild extends StatefulWidget {
  final Map transaction;
  const OrderChild({Key? key, required this.transaction}) : super(key: key);

  @override
  State<OrderChild> createState() => _OrderChildState();
}

class _OrderChildState extends State<OrderChild> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
    // return Scaffold(
    //     backgroundColor: Color.fromARGB(255, 236, 236, 163),
    //     appBar: buildAppbar(context, 'Order Details', false),
    //     body: SafeArea(
    //       child: ,
    //     ));
  }
}
