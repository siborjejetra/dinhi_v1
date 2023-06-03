import 'package:Dinhi_v1/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:localstorage/localstorage.dart';

AppBar buildAppbar(BuildContext context, String title, bool isViewProd) {
  return AppBar(
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontFamily: 'Montserrat',
      ),
    ),
    backgroundColor: Color.fromARGB(255, 111, 174, 23),
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        )),
    actions: [
      isViewProd
          ? IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shopping_basket,
                color: Colors.white,
              ))
          : IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.moon_stars,
                color: Colors.transparent,
              )),
    ],
  );
}

Widget buildCard(String imagePath, String name, String price, String unit) {
  var cardTextStyle =
      TextStyle(fontFamily: 'Montserrat', fontSize: 14, color: Colors.black);
  var priceTextStyle =
      TextStyle(fontFamily: 'Montserrat', fontSize: 12, color: Colors.black);

  return Card(
    color: Color.fromRGBO(111, 174, 23, 1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    elevation: 4,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Image.network(
        //   imagePath,
        //   width: 140,
        //   height: 140,
        // ),
        Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Column(
              children: [
                Text(name, style: cardTextStyle),
                Text('₱' + price + '/' + unit, style: priceTextStyle)
              ],
            ))
      ],
    ),
  );
}

Widget buildAlertDialog(ButtonStyle buttonStyle, LocalStorage localStorage) {
  return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text(
        'Log-out',
        style: TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20),
      ),
      content: const Text('Are you sure you want to log-out?',
          style: TextStyle(
              fontFamily: "Montserrat", color: Colors.black, fontSize: 14)),
      actions: <Widget>[
        ElevatedButton(
          style: buttonStyle,
          onPressed: () {
            localStorage.clear();
            Get.off(const LoginParent());
          },
          child: const Text('Yes',
              style: TextStyle(
                  fontFamily: "Montserrat", color: Colors.white, fontSize: 14)),
        ),
        ElevatedButton(
            style: buttonStyle,
            onPressed: () {
              Get.back();
            },
            child: const Text('No',
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontSize: 14))),
      ]);
}

class ProfileWidget extends StatelessWidget {
  final Image imagePath;
  final bool isEdit;
  final VoidCallback onClicked;
  final bool isEdited;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    this.isEdited = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Color.fromARGB(255, 111, 174, 23);

    return Center(
        child: Stack(
      children: [
        buildImage(),
        Positioned(bottom: 0, right: 0, child: buildEditIcon(color)),
      ],
    ));
  }

  Widget buildImage() {
    // final image = imagePath;

    return ClipOval(
      child: Material(
        color: Colors.white,
        child: InkWell(
          child: imagePath,
          onTap: onClicked,
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 4,
            color: Color.fromARGB(255, 236, 236, 163),
          ),
          color: color),
      child: Icon(
        isEdit ? Icons.add_a_photo : Icons.edit,
        color: Colors.white,
      ),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final int maxLines;
  final bool isObscured;
  final TextEditingController controller;
  // final bool isDropdown;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    this.isObscured = false,
    // this.isDropdown = false,
    required this.label,
    required this.text,
    required this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    bool showPassword = false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TextField(
            obscureText: widget.isObscured ? showPassword : false,
            controller: widget.controller,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: widget.isObscured
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Color.fromARGB(255, 111, 174, 23),
                      ))
                  : null,
              contentPadding: EdgeInsets.only(bottom: 3, left: 10),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: widget.text,
              hintStyle: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            )),
      ],
    );
  }
}
