import 'package:Dinhi_v1/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get.dart';
import 'login.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  // runApp(const GetMaterialApp(home:LoginParent()));
  runApp(const GetMaterialApp(home:RegParent()));
}
