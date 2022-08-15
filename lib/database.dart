import 'package:cloud_firestore/cloud_firestore.dart';

class Database {

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
            // "cellnumber": doc['cellnumber'],
            // "birthday": doc['birthday'],
            // "address": doc['address']
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
}