import 'dart:ui';

import 'package:typicons_flutter/typicons_flutter.dart';
import 'package:url_launcher/link.dart';
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
    String userID = '';
    User user = UserPreferences.myUser;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 30),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {
              Get.to(EditProfile());
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildEditButton()),
          const SizedBox(height: 24),
          buildNumbersWidget(),
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
          user.firstname+' '+user.lastname,
          style: TextStyle(
            fontWeight: FontWeight.bold, 
            fontSize: 24,
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
      onPressed: (){Get.to(const EditProfile());}, 
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
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50),
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
              // textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }

  Widget buildNumbersButton(BuildContext context, String value, String category){
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 4),
      highlightColor: Color.fromARGB(255, 111, 174, 23),
      onPressed: () {

      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold, 
              fontSize: 24,
              fontFamily: 'Montserrat'
            ),
          ),
          const SizedBox(height: 2),
          Text(
            category,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat'
            ),
          ),
        ]
      ),
    );
  }
  
  Widget buildDivider(){
    return Container(
      height: 24,
      child: VerticalDivider(color: Colors.black,)
    );
  }
  
  Widget buildNumbersWidget(){
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildNumbersButton(context, '4.5', "Ratings"),
          buildDivider(),
          buildNumbersButton(context, '6', "Feedbacks"),
          buildDivider(),
          buildNumbersButton(context, '3', "Transactions"),
        ],
      ),
    );
  }

  Widget buildContactButton(String website, String handle, Icon iconHandle){
    String url = website+handle;
    return Link(
      uri: Uri.parse(url),
      builder: (context, followLink) => OutlinedButton(
        onPressed: followLink,
        child: iconHandle,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 111, 174, 23)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
        )
        ),
      )
    );
  }

  Widget buildContact(User user) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Contact Me',
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: 18,
                fontFamily: 'Montserrat'
              ),
            ),
            const SizedBox(height: 5.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildContactButton('sms:', user.cellnumber,Icon(Typicons.phone, color: Colors.white)),
                buildContactButton('mailto:', user.email,Icon(Typicons.mail, color: Colors.white)),
                buildContactButton('https://www.linkedin.com/in/', 'jssibor',Icon(Typicons.social_linkedin, color: Colors.white)),
                buildContactButton('https://www.facebook.com/', 'siborjejetra',Icon(Typicons.social_facebook, color: Colors.white)),
                buildContactButton('https://github.com/', 'siborjejetra',Icon(Typicons.social_github, color: Colors.white)),
              ]
            )
          ],
        ),
      ),
    );
  }
}