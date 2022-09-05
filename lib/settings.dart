import 'package:Dinhi_v1/editprofile.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:localstorage/localstorage.dart';

import 'model/user.dart';
import 'utils/user_preference.dart';

class SettingsUI extends StatelessWidget {
  const SettingsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edit Profile',
      home: SettingsPage(),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final title = 'Change Password';
  String userID = '';
  late User user;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Color.fromARGB(255, 111, 174, 23)),
                SizedBox(width: 8,),
                Text(
                  "Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                )
              ],
            ),
            Divider(height: 15, thickness: 2, color: Color.fromARGB(255, 111, 174, 23)),
            SizedBox(height: 10,),
            buildAccountOption(context, 'Change Password', EditProfile(user: user,)),
            buildAccountOption(context, 'Language', EditProfile(user: user,)),
            buildAccountOption(context, 'Privacy and Security', EditProfile(user: user,)),
            SizedBox(height: 40,),
            Row(
              children: [
                Icon(Icons.volume_up_outlined, color: Color.fromARGB(255, 111, 174, 23)),
                SizedBox(width: 8,),
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Montserrat'),
                )
              ],
            ),
            Divider(height: 15, thickness: 2, color: Color.fromARGB(255, 111, 174, 23)),
            SizedBox(height: 10,),
            buildNotificationOption('New for you', true),
            buildNotificationOption('Account activity', true),
            buildNotificationOption('Updates on transaction', false),
          ],
        )
      ),
    );
  }

  Row buildNotificationOption(String title, bool isActive) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat'
                ),
              ),
              Transform.scale(
                scale: 0.7,
                child: CupertinoSwitch(
                  value: isActive, 
                  onChanged: (bool val){
                    // setState(() {
                    //   isActive = !isActive;
                    // });
                  }
                ),
              ),
            ],
          );
  }

  GestureDetector buildAccountOption(BuildContext context, String title, var path) {
    return GestureDetector(
            onTap: (){
              Get.to(path);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Montserrat'
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios
                  )
                ]
              ),
            ),
          );
  }

  // Widget ChangePwordUI(User user){
  //   List<Widget> widgetList = [];
  //   return Scaffold(
  //     backgroundColor: Color.fromARGB(255, 236, 236, 163),
  //     appBar: buildAppbar(context, title, false),
  //     body: Container(
  //       child: ListView(
  //         physics: const BouncingScrollPhysics(),
  //         children: [
  //             const SizedBox(height: 10),
  //             TextFieldWidget(
  //               label: "Current Password", 
  //               isObscured: true,
  //               text: 'Enter Password', 
  //               onChanged: (password) {
  //                 if (password == user.password){
  //                   showDialog(
  //                     context: context,
  //                     builder: (BuildContext context) {
  //                       return const AlertDialog(
  //                         backgroundColor: Colors.white,
  //                         title: Text(
  //                           'Log-out', 
  //                           style: TextStyle(
  //                             fontFamily: "Montserrat",
  //                             fontWeight: FontWeight.bold,
  //                             color: Colors.black,
  //                             fontSize: 20
  //                           ),
  //                         ),
  //                         content: const Text(
  //                           'Your current password does not match with the input.',
  //                           style: TextStyle(
  //                             fontFamily: "Montserrat",
  //                             color: Colors.black,
  //                             fontSize: 14
  //                           )
  //                         ),
  //                       );
  //                     }
  //                   );
  //                 }
  //               }
  //             ),
  //             TextFieldWidget(
  //               label: "New Password", 
  //               isObscured: true,
  //               text: 'Enter Password', 
  //               onChanged: (password) {}
  //             ),
  //             TextFieldWidget(
  //               label: "Current Password", 
  //               isObscured: true,
  //               text: 'Confirm Password', 
  //               onChanged: (password) {}
  //             ),
  //         ]
  //       )
  //     )
  //   );
  // }
}