import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

String idno = '';
void setIdNo(String value) {
    idno = value;
}

class Database {

  Future<void> createUser(Map<String, dynamic> newUser) async {

    try {
      await FirebaseFirestore.instance
          .collection("users").add(newUser); 
    } catch (e) {
      print(e);
    }
  }

  Future<void> createProduct(Map<String, dynamic> newProduct) async {

    try {
      final ref = FirebaseStorage.instance.ref()
          .child('productImages') //kung anong pangalan ng folder ng storage
          .child(
              '${DateTime.now()}'); //filename so kahit random ikaw bahala

      var inputImage;
      await ref.putFile(File(inputImage!.path));


      var url = await ref.getDownloadURL();

      // widget.plant.icon = url;
    } catch (e) {
      print('fail');
      
    }
  }

  Future<List> readUsers() async {
    QuerySnapshot querySnapshot;
    List docs=[];
    try {
      querySnapshot = await FirebaseFirestore.instance.collection('users').get();
      if(querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id, 
            "email": doc['email'], 
            "password": doc['password'],
            "firstname": doc['firstname'],
            "lastname": doc['lastname'],
            "idno": doc['idno'],
            "usertype": doc['usertype'],
            "cellnumber": doc['cellnumber'],
            "birthday": doc['birthday'],
            "address": doc['address'],
            "image": doc['image']
            };
          docs.add(a);
        }
        return docs;
      }
    }
    catch (e){
      print(e);
    }
    return docs;
  }

  Future<List> readProducts() async {
    QuerySnapshot querySnapshot;
    List docs=[];
    try {
      querySnapshot = await FirebaseFirestore.instance.collection('users').get();
      if(querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map b = {
            "id": doc.id, 
            "name": doc['name'], 
            "price": doc['price'],
            "description": doc['description'],
            "image": doc['image']
            };
          docs.add(b);
        }
        return docs;
      }
    }
    catch (e){
      print(e);
    }
    return docs;
  }



}