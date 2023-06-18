import 'package:Dinhi_v1/Buyer/home.dart';
import 'package:Dinhi_v1/Buyer/listitemcheckout.dart';
import 'package:Dinhi_v1/Buyer/placeorder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackOrder extends StatefulWidget {
  final Map userMap;
  final Map transaction;
  const TrackOrder({Key? key, required this.userMap, required this.transaction})
      : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  Map transactionData = {};
  String currentStatus = '';
  List productMap = [];
  Map user = {};
  Map<int, String> orderStatus = {
    1: 'Order Placed',
    2: 'Order Confirmed',
    3: 'Order Processed',
    4: 'Ready to Ship',
    5: 'Out for Delivery',
  };

  @override
  void initState() {
    super.initState();
    transactionData = widget.transaction;
    productMap = widget.transaction['products'];
    // currentStatus = widget.transaction['notes'];
    currentStatus = "Out for Delivery";
  }

  @override
  Widget build(BuildContext context) {
    user = widget.userMap;
    transactionData = widget.transaction;
    bool isOrderConfirmed = currentStatus == 'Order Confirmed';
    bool isReadytoShip =
        currentStatus == 'Ready to Ship' || currentStatus == 'Out for Delivery';
    bool isOutForDelivery = currentStatus == 'Out for Delivery';
    bool showOrderReceivedButton = isOutForDelivery;
    print(user);
    print(transactionData);
    print(isOutForDelivery);
    print(currentStatus);
    print(showOrderReceivedButton);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 111, 174, 23),
        centerTitle: true,
        title: const Text('Track Order'),
        leading: IconButton(
          onPressed: () {
            Get.to(HomeBuyerParent(userMap: widget.userMap));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 236, 236, 163),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 178, 218, 121),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: const Color.fromARGB(255, 236, 236, 163)),
                ),
                child: ListTile(
                  leading: const SizedBox(
                    width: 60,
                    height: 60,
                    child: Icon(
                      IconData(0xe3ab, fontFamily: 'MaterialIcons'),
                      color: Colors.black,
                    ), //BoxDecoration
                  ),
                  title: Text(
                    user['firstname'] +
                        ' ' +
                        user['lastname'] +
                        ' | ' +
                        user['cellnumber'],
                    style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 14),
                  ),
                  subtitle: Text(
                    user['address'],
                    style: const TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  primary: false,
                  itemCount: productMap.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: ListItemCheckout(
                          cart: productMap[index],
                          totalCart: '0',
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Expanded(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Theme(
                              data: Theme.of(context).copyWith(
                                dialogBackgroundColor: const Color.fromARGB(
                                    255,
                                    178,
                                    218,
                                    121), // Set the desired background color here
                              ),
                              child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Set the desired border radius here
                                ),
                                title: const Text(
                                  'Order Status',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Visby',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Container(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: orderStatus.length,
                                    itemBuilder: (context, index) {
                                      print(orderStatus.length);
                                      int stepNumber = index + 1;
                                      String status = orderStatus[stepNumber]!;
                                      print("status: " + status);
                                      bool isCurrentStatus =
                                          status == currentStatus;
                                      bool isBeforeCurrentStatus = stepNumber <
                                          orderStatus.keys.firstWhere(
                                            (key) =>
                                                orderStatus[key] ==
                                                currentStatus,
                                            orElse: () => 1,
                                          );
                                      String stepStatus = isBeforeCurrentStatus
                                          ? 'Done'
                                          : 'Pending';
                                      Color stepNumberColor = isCurrentStatus
                                          ? Colors.white
                                          : (isBeforeCurrentStatus
                                              ? const Color.fromARGB(
                                                  255, 111, 174, 23)
                                              : Colors.grey);
                                      Color stepStatusColor = isCurrentStatus
                                          ? Colors.white
                                          : (isBeforeCurrentStatus
                                              ? const Color.fromARGB(
                                                  255, 111, 174, 23)
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: isCurrentStatus
                                                          ? const Color
                                                                  .fromARGB(
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
                                                          ? const Color
                                                                  .fromARGB(
                                                              255, 111, 174, 23)
                                                          : Colors.grey),
                                                ),
                                              ),
                                              trailing: isOrderConfirmed
                                                  ? isCurrentStatus
                                                      ? IconButton(
                                                          // order confirmed lang
                                                          onPressed: () {},
                                                          icon: const Icon(Icons
                                                              .add_a_photo))
                                                      : null
                                                  : isReadytoShip
                                                      ? isCurrentStatus
                                                          ? Image.network(
                                                              transactionData[
                                                                  'seller_proof'],
                                                              width: 60,
                                                              height: 60,
                                                            )
                                                          : null // order processed
                                                      : isOutForDelivery
                                                          ? isCurrentStatus
                                                              ? Image.network(
                                                                  transactionData[
                                                                      'courier_proof'],
                                                                  width: 60,
                                                                  height: 60,
                                                                )
                                                              : null // out for delivery
                                                          : null),
                                          if (index < orderStatus.length - 1)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 27),
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
                                ),
                              ));
                        },
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 178, 218, 121),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color.fromARGB(255, 236, 236, 163),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            'Order Status',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Visby',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              if (showOrderReceivedButton)
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 178, 218, 121),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: Color.fromARGB(255, 236, 236, 163)),
                  ),
                  child: ListTile(
                    title: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Order Received',
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              letterSpacing: 2.2,
                              fontSize: 18)),
                      style: ButtonStyle(
                        side: MaterialStateProperty.all<BorderSide>(
                          const BorderSide(
                              color: const Color.fromARGB(255, 178, 218, 121),
                              width: 2.0),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
