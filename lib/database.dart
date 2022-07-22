import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  late FirebaseFirestore firestore;
  initialise() {
    firestore = FirebaseFirestore.instance;
  }

  Future<List> read() async {
    QuerySnapshot querySnapshot;
    List docs=[];
    try {
      querySnapshot = await firestore.collection('users').get();
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
            "address": doc['address']
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