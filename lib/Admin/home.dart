import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:Dinhi_v1/dashboard.dart';
import 'package:easy_dashboard/easy_dashboard.dart';


class HomeAdminParent extends StatelessWidget {
  const HomeAdminParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:HomeAdminChild());
  }
}

class HomeAdminChild extends StatefulWidget {
  const HomeAdminChild({Key? key}) : super(key: key);
  
  @override
  State<HomeAdminChild> createState() => _HomeAdminChildState();
}

class _HomeAdminChildState extends State<HomeAdminChild> {
  late final EasyAppController controller = EasyAppController(
  intialBody: EasyBody(child: tile1.body, title: tile1.title),
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
          delegate: CustomSearchDelegate()
          );
        },
      ),
      IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.white),
        onPressed: () {},
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
        border: BorderSide(width: 0.5, color: Color.fromARGB(255, 236, 236, 163)),
      ),
      desktopView: const DesktopView(
        fullAppBar: true,
        border: BorderSide(width: 0.5, color: Color.fromARGB(255, 236, 236, 163)),
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
          tiles: tiles,
          topWidget: SideBox(
            scrollable: true,
            height: 150,
            child: topOpenWidget,
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
