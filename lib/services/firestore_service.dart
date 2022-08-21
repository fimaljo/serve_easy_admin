import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_easy/models/category.dart';
import 'package:serve_easy/models/product.dart';

class FirestoreService {
  FirestoreService({required this.uid});
  final String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addCategory(
    Category category,
  ) async {
    await _firestore
        .collection('category')
        .doc(_auth.currentUser!.uid)
        .set(category.toMap())
        .catchError((e) {
      log(e.toString());
    });
  }

  Future<void> addProductData(Product productdata, String productsid) async {
    await _firestore
        .collection('category')
        .doc(_auth.currentUser!.uid)
        .collection('productsdata')
        .doc(productsid)
        .set(productdata.toMap())
        .catchError((e) {
      log(e.toString());
    });
  }

//uid autogeneated aie tolla string lek matti kodukam
  Stream<List<Category>> getProductsCategory() {
    return firestore
        .collection('category')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              // loop through docs
              final d = doc.data(); // for each doc get the data
              return Category.fromMap(d); // convert into a map
            }).toList()); // build a list out of the products mapping
  }

  Stream<List<Product>> getProducts() {
    return firestore
        .collection('category')
        .doc(_auth.currentUser!.uid)
        .collection('productdata')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              // loop through docs
              final d = doc.data();
              return Product.fromMap(d);
            }).toList());
  }
}
