import 'package:Dinhi_v1/Buyer/profile.dart';
import 'package:Dinhi_v1/Buyer/home.dart';
import 'package:Dinhi_v1/model/user.dart';
import 'package:Dinhi_v1/settings.dart';
import 'package:Dinhi_v1/login.dart';
import 'package:Dinhi_v1/Buyer/viewallproducts.dart';
import 'package:Dinhi_v1/viewproduct.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:easy_dashboard/easy_dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localstorage/localstorage.dart';

LocalStorage localStorage = new LocalStorage('user');

var buttonStyle = ButtonStyle(
    backgroundColor:
        MaterialStateProperty.all(Color.fromARGB(255, 111, 174, 23)));

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

final SideBarTile tile1 = SideBarTile(
  title: const Text(
    'Home',
    style:
        TextStyle(color: Colors.white, fontSize: 20, fontFamily: 'Montserrat'),
  ),
  icon: Icons.home,
  body: ViewAllProdParent(),
  name: 'Home',
);

List<SideTile> returnTiles(BuildContext context, User user) {
  late final List<SideTile> tiles = [
    tile1,
    SideBarTile(
      title: const Text(
        'Profile',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      icon: Icons.person,
      body: ProfileParent(
        user: user,
      ),
      name: 'Profile',
    ),
    SideBarTile(
      title: const Text(
        'Order History',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      icon: Icons.chrome_reader_mode_outlined,
      body: const Center(
        child: Icon(
          Icons.chrome_reader_mode_outlined,
          size: 280,
        ),
      ),
      name: 'Order History',
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
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      icon: IconData(0xf88b, fontFamily: 'MaterialIcons'),
      body: Center(child: buildAlertDialog(buttonStyle, localStorage)),
      name: 'Logout',
    )
  ];
  return tiles;
}
