import 'dart:io';

import 'package:Dinhi_v1/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
      String buyQuantity,
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
        'name': name,
        'price': price,
        "quantity": quantity,
        'unit': unit,
        'buyQuantity': buyQuantity,
        'description': description,
        'rating': '0',
        'expiration': expiration,
        'seller_id': userIdno,
      };

      addProductArray(userIdno, docProduct.id).then((value) {
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

  Future<String> createTransaction(Map transaction) async {
    String transactionId = '';
    String url = '';
    try {
      final docTransaction =
          FirebaseFirestore.instance.collection("transactions").doc();

      Map<String, dynamic> newTransaction = {
        'buyer_id': transaction['buyer_id'],
        'notes': transaction['notes'],
        'products': transaction['products'],
        'status': transaction['status'],
        'total': transaction['total'],
        'date': DateTime.now(),
        'buyer_proof': url,
        'seller_proof': "",
        'courier_id': transaction['courier_id'],
        'courier_proof': "",
      };
      transactionId = docTransaction.id;

      newTransaction['transaction_id'] = transactionId;

      await docTransaction.set(newTransaction);
      return transactionId;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return transactionId;
  }

  Future<List<String>?> addTransactiontoBuyer(
      String transactionId, String buyerId) async {
    List<String>? orderlist;
    try {
      var collectionRef = FirebaseFirestore.instance.collection('users');
      final docBuyer = collectionRef.doc(buyerId);
      docBuyer.update({
        "orderlist": FieldValue.arrayUnion([transactionId]),
      });
      final doc = await collectionRef.doc(buyerId).get();
      orderlist = (doc.data()!['orderlist']).cast<String>() as List<String>?;
      return orderlist;
    } catch (e) {
      print(e);
    }
    return orderlist;
  }

  void addTransactiontoSeller(
    String transactionId,
    String sellerId,
  ) async {
    try {
      print(sellerId);
      final docSeller =
          FirebaseFirestore.instance.collection("users").doc(sellerId);
      docSeller.update({
        "orderlist": FieldValue.arrayUnion([transactionId]),
      });
    } catch (e) {
      print(e);
    }
  }

  void addTransactiontoCourier(
    String transactionId,
    String courierId,
  ) async {
    try {
      print(courierId);
      final docCourier =
          FirebaseFirestore.instance.collection("users").doc(courierId);
      docCourier.update({
        "deliverylist": FieldValue.arrayUnion([transactionId]),
      });
    } catch (e) {
      print(e);
    }
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

  Future<Map> addCourierProofTransaction(Map<dynamic, dynamic> transaction,
      Map<String, dynamic> newTransaction, File? inputImage) async {
    Map newTransMap = {};
    String url = '';
    try {
      if (inputImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('transactionImages')
            .child('${DateTime.now()}');

        // var inputImage;
        await ref.putFile(File(inputImage.path));

        url = await ref.getDownloadURL();
        print(url);
      }
      newTransaction['courier_proof'] = url;
      newTransaction['notes'] = 'Order has been delivered';

      var collectionRef = FirebaseFirestore.instance.collection('transactions');
      var docUser = collectionRef.doc(transaction['id']);

      docUser.update(newTransaction);

      final doc = await collectionRef.doc(transaction['id']).get();

      newTransMap = {...transaction};
      newTransMap['courier_proof'] = newTransaction['courier_proof'];
      newTransMap['notes'] = newTransaction['notes'];

      // print(newTransMap);
      return newTransMap;
    } catch (e) {
      print(e);
    }
    // print(newUserMapDB);
    return newTransMap;
  }

  Future<void> buyerEditTransaction(
      Map<dynamic, dynamic> transaction, File? inputImage) async {
    Map<String, dynamic> newTransMap = {};
    String url = '';
    try {
      if (inputImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('transactionImages')
            .child('${DateTime.now()}');

        // var inputImage;
        await ref.putFile(File(inputImage.path));

        url = await ref.getDownloadURL();
        print(url);
      }
      newTransMap['buyer_proof'] = url;
      newTransMap['status'] = 'Ongoing';

      var collectionRef = FirebaseFirestore.instance.collection('transactions');
      var docUser = collectionRef.doc(transaction['id']);

      docUser.update(newTransMap);
    } catch (e) {
      print(e);
    }
  }

  Future<Map> courierEditTransaction(Map<dynamic, dynamic> transaction,
      Map<String, dynamic> newTransaction, Map courierDeets) async {
    Map newTransMap = {};
    String url = '';
    try {
      var collectionRef = FirebaseFirestore.instance.collection('transactions');
      var docTransaction = collectionRef.doc(transaction['id']);

      if (newTransaction['notes'] != 'Out for Delivery') {
        // insert logic if courier rejects
      }

      docTransaction.update(newTransaction);

      return (courierDeets);
    } catch (e) {
      print(e);
    }
    return (courierDeets);
  }

  Future<Map> sellerEditTransaction(Map<dynamic, dynamic> transaction,
      Map<String, dynamic> newTransaction, File? inputImage) async {
    Map newTransMap = {};
    String url = '';
    try {
      if (inputImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('transactionImages')
            .child('${DateTime.now()}');

        // var inputImage;
        await ref.putFile(File(inputImage.path));

        url = await ref.getDownloadURL();
        print(url);
      }
      newTransaction['seller_proof'] = url;
      newTransaction['notes'] = 'Order Processed';

      var collectionRef = FirebaseFirestore.instance.collection('transactions');
      var docUser = collectionRef.doc(transaction['id']);

      docUser.update(newTransaction);

      final doc = await collectionRef.doc(transaction['id']).get();

      newTransMap = {...transaction};
      newTransMap['courier_id'] = newTransaction['courier_id'];
      newTransMap['seller_proof'] = newTransaction['seller_proof'];
      newTransMap['notes'] = newTransaction['notes'];

      // print(newTransMap);
      return newTransMap;
    } catch (e) {
      print(e);
    }
    // print(newUserMapDB);
    return newTransMap;
  }

  Future<Map> editTransaction(Map<dynamic, dynamic> transaction,
      Map<String, dynamic> newTransaction, File? inputImage) async {
    Map newTransMap = {};
    String url = '';
    try {
      if (inputImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('transactionImages')
            .child('${DateTime.now()}');

        // var inputImage;
        await ref.putFile(File(inputImage.path));

        url = await ref.getDownloadURL();
        print(url);
      }

      var collectionRef = FirebaseFirestore.instance.collection('transactions');
      var docUser = collectionRef.doc(transaction['id']);

      docUser.update(newTransaction);

      final doc = await collectionRef.doc(transaction['id']).get();

      newTransMap = {...transaction};

      newTransMap['notes'] = newTransaction['notes'];

      if (url.isNotEmpty) {
        newTransMap['buyer_proof'] == url;
      }

      // print(newTransMap);
      return newTransMap;
    } catch (e) {
      print(e);
    }
    // print(newUserMapDB);
    return newTransMap;
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
          } else if (doc['usertype'] == 'Courier') {
            a['status'] = doc['status'];
            a['deliverylist'] = doc['deliverylist'];
            a['plate_no'] = doc['plate_no'];
          } else {
            a['plate_no'] = null;
            a['status'] = null;
            a['deliverylist'] = null;
            a['products'] = null;
            a['cart'] = null;
            a['orderlist'] = null;
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
            "expiration": doc['expiration'],
            "seller_id": doc['seller_id'],
            "buyQuantity": doc['buyQuantity']
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

  Future<List> readTransactions() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await FirebaseFirestore.instance.collection('transactions').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map b = {
            "id": doc.id,
            "buyer_id": doc['buyer_id'],
            "buyer_proof": doc['buyer_proof'],
            "courier_id": doc['courier_id'],
            "courier_proof": doc['courier_proof'],
            "date": doc['date'],
            "products": doc['products'],
            "seller_proof": doc['seller_proof'],
            "status": doc['status'],
            "total": doc['total'],
            "notes": doc['notes']
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
            } else if (doc['usertype'] == 'Courier') {
              userDeets['status'] = doc['status'];
              userDeets['deliverylist'] =
                  List<String>.from(doc['deliverylist']);
              userDeets['plate_no'] = doc['plate_no'];
            } else {
              userDeets['plate_no'] = null;
              userDeets['status'] = null;
              userDeets['deliverylist'] = null;
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
