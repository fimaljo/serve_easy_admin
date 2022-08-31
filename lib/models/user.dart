import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String hotelname;
  final String adminuid;
  final String photoUrl;
  final String email;

  const User({
    required this.hotelname,
    required this.adminuid,
     required this.photoUrl,
    required this.email,
  });

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      hotelname: snapshot["hotelname"],
      adminuid: snapshot["adminuid"],
       photoUrl: snapshot["photoUrl"],
      email: snapshot["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "hotelname": hotelname,
        "adminuid": adminuid,
        "photoUrl": photoUrl,
        "email": email,
      };
}
