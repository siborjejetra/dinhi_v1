import 'package:Dinhi_v1/Buyer/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets.dart';

class TrackOrder extends StatefulWidget {
  final Map userMap;
  const TrackOrder({Key? key, required this.userMap}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  Map<int, String> orderStatus = {
    1: 'Order Placed',
    2: 'Order Confirmed',
    3: 'Order Processed',
    4: 'Ready to Ship',
    5: 'Out for Delivery',
  };
  String currentStatus = 'Order Confirmed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 111, 174, 23),
        centerTitle: true,
        title: Text('Track Order'),
        leading: IconButton(
            onPressed: () {
              Get.to(HomeBuyerParent(userMap: widget.userMap));
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Container(
        color: Color.fromARGB(255, 236, 236, 163),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Flexible(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(
                      255,
                      178,
                      218,
                      121,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SafeArea(
                    child: ExpansionTile(
                      leading: const Icon(Icons.list_sharp,
                          color: Color.fromARGB(255, 111, 174, 23), size: 25.0),
                      title: Text(
                        "Order Status",
                        style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Visby',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                      ),
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: orderStatus.length,
                          itemBuilder: (context, index) {
                            int stepNumber = index + 1;
                            String status = orderStatus[stepNumber]!;
                            bool isCurrentStatus = status == currentStatus;
                            bool isBeforeCurrentStatus = stepNumber <
                                orderStatus.keys.firstWhere(
                                  (key) => orderStatus[key] == currentStatus,
                                  orElse: () => 1,
                                );
                            String stepStatus =
                                isBeforeCurrentStatus ? 'Done' : 'Pending';
                            Color stepNumberColor = isCurrentStatus
                                ? Colors.white
                                : (isBeforeCurrentStatus
                                    ? Color.fromARGB(255, 111, 174, 23)
                                    : Colors.grey);
                            Color stepStatusColor = isCurrentStatus
                                ? Colors.white
                                : (isBeforeCurrentStatus
                                    ? Color.fromARGB(255, 111, 174, 23)
                                    : Colors.grey);

                            return Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: stepNumberColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        stepNumber.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: isCurrentStatus
                                              ? Color.fromARGB(
                                                  255, 111, 174, 23)
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    status,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: stepStatusColor,
                                    ),
                                  ),
                                  subtitle: Text(
                                    isCurrentStatus
                                        ? 'Current Status'
                                        : stepStatus,
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: isCurrentStatus
                                          ? Colors.white
                                          : (isBeforeCurrentStatus
                                              ? Color.fromARGB(
                                                  255, 111, 174, 23)
                                              : Colors.grey),
                                    ),
                                  ),
                                ),
                                if (index < orderStatus.length - 1)
                                  Padding(
                                    padding: EdgeInsets.only(left: 27),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: FractionallySizedBox(
                                        widthFactor: 0.005,
                                        child: Container(
                                          height: 20,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
