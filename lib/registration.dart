import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class RegParent extends StatelessWidget {
  const RegParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body:RegChild());
  }
}

class RegChild extends StatefulWidget {
  const RegChild({Key? key}) : super(key: key);

  @override
  State<RegChild> createState() => _RegChildState();
}

class _RegChildState extends State<RegChild> {
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