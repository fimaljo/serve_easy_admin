import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serve_easy/screens/Login/login_screen.dart';
import 'package:serve_easy/screens/Signup/background.dart';
import 'package:serve_easy/utils/utils.dart';
import 'package:serve_easy/widgets/already_have_an_account_check.dart';
import 'package:serve_easy/widgets/common_input_field.dart';
import 'package:serve_easy/widgets/rounded_button.dart';
import 'package:serve_easy/widgets/rounded_input_field.dart';
import 'package:serve_easy/widgets/rounded_password_field.dart';

import '../../utils/colors.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                height: 140,
                width: 140,
                decoration: const BoxDecoration(
                    color: Colors.red, shape: BoxShape.circle),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CommonInputField(
                  icon: Icons.restaurant,
                  hintText: "Restorent Name",
                  nameController: nameController),
              RoundedInputField(
                hintText: 'Your Email',
                controller: emailController,
              ),
              RoundedPasswordField(
                controller: passwordController,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              RoundedButton(
                text: 'SIGNUP',
                onPressed: () {
                  signUp();
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AlreadyHaveAnAccountCheck(
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                login: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      //add user detiles
      addUserDetails(
        'logo',
        nameController.text.trim(),
        emailController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }

  Future addUserDetails(
    String hotelLogo,
    String hotelName,
    String email,
  ) async {
    await FirebaseFirestore.instance.collection('adminuser').add({
      'hotel logo': hotelLogo,
      'hotel name': hotelName,
      'email': email,
    });
  }
}
