import 'dart:ui';

import 'package:Dinhi_v1/editprofile.dart';
import 'package:Dinhi_v1/model/user.dart';
import 'package:Dinhi_v1/utils/user_preference.dart';
import 'package:flutter/material.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class ProfileParent extends StatelessWidget {
  const ProfileParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 111, 174, 23),
      ),
      title: 'User Profile',
      home: ProfileChild(),
    );
  }
}

class ProfileChild extends StatefulWidget {
  const ProfileChild({Key? key}) : super(key: key);

  @override
  State<ProfileChild> createState() => _ProfileChildState();
}

class _ProfileChildState extends State<ProfileChild> {
  final title = 'Profile';

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      appBar: buildAppbar(context, title),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 30),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildEditButton()),
          const SizedBox(height: 24),
          buildAbout(user),
          
          
        ],
      )
    );
  }

  Widget buildName(User user) {
    return Column(
      children: [
        Text(
          user.name,
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 24,
            fontFamily: 'Montserrat'
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Montserrat'
          ),
        ),
        const SizedBox(height: 4),
        Text(
          user.birthday,
          style: TextStyle(
            color: Colors.grey,
            fontFamily: 'Montserrat'
          ),
        ),
      ],
    );
  }
  
  Widget buildEditButton() {
    return ElevatedButton(
    style:ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 111, 174, 23)),
        padding:MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
        )
      ),
      onPressed: (){Get.to(const SettingsUI());}, 
      child: Text(
        'EDIT PROFILE',
        style: TextStyle(
          fontSize: 14,
          fontFamily: 'Montserrat',
          letterSpacing: 2.2,
          color: Colors.white
        ),
      ),
    );
  }
  
  Widget buildAbout(User user) {
    return Container(
      // decoration: BoxDecoration(
      //   shape: BoxShape.rectangle,
      //   borderRadius: BorderRadius.circular(8),
      //   color: Colors.white
      // ),
      padding: EdgeInsets.symmetric(horizontal: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 24,
              fontFamily: 'Montserrat'
            ),
          ),
          const SizedBox(height: 10),
          Text(
            user.about,
            style: TextStyle(
              height: 1.4, 
              fontSize: 16,
              fontFamily: 'Montserrat'
            ),
          )
        ],
      ),
    );
  }

}