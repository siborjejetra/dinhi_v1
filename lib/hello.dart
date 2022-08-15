import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MyWidgetParent extends StatelessWidget {
  const MyWidgetParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body:MyWidgetChild());
  }
}

class MyWidgetChild extends StatefulWidget {
  const MyWidgetChild({Key? key}) : super(key: key);

  @override
  State<MyWidgetChild> createState() => _MyWidgetChildState();
}

class _MyWidgetChildState extends State<MyWidgetChild> {
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