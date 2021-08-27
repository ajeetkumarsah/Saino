import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider {
  //Firebase Database Instance
  FirebaseFirestore _db = FirebaseFirestore.instance;
  Stream<QuerySnapshot> getMyData() {
    return FirebaseFirestore.instance.collection('data').snapshots();
  }
  Future<bool> addNewTrucks({required Map<String, dynamic> map}) async {
    if (map.isEmpty) return false;

    return _db
        .collection('data')
        .add(map)
        .then((value) => true)
        .catchError((onError) => false);
  }
}

//Global Key
FirebaseProvider firebaseProvider = FirebaseProvider();
