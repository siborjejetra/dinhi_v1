import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeSellerParent extends StatelessWidget {
  const HomeSellerParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:HomeSellerChild());
  }
}

class HomeSellerChild extends StatefulWidget {
  const HomeSellerChild({Key? key}) : super(key: key);

  @override
  State<HomeSellerChild> createState() => _HomeSellerChildState();
}

class _HomeSellerChildState extends State<HomeSellerChild> {
  @override
  Widget build(BuildContext context) {
    
  }
}