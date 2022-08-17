import 'package:Dinhi_v1/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class SettingsUI extends StatelessWidget {
  const SettingsUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Setting UI',
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
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 163),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit Profile', 
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Montserrat',
          ),
        ),
        backgroundColor: Color.fromARGB(255, 111, 174, 23),
        leading: IconButton(
          onPressed: (){}, 
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          )
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {}, 
        //     icon: Icon(
        //       Icons.save_rounded,
        //       color: Colors.white,
        //     )
        //   )
        // ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GestureDetector(
          onTap: (){
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor
                        ),
                        boxShadow: [BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0,10)
                        )],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('https://cdn-icons-png.flaticon.com/512/949/949646.png')
                        )
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor
                          ),
                          color: Color.fromARGB(255, 111, 174, 23),
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              buildTextField("First Name", "Jetra Mae", false),
              buildTextField("Last Name", "Sibor", false),
              buildTextField("Email", "siborjejetra@gmail.com", false),
              buildTextField("Password", "********", true),
              buildTextField("Birthday", "12/10/1999", false),
              buildTextField("Contact Number", "09364575235", false),
              buildTextField("Address", "Calamba", false),
              const SizedBox(height: 20,),
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

  Padding buildTextField(String labelText, String placeHolder, bool isObscured) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextField(
        obscureText: isObscured ? showPassword: false,
        decoration: InputDecoration(
          suffixIcon: isObscured ? IconButton(
            onPressed:(){
              setState(() {
                showPassword = !showPassword;
              });
            }, 
            icon: Icon(
              Icons.remove_red_eye,
              color: Color.fromARGB(255, 111, 174, 23),
            )
          ) : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeHolder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )
        ),
      ),
    );
  }
}