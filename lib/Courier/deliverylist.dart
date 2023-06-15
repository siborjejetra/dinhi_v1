import 'package:Dinhi_v1/Courier/delivery.dart';
import 'package:Dinhi_v1/Seller/pending.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:Dinhi_v1/utils/user_preference.dart';

class DeliveryListParent extends StatelessWidget {
  final List<String>? deliverylist;
  const DeliveryListParent({Key? key, required this.deliverylist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DeliveryListChild(deliverylist: deliverylist));
  }
}

class DeliveryListChild extends StatefulWidget {
  final List<String>? deliverylist;
  const DeliveryListChild({Key? key, required this.deliverylist})
      : super(key: key);

  @override
  State<DeliveryListChild> createState() => _DeliveryListChildState();
}

class _DeliveryListChildState extends State<DeliveryListChild> {
  List<String>? deliverylist = [];
  List transactions = [];
  List storage = [];
  int flag = 1;

  @override
  void initState() {
    // TODO: implement initState
    db.readTransactions().then((docs) {
      setState(() {
        transactions = docs;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deliverylist = widget.deliverylist;
    storage = storeUserTrans(transactions, deliverylist);
    // print(storage);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      appBar: buildAppbar(context, 'Delivery List', false),
      body: SafeArea(
        child: Container(child: (buildListView(context, storage))),
      ),
    );
  }

  List<dynamic> storeUserTrans(List transactions, List<String>? deliverylist) {
    List storage = [];
    for (var i = 0; i < transactions.length; i++) {
      if (deliverylist != null) {
        for (var j = 0; j < deliverylist.length; j++) {
          if (transactions[i]['id'] == deliverylist[j]) {
            storage.add(transactions[i]);
          }
        }
      } else {
        return storage;
      }
    }
    return storage;
  }

  List<dynamic> filterOrders(String category, List deliverylist) {
    List filter = [];
    if (deliverylist != null) {
      for (var i = 0; i < deliverylist.length; i++) {
        if (deliverylist[i]['status'] == category) {
          filter.add(deliverylist[i]);
        }
      }
    } else {
      return filter;
    }
    return filter;
  }

  Widget buildListTile(Map transaction) {
    // print(transaction);
    return ListTile(
      onTap: () {},
      title: Text(
        'Order ID: ' + transaction['id'],
        style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
            color: Colors.black54,
            fontSize: 14),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Items: ' + transaction['itemList'].length.toString(),
            style: TextStyle(
                fontFamily: "Montserrat", color: Colors.black54, fontSize: 12)),
        Text('Date: ' + transaction['date'].toDate().toLocal().toString(),
            style: TextStyle(
                fontFamily: "Montserrat", color: Colors.black54, fontSize: 12)),
      ]),
      trailing: IconButton(
        icon: Icon(Icons.arrow_forward_ios,
            color: Color.fromARGB(255, 111, 174, 23)),
        onPressed: () {
          Get.to(DeliveryParent(transaction: transaction));
        },
      ),
    );
  }

  Widget buildListView(BuildContext context, List deliverylist) {
    if (deliverylist.isNotEmpty) {
      return Container(
        child: ListView.builder(
            primary: true,
            itemCount: deliverylist.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: buildListTile(deliverylist[index])),
              );
            }),
      );
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 200),
          child: Column(
            children: [
              Text(
                'No Orders to Deliver',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.black,
                    fontSize: 30),
              ),
            ],
          ),
        ),
      );
    }
  }

  Widget buildNumbersButton(
      BuildContext context, String category, List deliverylist) {
    List filtered = filterOrders(category, deliverylist);
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 4),
      highlightColor: Color.fromARGB(255, 111, 174, 23),
      onPressed: () {
        if (category == 'Pending') {
          setState(() {
            flag = 1;
          });
        } else if (category == 'Ongoing') {
          setState(() {
            flag = 2;
          });
        } else {
          setState(() {
            flag = 3;
          });
        }
      },
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              filtered.length.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: 'Montserrat'),
            ),
            const SizedBox(height: 2),
            Text(
              category,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
            ),
          ]),
    );
  }

  Widget buildDivider() {
    return Container(
        height: 24,
        child: VerticalDivider(
          color: Colors.black,
        ));
  }

  Widget buildNumbersWidget(List deliverylist) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildNumbersButton(context, "Pending", deliverylist),
          buildDivider(),
          buildNumbersButton(context, "Ongoing", deliverylist),
          buildDivider(),
          buildNumbersButton(context, "Completed", deliverylist),
        ],
      ),
    );
  }
}
