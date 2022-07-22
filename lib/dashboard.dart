import 'package:easy_dashboard/easy_dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:Dinhi_v1/search.dart';


var topOpenWidget = Container(
  margin: const EdgeInsets.symmetric(vertical: 10),
  decoration: const BoxDecoration(
    shape: BoxShape.circle,
    color: Color.fromARGB(255, 9, 117, 8),
  ),
  child: const Center(
    child: Text(
      'MF',
      style: TextStyle(
        fontSize: 40,
        color: Colors.white,
      ),
    ),
  ),
);

var bottomOpenWidget = Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: const [
      Text('DINHI'),
      Spacer(),
      Text('© 2022'),
      Spacer(),
    ],
  ),
);

var bottomSmallWidget = const Center(
  child: Text('© 2022'),
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
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
    ),
  ),
  icon: Icons.home,
  body: const Center(
    child: Icon(
      Icons.home,
      size: 280,
    ),
  ),
  name: 'Home',
);

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
    body: const Center(
      child: Icon(
        Icons.person,
        size: 280,
      ),
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
      'Account Settings',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    ),
    icon: IconData(0xe57f, fontFamily: 'MaterialIcons'),
    body: const Center(
      child: Icon(
        IconData(0xe57f, fontFamily: 'MaterialIcons'),
        size: 280,
      ),
    ),
    name: 'Account Settings',
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
    body: const Center(
      child: Icon(
        IconData(0xf88b, fontFamily: 'MaterialIcons'),
        size: 280,
      ),
    ),
    name: 'Logout',
  ),
];
