import 'package:flutter/material.dart';

import '../widgets.dart';

class TrackOrder extends StatefulWidget {
  final Map transaction;
  const TrackOrder({Key? key, required this.transaction}) : super(key: key);
  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context, 'Track Order', false),
      body: SafeArea(
        child: Column(
          children: <Widget>[],
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 111, 174, 23)),
            padding:
                MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ))),
        onPressed: () {},
        child: const Text(
          'ORDER RECEIVED',
          style: TextStyle(
              fontSize: 14,
              fontFamily: 'Montserrat',
              letterSpacing: 2.2,
              color: Colors.white),
        ),
      ),
    );
  }
}
