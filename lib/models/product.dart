import 'package:cloud_firestore/cloud_firestore.dart';

// class Product {
//   final String name;
//   final String description;
//   final double price;
//   final String imageUrl;
//   final String productid;
//   Product({
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.imageUrl,
//     required this.productid,
//   });
//   static Product fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<dynamic, dynamic>;
//     return Product(
//       name: snapshot["name"],
//       description: snapshot["description"],
//       price: snapshot["price"],
//       imageUrl: snapshot["imageUrl"],
//       productid: snapshot["productid"],
//     );
//   }

//   Map<dynamic, dynamic> toJson() => {
//         "name": name,
//         "description": description,
//         "price": price,
//         "imageUrl": imageUrl,
//         "productid": productid,
//       };
// }
