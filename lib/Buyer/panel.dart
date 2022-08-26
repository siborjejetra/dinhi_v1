import 'package:Dinhi_v1/Buyer/profile.dart';
import 'package:Dinhi_v1/Buyer/home.dart';
import 'package:Dinhi_v1/settings.dart';
import 'package:Dinhi_v1/login.dart';
import 'package:easy_dashboard/easy_dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

var cardTextStyle = TextStyle(fontFamily: 'Montserrat', fontSize: 14, color:Colors.black);

var buttonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 111, 174, 23)));

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
          fontFamily: 'Montserrat'
        ),
      ),
      icon: Icons.home,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Container( 
              child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                primary: false,
                crossAxisCount: 2,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Card(
                      color: Color.fromRGBO(111, 174, 23, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/Rambutan.png',
                            width: 140, 
                            height: 140,),
                          Text('Rambutan', style: cardTextStyle)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      color: Color.fromARGB(255, 9, 117, 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/Pomelo.png',
                            width: 140, 
                            height: 140,),
                          Text('Suha', style: cardTextStyle)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      color: Color.fromARGB(255, 9, 117, 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/Niyog.png',
                            width: 140, 
                            height: 140,),
                          Text('Niyog', style: cardTextStyle)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      color: Color.fromRGBO(111, 174, 23, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/Buko.png',
                            width: 140, 
                            height: 140,),
                          Text('Buko', style: cardTextStyle)
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    child: Card(
                      color: Color.fromRGBO(111, 174, 23, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)
                      ),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/Corn.png',
                            width: 140, 
                            height: 140,),
                          Text('Mais', style: cardTextStyle)
                        ],
                      ),
                    ),
                  ),
                ],)
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
        ),
      ),
      icon: Icons.person,
      body: const ProfileParent(),
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
            'Are you sure you want to log-out?',
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeBuyerParent()));
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
    )
  ];
  return tiles;
}
