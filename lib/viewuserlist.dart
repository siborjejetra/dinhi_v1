import 'package:Dinhi_v1/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ViewUserListParent extends StatelessWidget {
  const ViewUserListParent({Key? key, required this.userMap}) : super(key: key);
  final User userMap;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:ViewUserListChild(userDetails: userMap));
  }
}

class ViewUserListChild extends StatefulWidget {
  const ViewUserListChild({Key? key, required this.userDetails}) : super(key: key);
  final User userDetails;
  @override
  State<ViewUserListChild> createState() => _ViewUserListChildState();
}

class _ViewUserListChildState extends State<ViewUserListChild> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  
}