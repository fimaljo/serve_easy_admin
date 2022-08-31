import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:serve_easy/models/user.dart' as model;
import 'package:serve_easy/services/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(documentSnapshot);
  }

//sign up user
  Future<String> signupUser({
    required String email,
    required String password,
    required String hotelname,
    required Uint8List file,
  }) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          hotelname.isNotEmpty ||
          file != null) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        String hotelLogo = await StorageMethods()
            .uploadImageToStorage('hotelLogo', file, false);
        //add user to database
        model.User _user = model.User(
          hotelname: hotelname,
          adminuid: cred.user!.uid,
          photoUrl: hotelLogo,
          email: email,
        );
        await _firestore
            .collection("adminuser")
            .doc(cred.user!.uid)
            .set(_user.toJson());
        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
