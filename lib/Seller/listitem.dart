import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomListItem extends StatefulWidget {
  final Map transaction;
  final Map user;
  const CustomListItem({
    Key? key,
    required this.transaction,
    required this.user,
  }) : super(key: key);

  @override
  _CustomListItemState createState() => _CustomListItemState();
}

class _CustomListItemState extends State<CustomListItem> {
  @override
  Widget build(BuildContext context) {
    Map user = widget.user;
    Map transaction = widget.transaction;
    Map _selected = {};

    return RadioListTile(
      value: user,
      groupValue: _selected,
      onChanged: (value) {
        setState(() {
          _selected = value as Map;
        });
      },
      activeColor: Color.fromARGB(255, 111, 174, 23),
      title: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(user['image']),
                fit: BoxFit.scaleDown,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Column(
            children: [
              Text(
                  user['firstname'] +
                      ' ' +
                      user['lastname'] +
                      ' | ' +
                      user['cellnumber'],
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 111, 174, 23),
                      fontSize: 14)),
              Text('Plate Number: ' + user['plate_no'],
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Color.fromARGB(255, 111, 174, 23))),
            ],
          ),
        ],
      ),
    );
  }
}
