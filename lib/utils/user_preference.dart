import 'package:Dinhi_v1/database.dart';
import 'package:Dinhi_v1/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstorage/localstorage.dart';

Database db = Database();
LocalStorage localStorage =  LocalStorage('user');

class UserPreferences {
  // static Future<User> getUserDeets (String userID) async {
  //   Map userDeets= await db.viewUser(localStorage.getItem('userID'));
  //   User myUser = User(
  //     imagePath: userDeets['image'] != null ? userDeets['image'] :
  //     'https://cdn-icons-png.flaticon.com/512/6097/6097946.png',
  //     firstname: userDeets['firstname'],
  //     lastname: userDeets['lastname'],
  //     email: userDeets['email'],
  //     password: userDeets['password'],
  //     cellnumber: userDeets['cellnumber'],
  //     honorific: userDeets['honorific'],
  //     about: userDeets['about'] != null ? userDeets['about'] :
  //     'Set about',
  //     birthday: userDeets['birthday'],
  //     address: userDeets['address'],
  //     idno: userDeets['idno'],
  //   );
  //   return myUser;
  // } 
  static const myUser = User(
    // userDeets['image'] != null ? userDeets['image'] :
    imagePath: 
      'https://cdn-icons-png.flaticon.com/512/6097/6097946.png',
    firstname: 'Jetra Mae',
    lastname: 'Sibor',
    email: 'siborjejetra@gmail.com',
    password: 'hellojet',
    cellnumber: '09364575235',
    honorific: 'Ms.',
    about: 'BS Computer Science Student - UPLB Women\'s Basketball Team #15 - 22 y/o - Co-developer of Dinhi',
    birthday: '12/10/1999',
    address: 'Canlubang, Calamba, Laguna',
    idno: 'A000',
  );
}