import 'package:Dinhi_v1/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:Dinhi_v1/Admin/home.dart';
import 'package:Dinhi_v1/Buyer/home.dart';
import 'package:Dinhi_v1/Courier/home.dart';
import 'package:Dinhi_v1/Seller/home.dart';
import 'database.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
  'mariapranseska@gmail.com': 'ayeyeye',
  'siborjejetra@gmail.com': 'hellojet'
};

class LoginParent extends StatelessWidget {
  const LoginParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home:LoginChild());
  }
}

class LoginChild extends StatefulWidget {
  const LoginChild({Key? key}) : super(key: key);

  @override
  State<LoginChild> createState() => _LoginChildState();
}

class _LoginChildState extends State<LoginChild> {
  Duration get loginTime => Duration(milliseconds: 2250);
  Database db = Database();
  List docs = [];
  var username;
  var password;
  var idno;
  String flag = '';

  Future<void> setFlag(String value) async {
    setState(() {
      flag = value;
    });
  }

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async{
      List<dynamic> userList = await db.readUsers();
      // print(userList);
      if (!userList.any((item){ return item['email'] == data.name; })) {
        return 'User not exists';
      }
      else if (userList.any((item){ return ( (item['email'] == data.name) && (item['password'] != data.password)); })) {
        return 'Password does not match';
      }
      else {
        setState(() {
          username = data.name;
          password = data.password;
        });
        for (dynamic item in userList){
          if (item['email'] == data.name){
            if (item['usertype'] == 'Admin'){
              await setFlag('A');
            }
            else if (item['usertype'] == 'Buyer'){
              await setFlag('B');
            }
            else if (item['usertype'] == 'Courier'){
              await setFlag('C');
            }
            else {
              await setFlag('S');
            }
          }
        }
        return null;
      }
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      Get.to(const RegParent());
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) async{
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: const AssetImage('assets/images/Logo.PNG'),
      onLogin: _authUser,
      onSignup: _signupUser,
      theme: LoginTheme(
        primaryColor: Color.fromARGB(255, 171, 195, 47)
      ),
      onSubmitAnimationCompleted: () {
        if (flag == 'A'){
          Get.to(const HomeAdminParent());
        }
        else if (flag == 'B'){
          Get.to(const HomeBuyerParent());
        }
        else if (flag == 'C'){
          Get.to(const HomeCourierParent());
        }
        else {
          Get.to(const HomeSellerParent());
        }
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}



