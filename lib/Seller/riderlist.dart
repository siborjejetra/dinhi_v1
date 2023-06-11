import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../utils/user_preference.dart';
import '../widgets.dart';
import 'listitem.dart';

class RiderListParent extends StatelessWidget {
  final Map transaction;
  const RiderListParent({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RiderListChild(transaction: transaction));
  }
}

class RiderListChild extends StatefulWidget {
  final Map transaction;
  const RiderListChild({Key? key, required this.transaction}) : super(key: key);

  @override
  State<RiderListChild> createState() => _RiderListChildState();
}

class _RiderListChildState extends State<RiderListChild> {
  List users = [];
  List riders = [];

  @override
  void initState() {
    // TODO: implement initState
    db.readUsers().then((docs) {
      setState(() {
        users = docs;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    riders = storeUserDeets(users);
    print(riders);

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 236, 163),
        appBar: buildAppbar(context, 'Courier List', false),
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: Container(
                    child: riders.isNotEmpty
                        ? ListView.builder(
                            primary: false,
                            itemCount: riders.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.grey),
                                    ),
                                    child: CustomListItem(
                                        transaction: widget.transaction,
                                        user: riders[index])),
                              );
                            },
                          )
                        : Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 200),
                              child: Column(
                                children: const [
                                  Text(
                                    'No Available Rider',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        color: Colors.black,
                                        fontSize: 30),
                                  ),
                                  Text(
                                    'Please wait or reload page',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: "Montserrat",
                                        color: Colors.black54,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                          )))),
        bottomNavigationBar:
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Color.fromARGB(255, 111, 174, 23)),
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(horizontal: 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ))),
            onPressed: () {},
            child: const Text(
              'SELECT',
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  letterSpacing: 2.2,
                  color: Colors.white),
            ),
          ),
          OutlinedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(horizontal: 50)),
                  elevation: MaterialStateProperty.all(2),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ))),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'CANCEL',
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                    letterSpacing: 2.2,
                    color: Color.fromARGB(255, 111, 174, 23)),
              ))
        ]));
  }
}

List storeUserDeets(List users) {
  List storage = [];
  for (var i = 0; i < users.length; i++) {
    if (users[i]['usertype'] == 'Courier') {
      storage.add(users[i]);
    }
  }
  return storage;
}
