import 'package:cloud_firestore/cloud_firestore.dart';

class Category {
  final String categoryName;
  final String categoryImage;
  final String categoryId;
  final String uid;
  Category({
    required this.categoryName,
    required this.categoryImage,
    required this.categoryId,
    required this.uid,
  });
  static Category fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Category(
      categoryName: snapshot["categoryName"],
      categoryImage: snapshot["categoryImage"],
      categoryId: snapshot["categoryId"],
      uid: snapshot["uid"],
    );
  }

  Map<String, dynamic> toJson() => {
        "categoryName": categoryName,
        "categoryImage": categoryImage,
        "categoryId": categoryId,
        "uid": uid
      };
}
