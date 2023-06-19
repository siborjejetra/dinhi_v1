import 'package:Dinhi_v1/Buyer/trackorder.dart';
import 'package:Dinhi_v1/Buyer/completed.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:Dinhi_v1/utils/user_preference.dart';

class OrderListParent extends StatelessWidget {
  final List<String> orderlist;
  final Map userMap;
  const OrderListParent(
      {Key? key, required this.orderlist, required this.userMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OrderListChild(
          orderlist: orderlist,
          userMap: userMap,
        ));
  }
}

class OrderListChild extends StatefulWidget {
  final List<String> orderlist;
  final Map userMap;
  const OrderListChild(
      {Key? key, required this.orderlist, required this.userMap})
      : super(key: key);

  @override
  State<OrderListChild> createState() => _OrderListChildState();
}

class _OrderListChildState extends State<OrderListChild> {
  List<String>? orderList = [];
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
    orderList = widget.orderlist;
    storage = storeUserTrans(transactions, orderList);
    // print(storage);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      // appBar: buildAppbar(context, 'Order History', false),
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            buildNumbersWidget(storage),
            if (flag == 1)
              Expanded(child: buildListView(context, 'Pending', storage)),
            if (flag == 2)
              Expanded(child: buildListView(context, 'Ongoing', storage)),
            if (flag == 3)
              Expanded(child: buildListView(context, 'Completed', storage)),
            if (flag == 4)
              Expanded(child: buildListView(context, 'Cancelled', storage)),
          ],
        )),
      ),
    );
  }

  List<dynamic> storeUserTrans(List transactions, List<String>? orderList) {
    List storage = [];
    for (var i = 0; i < transactions.length; i++) {
      if (orderList != null) {
        for (var j = 0; j < orderList.length; j++) {
          if (transactions[i]['id'] == orderList[j]) {
            storage.add(transactions[i]);
          }
        }
      } else {
        return storage;
      }
    }
    return storage;
  }

  List<dynamic> filterOrders(String category, List orderlist) {
    List filter = [];
    if (orderlist != null) {
      for (var i = 0; i < orderlist.length; i++) {
        if (orderlist[i]['status'] == category) {
          filter.add(orderlist[i]);
        }
      }
    } else {
      return filter;
    }
    return filter;
  }

  Widget buildListTile(Map transaction) {
    print(transaction);
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
        Text('Items: ' + transaction['products'].length.toString(),
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
          if (transaction['status'] == 'Completed') {
            Get.to(CompletedParent(
                transaction: transaction, userMap: widget.userMap));
          } else {
            Get.to(TrackOrder(
              userMap: widget.userMap,
              transaction: transaction,
            ));
          }
        },
      ),
    );
  }

  Widget buildListView(BuildContext context, String category, List orderlist) {
    List filtered = filterOrders(category, orderlist);
    print(filtered);
    if (filtered.isNotEmpty) {
      return Container(
        child: ListView.builder(
            primary: true,
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: buildListTile(filtered[index])),
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
                'No ' + category + ' Orders',
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
      BuildContext context, String category, List orderlist) {
    List filtered = filterOrders(category, orderlist);
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
        } else if (category == 'Completed') {
          setState(() {
            flag = 3;
          });
        } else {
          setState(() {
            flag = 4;
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

  Widget buildNumbersWidget(List orderlist) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildNumbersButton(context, "Pending", orderlist),
          buildDivider(),
          buildNumbersButton(context, "Ongoing", orderlist),
          buildDivider(),
          buildNumbersButton(context, "Completed", orderlist),
          buildDivider(),
          buildNumbersButton(context, "Cancelled", orderlist),
        ],
      ),
    );
  }
}
