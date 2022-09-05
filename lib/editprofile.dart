import 'dart:io';

import 'package:Dinhi_v1/Admin/home.dart';
import 'package:Dinhi_v1/Admin/profile.dart';
import 'package:Dinhi_v1/Buyer/home.dart';
import 'package:Dinhi_v1/Courier/home.dart';
import 'package:Dinhi_v1/Seller/home.dart';
import 'package:Dinhi_v1/model/user.dart';
import 'package:Dinhi_v1/utils/user_preference.dart';
import 'package:Dinhi_v1/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localstorage/localstorage.dart';
import 'package:intl/intl.dart';


LocalStorage localStorage =  LocalStorage('user');

class EditProfile extends StatelessWidget {
  final User user;
  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Edit Profile',
      home: EditProfilePage(newUser: user,),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.newUser}) : super(key: key);
  final User newUser;
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final title = 'Edit Profile';
  late final User user = widget.newUser;
  Map<dynamic,dynamic> editedUserMap = {};

  TextEditingController imageController = new TextEditingController(); 
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController birthdayController = new TextEditingController(); 
  TextEditingController aboutController = new TextEditingController();
  TextEditingController cellnumberController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();

  File? inputImage;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    // user details
    DateFormat f = DateFormat('yyyy-MM-dd');
    
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      appBar: buildAppbar(context, title, false),
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
              imagePath: inputImage != null ? Image.file(inputImage!, width: 128,
                        height:128) :Image.network(user.imagePath, width: 128,
                        height:128,),
              isEdit: true, 
              onClicked: (){
                pickImage(ImageSource.gallery);
              }),
              const SizedBox(height: 24),
              TextFieldWidget(
                label: "First Name", 
                text: user.firstname,
                controller: firstnameController,
                onChanged: (firstname) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Last Name", 
                text: user.lastname, 
                controller: lastnameController,
                onChanged: (lastname) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Email", 
                text: user.email, 
                controller: emailController,
                onChanged: (email) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "About Me", 
                text: user.about, 
                controller: aboutController,
                maxLines: 5,
                onChanged: (about) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Birthday", 
                text: f.format(user.birthday.toDate()).toString(), 
                controller: birthdayController,
                onChanged: (birthday) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Contact Number", 
                text: user.cellnumber, 
                controller: cellnumberController,
                onChanged: (cellnumber) {}
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                label: "Address", 
                text: user.address, 
                controller: addressController,
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
                      Map<String,dynamic> newUserMap = {
                        'firstname': firstnameController.text.isEmpty ? user.firstname: firstnameController.text,
                        'lastname': lastnameController.text.isEmpty ? user.lastname: lastnameController.text,
                        'email': emailController.text.isEmpty ? user.email: emailController.text,
                        'about': aboutController.text.isEmpty ? user.about: aboutController.text,
                        'birthday': birthdayController.text.isEmpty ? user.birthday: Timestamp.fromDate(DateTime.parse(birthdayController.text)),
                        'cellnumber': cellnumberController.text.isEmpty ? user.cellnumber: cellnumberController.text,
                        'address': addressController.text.isEmpty ? user.address: addressController.text
                      };
                      db.editUser(newUserMap, inputImage).then(
                        (editMap) {editedUserMap = editMap;}
                      );
                      
                      if ((editedUserMap['idno'])[0] == 'A'){
                        Get.to(HomeAdminParent(userMap: editedUserMap));
                      }else if ((editedUserMap['idno'])[0] == 'B'){
                        Get.to(HomeBuyerParent(userMap: editedUserMap));
                      }else if ((editedUserMap['idno'])[0] == 'C'){
                        Get.to(HomeCourierParent(userMap: editedUserMap));
                      }else{
                        Get.to(HomeSellerParent(userMap: editedUserMap));
                      }
                    }, 
                    child: const Text(
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
                    child: const Text(
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

  Future pickImage(ImageSource source) async {
    try {
      XFile? pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          inputImage = File(pickedImage.path);
        });
      } else
        return;
    } on PlatformException catch (e) {
      // showFailedToChooseDialog(context);
    } catch (e) {
      // showFailedToChooseDialog(context);
    }
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