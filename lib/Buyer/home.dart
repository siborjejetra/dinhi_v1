import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeBuyerParent extends StatelessWidget {
  const HomeBuyerParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:HomeBuyerChild());
  }
}

class HomeBuyerChild extends StatefulWidget {
  const HomeBuyerChild({Key? key}) : super(key: key);

  @override
  State<HomeBuyerChild> createState() => _HomeBuyerChildState();
}

class _HomeBuyerChildState extends State<HomeBuyerChild> {
  @override
  Widget build(BuildContext context) {
    
  }
}