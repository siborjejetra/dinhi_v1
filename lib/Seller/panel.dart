import 'package:Dinhi_v1/Seller/home.dart';
import 'package:Dinhi_v1/addproduct.dart';
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
      'AR',
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
                  color: Color.fromARGB(255, 9, 117, 8),
                  borderRadius: BorderRadius.circular(8)
                ),
                height: 50,
                margin: EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // SizedBox(
                    //   width: 80,
                    // ),
                    Icon(
                      Icons.add,
                      color: Colors.white
                    ),
                    Column(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {Get.to(const ProductParent());},
                          child: Text(
                            'ADD PRODUCT',
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              color: Colors.white,
                              fontSize: 20
                            ),
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
                      onTap: () {Get.to(const ProductParent());},
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
        'Order List',
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
      name: 'Order List',
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeSellerParent()));
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