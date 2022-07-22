import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeDeliveryParent extends StatelessWidget {
  const HomeDeliveryParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:HomeDeliveryChild());
  }
}

class HomeDeliveryChild extends StatefulWidget {
  const HomeDeliveryChild({Key? key}) : super(key: key);

  @override
  State<HomeDeliveryChild> createState() => _HomeDeliveryChildState();
}

class _HomeDeliveryChildState extends State<HomeDeliveryChild> {
  @override
  Widget build(BuildContext context) {
    
  }
}
