import 'dart:core';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  Profile({
    required this.imageUrl,
    required this.name,
    required this.website,
    required this.designation,
    required this.email,
    required this.phone_number,
  });
  final String imageUrl;
  final String name;
  final String website;
  final String designation;
  final String email;
  final String phone_number;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final Uri imagelUrl = Uri.parse(widget.imageUrl);
    final Uri nameUrl = Uri.parse(widget.name);
    final Uri webUrl = Uri.parse("http://" + widget.website);
    final Uri designationUrl = Uri.parse(widget.designation);
    final Uri emailUrl = Uri.parse("mailto:" + widget.email);
    final Uri phoneUrl = Uri.parse("tel:" + widget.phone_number);
    final Uri smsUrl = Uri.parse("sms:" + widget.phone_number);
    void getUrlLauncher(Uri url) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: AvatarGlow(
              glowColor: Color.fromARGB(255, 15, 233, 106),
              endRadius: 90.0,
              duration: Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              child: DottedBorder(
                radius: Radius.circular(10),
                color: Colors.blue,
                strokeWidth: 8,
                borderType: BorderType.Circle,
                dashPattern: [1, 12],
                strokeCap: StrokeCap.butt,
                child: Center(
                  child: SizedBox(
                    width: 130,
                    height: 130,
                    child: CircleAvatar(
                      foregroundImage: NetworkImage(widget.imageUrl),
                      radius: 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(widget.designation),
          TextButton(
              onPressed: () async {
                getUrlLauncher(emailUrl);
              },
              child: Text(widget.email)),
          TextButton(
              onPressed: () async {
                getUrlLauncher(phoneUrl);
              },
              child: Text(widget.phone_number)),
        ],
      ),
    );
  }
}
