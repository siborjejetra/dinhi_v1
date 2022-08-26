import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

AppBar buildAppbar(BuildContext context, String title){ 
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
      onPressed: (){
        Get.back();
      }, 
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      )
    ),
    // actions: [
    //   IconButton(
    //     onPressed: () {}, 
    //     icon: Icon(
    //       CupertinoIcons.moon_stars,
    //       color: Colors.white,
    //     )
    //   )
    // ],
  );
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final bool isEdit;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    this.isEdit = false,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Color.fromARGB(255, 111, 174, 23);

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 0,
            child: buildEditIcon(color)
          ),
        ],
      )
      

    );
  }
  
  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child:Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: onClicked,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color){
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 4,
          color: Color.fromARGB(255, 236, 236, 163),
        ),
        color: color
      ),
      child: Icon(
        isEdit? Icons.add_a_photo: Icons.edit,
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
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    this.maxLines = 1,
    this.isObscured = false,
    required this.label,
    required this.text,
    required this.onChanged,
    }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;

  @override
  void initState(){
    super.initState();
    controller = TextEditingController(text:widget.text);
  }

  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

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
          obscureText: widget.isObscured ? showPassword: false,
          controller: controller,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            suffixIcon: widget.isObscured ? IconButton(
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
            contentPadding: EdgeInsets.only(bottom: 3, left: 10),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintStyle: TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )
        ),
      ],
    );
  }
}