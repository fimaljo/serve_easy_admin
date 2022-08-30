import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_easy/models/category.dart';
import 'package:serve_easy/models/product.dart';
import 'package:uuid/uuid.dart';

class FirestoreService {
  // FirestoreService({required this.uid});
  // final String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> addCategory(
    String categoryName,
    String categoryImage,
    String uid,
  ) async {
    String res = "some error pccured";
    try {
      String categoryId = const Uuid().v1();
      Category category = Category(
        categoryName: categoryName,
        categoryImage: categoryImage,
        categoryId: categoryId,
        uid: uid,
      );
      _firestore.collection('category').doc(categoryId).set(category.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> addProducts(
    String name,
    String description,
    double price,
    String imageUrl,
    String categoryId,
  ) async {
    String res = "some error pccured";
    try {
      String productsId = const Uuid().v1();
      _firestore
          .collection('category')
          .doc(categoryId)
          .collection('products')
          .doc(productsId)
          .set({
        "name": name,
        "description": description,
        "price": price,
        "imageUrl": imageUrl,
        "productid": productsId,
        "categoryId": categoryId,
      });
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> updateProducts(
    String name,
    String description,
    double price,
    String imageUrl,
    String categoryId,
    String productsId,
  ) async {
    String res = "some error pccured";
    try {
      _firestore
          .collection('category')
          .doc(categoryId)
          .collection('products')
          .doc(productsId)
          .update({
        'name': name,
        'description': description,
        'price': price,
        'imageUrl': imageUrl,
        'productid': productsId,
      });
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//category delet
  Future<String> deleteCaregory(
    String categoryId,
  ) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('category').doc(categoryId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

//product delet
  Future<String> deleteProduct(
    String categoryId,
    String productsId,
  ) async {
    String res = "Some error occurred";
    try {
      await _firestore
          .collection('category')
          .doc(categoryId)
          .collection('products')
          .doc(productsId)
          .delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //Future<void> addProductData(Product productdata, String productsid) async {
  // await _firestore
  //    .collection('category')
  //   .doc(_auth.currentUser!.uid)
  //   .collection('productsdata')
  //  .doc(productsid)
  //  .set(productdata.toMap())
  //  .catchError((e) {
  //log(e.toString());
  // });
  //}

//uid autogeneated aie tolla string lek matti kodukam
  // Stream<List<Category>> getProductsCategory() {
  //   return _firestore
  //      .collection('category')
  //     .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //    .snapshots()
  //   .map((snapshot) => snapshot.docs.map((doc) {
  //          // loop through docs
  //     final d = doc.data(); // for each doc get the data
  //     return Category.fromMap(d); // convert into a map
  //   }).toList()); // build a list out of the products mapping
  //}

}
