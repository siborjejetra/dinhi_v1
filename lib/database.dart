import 'dart:io';

import 'package:Dinhi_v1/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:localstorage/localstorage.dart';

String url = '';

LocalStorage localStorage = LocalStorage('user');

class Database {
  Future<void> createUser(Map<String, dynamic> newUser) async {
    try {
      await FirebaseFirestore.instance.collection("users").add(newUser);
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> createProduct(
      String userIdno,
      File? inputImage,
      String name,
      String price,
      String quantity,
      String unit,
      String description,
      Timestamp expiration,
      Map<dynamic, dynamic> userDetails) async {
    Map<String, dynamic> cloneMap = {};
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('productImages')
          .child('${DateTime.now()}');

      // var inputImage;
      await ref.putFile(File(inputImage!.path));

      url = await ref.getDownloadURL();

      final docProduct =
          FirebaseFirestore.instance.collection("products").doc();

      Map<String, dynamic> newProduct = {
        'image': url,
        'productId': docProduct.id,
        'name': name,
        'price': price,
        "quantity": quantity,
        'unit': unit,
        'description': description,
        'rating': '0',
        'expiration': expiration
      };

      addProductArray(userIdno, newProduct['productId']).then((value) {
        userDetails['products'] = value;
        cloneMap = {...userDetails};
        print(cloneMap);
      });
      print(cloneMap);
      await docProduct.set(newProduct);
      return cloneMap;
    } catch (e) {
      print(e);
    }
    return cloneMap;
  }

  Future<List> addProductArray(String userId, String productIdno) async {
    List<String> products = [];
    try {
      var collectionRef = FirebaseFirestore.instance.collection('users');
      final doc = await collectionRef.doc(userId).get();
      var docUser = await collectionRef.doc(userId);
      if (doc.data()!['usertype'] == 'Seller') {
        // print(doc.data()!['products']);
        List<dynamic> newProducts = doc.data()!['products'];
        for (var a in newProducts) {
          products.add(a.toString());
        }
        products.add(productIdno);
        docUser.update({'products': products});
      }
      return products;
    } catch (e) {
      print(e);
    }
    return products;
  }

  Future<Map> editUser(
      Map<String, dynamic> newUserMap, File? inputImage) async {
    String userID = localStorage.getItem('userID');
    print(userID);
    // Map<String, dynamic> newUserMapDB = {};
    try {
      if (inputImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('userImages')
            .child('${DateTime.now()}');

        // var inputImage;
        await ref.putFile(File(inputImage.path));

        url = await ref.getDownloadURL();
        print(url);
        newUserMap['image'] = url;
      }

      var collectionRef = FirebaseFirestore.instance.collection('users');
      final doc = await collectionRef.doc(userID).get();
      var docUser = collectionRef.doc(userID);

      newUserMap['password'] = doc.data()!['password'];
      newUserMap['honorific'] = doc.data()!['honorific'];
      newUserMap['idno'] = doc.data()!['idno'];
      print(newUserMap['idno']);
      if (doc.data()!['usertype'] == 'Seller') {
        newUserMap['products'] = doc.data()!['products'];
      }

      docUser.update(newUserMap);

      print(newUserMap);
      return newUserMap;
    } catch (e) {
      print(e);
    }
    // print(newUserMapDB);
    return newUserMap;
  }

  Future<List> readUsers() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {
            "id": doc.id,
            "email": doc['email'],
            "password": doc['password'],
            "firstname": doc['firstname'],
            "lastname": doc['lastname'],
            "honorific": doc['honorific'],
            "idno": doc['idno'],
            "usertype": doc['usertype'],
            "cellnumber": doc['cellnumber'],
            "birthday": doc['birthday'],
            "address": doc['address'],
            "image": doc['image'],
            "about": doc['about']
          };

          if (doc['usertype'] == 'Seller') {
            a['products'] = doc['products'];
            a['orderlist'] = doc['orderlist'];
          } else if (doc['usertype'] == 'Buyer') {
            a['cart'] = doc['cart'];
            a['orderlist'] = doc['orderlist'];
          } else {
            a['products'] = null;
            a['cart'] = null;
            a['orerlist'] = null;
          }

          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
    return docs;
  }

  Future<List> readProducts() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map b = {
            "id": doc.id,
            "name": doc['name'],
            "price": doc['price'],
            "unit": doc['unit'],
            "quantity": doc['quantity'],
            "description": doc['description'],
            "image": doc['image'],
            "rating": doc['rating'],
            "expiration": doc['expiration']
          };
          docs.add(b);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
    return docs;
  }

  Future<Map> storeUser(String userId) async {
    // List<dynamic> userList = await readUsers();
    QuerySnapshot querySnapshot;
    Map userDeets = {};
    try {
      querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          if (doc.id == userId) {
            userDeets = {
              "id": doc.id,
              "email": doc['email'],
              "password": doc['password'],
              "firstname": doc['firstname'],
              "lastname": doc['lastname'],
              "honorific": doc['honorific'],
              "idno": doc['idno'],
              "usertype": doc['usertype'],
              "cellnumber": doc['cellnumber'],
              "birthday": doc['birthday'],
              "address": doc['address'],
              "image": doc['image'],
              "about": doc['about']
            };
            if (doc['usertype'] == 'Seller') {
              userDeets['products'] = List<String>.from(doc['products']);
              userDeets['orderlist'] = List<String>.from(doc['orderlist']);
            } else if (doc['usertype'] == 'Buyer') {
              userDeets['cart'] = List<String>.from(doc['cart']);
              userDeets['orderlist'] = List<String>.from(doc['orderlist']);
            } else {
              userDeets['products'] = null;
              userDeets['cart'] = null;
              userDeets['orderlist'] = null;
            }
          }
        }
      }
      print(userDeets);
      return userDeets;
    } catch (e) {
      print(e);
    }
    return userDeets;
  }

  Future<List> readCart() async {
    // fix this sht
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map b = {
            "id": doc.id,
            "name": doc['name'],
            "price": doc['price'],
            "unit": doc['unit'],
            "quantity": doc['quantity'],
            "description": doc['description'],
            "image": doc['image'],
            "rating": doc['rating'],
            "expiration": doc['expiration']
          };
          docs.add(b);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
    return docs;
  }

  Future<List> addToCart(
      String productIdno, Map<dynamic, dynamic> userDetails) async {
    List<String> cart = [];
    try {
      var collectionRef = FirebaseFirestore.instance.collection('users');
      final doc = await collectionRef.doc(userDetails['id']).get();
      var docUser = await collectionRef.doc(userDetails['id']);
      print(userDetails);
      if (doc.data()!['usertype'] == 'Buyer') {
        List<dynamic> newCart = doc.data()!['cart'];
        // print(newCart);
        for (var a in newCart) {
          cart.add(a.toString());
        }
        cart.add(productIdno);
        docUser.update({'cart': cart});
      }
      return cart;
    } catch (e) {
      print(e);
    }
    return cart;
  }
}
