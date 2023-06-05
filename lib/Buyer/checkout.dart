import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CheckoutParent extends StatelessWidget {
  final Map<dynamic, dynamic> userMap;
  const CheckoutParent({
    Key? key,
    required this.userMap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CheckoutChild(userDetails: userMap));
  }
}

class CheckoutChild extends StatefulWidget {
  final Map<dynamic, dynamic> userDetails;
  const CheckoutChild({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  State<CheckoutChild> createState() => _CheckoutChildState();
}

class _CheckoutChildState extends State<CheckoutChild> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
