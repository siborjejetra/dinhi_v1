import 'package:Dinhi_v1/Admin/home.dart';
import 'package:Dinhi_v1/hello.dart';
import 'package:Dinhi_v1/login.dart';
import 'package:easy_dashboard/easy_dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var cardTextStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 14, color:Colors.white);

var buttonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 111, 174, 23)));

var topOpenWidget = Container(
  margin: const EdgeInsets.symmetric(vertical: 10),
  decoration: const BoxDecoration(
    shape: BoxShape.circle,
    color: Color.fromARGB(255, 9, 117, 8),
  ),
  child: const Center(
    child: Text(
      'JS',
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
          fontFamily: 'Montserrat'
        ),
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
                  borderRadius: BorderRadius.circular(8)
                ),
                height: 64,
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/949/949646.png'),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Jetra Mae Sibor',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: 20
                          ),
                        ),
                        Text(
                          'A000',
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: 14
                          ),
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
                      onTap: () {Get.to(const MyWidgetParent());},
                      child:
                      Card(
                        color: Color.fromARGB(255, 111, 174, 23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/Dashboard.png',
                              width: 140, 
                              height: 140,),
                            Text('View Dashboard', style: cardTextStyle)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {Get.to(const MyWidgetParent());},
                      child:
                      Card(
                        color: Color.fromARGB(255, 111, 174, 23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/ViewUsers.png',
                              width: 140, 
                              height: 140,),
                            Text('View Users', style: cardTextStyle)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      child: Card(
                        color: Color.fromARGB(255, 111, 174, 23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/ViewProducts.png',
                              width: 140, 
                              height: 140,),
                            Text('View Products', style: cardTextStyle)
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      child: Card(
                        color: Color.fromARGB(255, 111, 174, 23),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)
                        ),
                        elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/Orders.png',
                              width: 140, 
                              height: 140,),
                            Text('View Orders', style: cardTextStyle)
                          ],
                        ),
                      ),
                    ),
                  ],))
            ],
          ))),
      name: 'Home',
    );

List<SideTile> returnTiles(BuildContext context){
  late final List<SideTile> tiles = [
    tile1,
    SideBarTile(
      title: const Text(
        'Profile',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Montserrat'
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
        'Account Settings',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'Montserrat'
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
      body: Center(
        child: AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Log-out', 
            style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20
            ),
          ),
          content: const Text(
            'Are you sure you want to exit this application?',
            style: TextStyle(
              fontFamily: "Montserrat",
              color: Colors.black,
              fontSize: 14
            )
          ),
          actions: <Widget>[
            ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Get.off(const LoginParent());
              },
              child: const Text('Yes',
                style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.black,
                  fontSize: 14
                )
              ),
            ),
            new ElevatedButton(
              style: buttonStyle,
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeAdminParent()));
              },
              child: const Text('No',
                style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.black,
                  fontSize: 14
                )
              )
            ),
          ]),
      ),
      name: 'Logout',
    ),
  ];
  return tiles;
}

