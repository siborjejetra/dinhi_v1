import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      onPressed: (){}, 
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      )
    ),
    actions: [
      IconButton(
        onPressed: () {}, 
        icon: Icon(
          CupertinoIcons.moon_stars,
          color: Colors.white,
        )
      )
    ],
  );
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
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
        Icons.edit,
        color: Colors.white,
      ),
    );
  }

  
}