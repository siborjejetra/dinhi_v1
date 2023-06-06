import 'dart:ui';
import 'package:Dinhi_v1/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:Dinhi_v1/Buyer/panel.dart';
import 'package:easy_dashboard/easy_dashboard.dart';
import 'package:get/get.dart';

import 'cart.dart';

class HomeBuyerParent extends StatelessWidget {
  const HomeBuyerParent({Key? key, required this.userMap}) : super(key: key);
  final Map<dynamic, dynamic> userMap;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeBuyerChild(
          userDetails: userMap,
        ));
  }
}

class HomeBuyerChild extends StatefulWidget {
  const HomeBuyerChild({Key? key, required this.userDetails}) : super(key: key);
  final Map<dynamic, dynamic> userDetails;

  @override
  State<HomeBuyerChild> createState() => _HomeBuyerChildState();
}

class _HomeBuyerChildState extends State<HomeBuyerChild> {
  late final User user = User(
    imagePath: (widget.userDetails['image'] as String).isEmpty
        ? 'https://cdn3.iconfinder.com/data/icons/flatastic-4-1/256/user_orange-512.png'
        : widget.userDetails['image'],
    firstname: widget.userDetails['firstname'],
    lastname: widget.userDetails['lastname'],
    email: widget.userDetails['email'],
    password: widget.userDetails['password'],
    cellnumber: widget.userDetails['cellnumber'],
    honorific: widget.userDetails['honorific'],
    about: (widget.userDetails['about'] as String).isEmpty
        ? 'Set about'
        : widget.userDetails['about'],
    birthday: widget.userDetails['birthday'],
    address: widget.userDetails['address'],
    idno: widget.userDetails['idno'],
    cart: widget.userDetails['cart'],
    orderlist: widget.userDetails['orderlist'],
  );
  late final EasyAppController controller = EasyAppController(
    intialBody: EasyBody(
        child: buildtile1(user, widget.userDetails).body,
        title: buildtile1(user, widget.userDetails).title),
  );

  @override
  Widget build(BuildContext context) {
    final List<Widget> actions = [
      IconButton(
        icon: const Icon(Icons.search, color: Colors.white),
        onPressed: () {
          showSearch(
              context: context,
              // delegate to customize the search bar
              delegate: CustomSearchDelegate());
        },
      ),
      IconButton(
        icon: const Icon(Icons.shopping_basket, color: Colors.white),
        onPressed: () {
          Get.to(CartParent(userMap: widget.userDetails));
        },
      ),
    ];
    return EasyDashboard(
      controller: controller,
      navigationIcon: const Icon(Icons.menu, color: Colors.white),
      appBarActions: actions,
      centerTitle: true,
      appBarColor: Color.fromARGB(255, 111, 174, 23),
      sideBarColor: Color.fromARGB(255, 236, 236, 163),
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      tabletView: const TabletView(
        fullAppBar: false,
        border:
            BorderSide(width: 0.5, color: Color.fromARGB(255, 236, 236, 163)),
      ),
      desktopView: const DesktopView(
        fullAppBar: true,
        border:
            BorderSide(width: 0.5, color: Color.fromARGB(255, 236, 236, 163)),
      ),
      drawer: (Size size, Widget? child) {
        return EasyDrawer(
          iconColor: Color.fromARGB(255, 111, 174, 23),
          hoverColor: Color.fromARGB(255, 236, 236, 163),
          tileColor: Color.fromARGB(255, 236, 236, 163),
          selectedColor: Colors.black.withGreen(80),
          selectedIconColor: Color.fromARGB(255, 236, 236, 163),
          textColor: Colors.black.withGreen(20),
          selectedTileColor: Color.fromARGB(255, 111, 174, 23).withOpacity(.8),
          tiles: returnTiles(context, user, widget.userDetails),
          topWidget: SideBox(
            scrollable: true,
            height: 150,
            child: topOpenWidget(user),
          ),
          bottomWidget: SideBox(
            scrollable: false,
            height: 50,
            child: bottomOpenWidget,
          ),
          bottomSmallWidget: SideBox(
            height: 50,
            child: bottomSmallWidget,
          ),
          topSmallWidget: SideBox(
            height: 50,
            child: topSmallWidget,
          ),
          size: size,
          onTileTapped: (body) {
            controller.switchBody(body);
          },
        );
      },
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying (try lang)
  // manggagaling sa database
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
