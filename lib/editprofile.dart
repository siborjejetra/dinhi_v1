import 'package:Dinhi_v1/model/user.dart';
import 'package:Dinhi_v1/utils/user_preference.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edit Profile',
      home: EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final title = 'Edit Profile';
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      appBar: buildAppbar(context, title),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32),
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                isEdit: true, 
                onClicked: (){}),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: "First Name", 
                text: user.firstname, 
                onChanged: (firstname) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Last Name", 
                text: user.lastname, 
                onChanged: (lastname) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Email", 
                text: user.email, 
                onChanged: (email) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "About Me", 
                text: user.about, 
                maxLines: 5,
                onChanged: (about) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Birthday", 
                text: user.birthday, 
                onChanged: (birthday) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Contact Number", 
                text: user.cellnumber, 
                onChanged: (cellnumber) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Address", 
                text: user.address, 
                maxLines: 3,
                onChanged: (address) {}
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style:ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 111, 174, 23)),
                      padding:MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      )
                    ),
                    onPressed: () {

                    }, 
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        letterSpacing: 2.2,
                        color: Colors.white
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding:MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50)),
                      elevation: MaterialStateProperty.all(2), 
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )
                      )
                    ),
                    onPressed: (){
                      Get.back();
                    }, 
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Montserrat',
                        letterSpacing: 2.2,
                        color: Color.fromARGB(255, 111, 174, 23)
                      ),
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Padding buildTextField(String labelText, String placeHolder, bool isObscured) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal:5, vertical: 5),
  //     child: TextField(
  //       obscureText: isObscured ? showPassword: false,
  //       decoration: InputDecoration(
  //         border: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(12),
  //         ),
  //         suffixIcon: isObscured ? IconButton(
  //           onPressed:(){
  //             setState(() {
  //               showPassword = !showPassword;
  //             });
  //           }, 
  //           icon: Icon(
  //             Icons.remove_red_eye,
  //             color: Color.fromARGB(255, 111, 174, 23),
  //           )
  //         ) : null,
  //         contentPadding: EdgeInsets.only(bottom: 3),
  //         labelText: labelText,
  //         floatingLabelBehavior: FloatingLabelBehavior.always,
  //         hintText: placeHolder,
  //         hintStyle: TextStyle(
  //           fontSize: 16,
  //           fontFamily: 'Montserrat',
  //           fontWeight: FontWeight.bold,
  //           color: Colors.black,
  //         )
  //       ),
  //     ),
  //   );
  // }
}