import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:Dinhi_v1/Admin/home.dart';
import 'database.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
  'mariapranseska@gmail.com': 'ayeyeye',
  'siborjejetra@gmail.com': 'hellojet '
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

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async{
      if (!users.containsKey(data.name)) {
        return 'User not exists';
      }
      if (users[data.name] != data.password) {
        return 'Password does not match';
      }
      db.read().then((value) => {
        setState(() {
          docs = value;
        })
      });
      print(docs);
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
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
      // title: 'DINHI',
      logo: const AssetImage('assets/images/Logo.PNG'),
      onLogin: _authUser,
      onSignup: _signupUser,
      theme: LoginTheme(
        primaryColor: Color.fromARGB(255, 171, 195, 47)
      ),
      onSubmitAnimationCompleted: () {
        // Navigator.of(context).pushReplacement(MaterialPageRoute(
        //   builder: (context) => DashboardScreen(),
        // ));
        Get.to(const HomeAdminParent());
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}



