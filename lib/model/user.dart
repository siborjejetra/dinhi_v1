import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String imagePath;
  final String firstname;
  final String lastname;
  final String email;
  final String password;
  final String cellnumber;
  final String honorific;
  final String about;
  final Timestamp birthday;
  final String address;
  final String idno;
  final List<String>? products;
  final List<String>? cart;
  final List<String>? orderlist;
  final String? status;
  final String? plateNumber;
  final List<String>? deliverylist;

  const User(
      {required this.imagePath,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.password,
      required this.cellnumber,
      required this.honorific,
      required this.about,
      required this.birthday,
      required this.address,
      required this.idno,
      this.products,
      this.cart,
      this.orderlist,
      this.status,
      this.plateNumber,
      this.deliverylist});
}
