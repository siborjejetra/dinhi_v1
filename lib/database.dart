import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

String url = '';


// String idno = '';
// void setIdNo(String value) {
//     idno = value;
// }

class Database {

  Future<void> createUser(Map<String, dynamic> newUser) async {

    try {
      await FirebaseFirestore.instance
          .collection("users").add(newUser); 
    } catch (e) {
      print(e);
    }
  }

  Future<void> createProduct(
    String userIdno,
    File? inputImage, 
    String name, 
    String price,
    String unit,
    String description) async {

    try {
      final ref = FirebaseStorage.instance.ref()
          .child('productImages')
          .child('${DateTime.now()}');

      // var inputImage;
      await ref.putFile(File(inputImage!.path));

      url = await ref.getDownloadURL();

      final docProduct = FirebaseFirestore.instance
          .collection("products").doc();

      Map<String, dynamic> newProduct = {
        'image' : url,
        'productId' : docProduct.id,
        'name' : name,
        'price' : price,
        'unit' : unit,
        'description' : description,
      };

      addProductArray(userIdno, newProduct['productId']);

      await docProduct.set(newProduct); 
    } catch (e) {
      print(e);
    }
  }

  Future<void> addProductArray(String userId, String productIdno) async {

    try{
      var collectionRef = FirebaseFirestore.instance.collection('users');
      final doc = await collectionRef.doc(userId).get();
      var docUser = await FirebaseFirestore.instance.collection('users').doc(userId);

      List<dynamic> products = doc.data()!['products'];
      products.add(productIdno);
      docUser.update({'products': products});
    }
    catch (e){
      print(e);
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

            if (doc['usertype'] == 'Seller'){
              a['products'] = doc['products'];
            }
          
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