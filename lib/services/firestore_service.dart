import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_easy/models/category.dart';

class FirestoreService {
  FirestoreService({required this.uid});
  final String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addCategory(Category category, String categoryid) async {
    await _firestore
        .collection('adminuser')
        .doc(_auth.currentUser!.uid)
        .collection('category')
        .add(category.toMap())
        .catchError((e) {
      print(e.toString());
    });
  }
}
