import 'package:Dinhi_v1/Courier/deliverylist.dart';
import 'package:Dinhi_v1/Courier/home.dart';
import 'package:Dinhi_v1/Courier/profile.dart';
import 'package:Dinhi_v1/model/user.dart';
import 'package:Dinhi_v1/settings.dart';
import 'package:Dinhi_v1/addproduct.dart';
import 'package:Dinhi_v1/login.dart';
import 'package:easy_dashboard/easy_dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

import '../widgets.dart';

LocalStorage localStorage = new LocalStorage('user');

var cardTextStyle = const TextStyle(
    fontFamily: 'Montserrat', fontSize: 12, color: Colors.white);

var buttonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 9, 117, 8)));

Widget topOpenWidget(User user) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromARGB(255, 9, 117, 8),
    ),
    child: Center(
      child: Text(
        user.firstname[0] + user.lastname[0],
        style: TextStyle(
          fontSize: 40,
          color: Colors.white,
        ),
      ),
    ),
  );
}

var bottomOpenWidget = Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: const [
      Text('DINHI'),
      Spacer(),
      Text('© 2023'),
      Spacer(),
    ],
  ),
);

var bottomSmallWidget = const Center(
  child: Text('© 2023'),
);

var topSmallWidget = Container(
  decoration: const BoxDecoration(
    color: Color.fromARGB(255, 111, 174, 23),
    shape: BoxShape.circle,
  ),
  child: IconButton(
    onPressed: () {},
    icon: const Icon(
      Icons.person,
      color: Colors.white,
    ),
  ),
);

SideBarTile buildSideBarTile(User user, Map userDetails) {
  return SideBarTile(
    title: const Text(
      'Home',
      style: TextStyle(
          color: Colors.white, fontSize: 20, fontFamily: 'Montserrat'),
    ),
    icon: Icons.home,
    body: SafeArea(
        child: Padding(
            padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 111, 174, 23),
                      borderRadius: BorderRadius.circular(8)),
                  height: 64,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 8),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(user.imagePath),
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            user.firstname + ' ' + user.lastname,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.white,
                                fontSize: 20),
                          ),
                          Text(
                            user.idno,
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                color: Colors.white,
                                fontSize: 14),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: GridView.count(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  primary: false,
                  crossAxisCount: 2,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Get.to(DeliveryListParent(
                            deliverylist: user.deliverylist));
                      },
                      child: Card(
                        color: Color.fromARGB(255, 111, 174, 23),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/OrdersAvail.png',
                              width: 140,
                              height: 140,
                            ),
                            Text('View Orders for Delivery',
                                style: cardTextStyle)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Card(
                        color: Color.fromARGB(255, 111, 174, 23),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/DeliveryHistory.png',
                              width: 140,
                              height: 140,
                            ),
                            Text('View Delivery History', style: cardTextStyle)
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
              ],
            ))),
    name: 'Home',
  );
}

List<SideTile> returnTiles(BuildContext context, User user, Map userDetails) {
  late final List<SideTile> tiles = [
    buildSideBarTile(user, userDetails),
    SideBarTile(
      title: const Text(
        'Profile',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      icon: Icons.person,
      body: ProfileParent(user: user),
      name: 'Profile',
    ),
    SideBarTile(
      title: const Text(
        'Settings',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      icon: Icons.settings,
      body: const SettingsUI(),
      name: 'Settings',
    ),
    SideBarTile(
      title: const Text(
        'Logout',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      icon: IconData(0xf88b, fontFamily: 'MaterialIcons'),
      body: Center(child: buildAlertDialog(buttonStyle, localStorage)),
      name: 'Logout',
    ),
  ];

  return tiles;
}
