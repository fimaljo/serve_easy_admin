import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:serve_easy/screens/MainScreen/home_page.dart';
import 'package:serve_easy/screens/Login/login_screen.dart';
import 'package:serve_easy/screens/Signup/background.dart';
import 'package:serve_easy/services/auth_methods.dart';
import 'package:serve_easy/services/storage_methods.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/utils/utils.dart';
import 'package:serve_easy/widgets/already_have_an_account_check.dart';
import 'package:serve_easy/widgets/common_input_field.dart';
import 'package:serve_easy/widgets/rounded_button.dart';
import 'package:serve_easy/widgets/rounded_input_field.dart';
import 'package:serve_easy/widgets/rounded_password_field.dart';

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
  Uint8List? _file;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();

    super.dispose();
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add Your logo'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
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
              _file != null
                  ? Container(
                      height: 140,
                      width: 140,
                      child: Image(
                        image: MemoryImage(_file!),
                        fit: BoxFit.cover,
                      ),
                      decoration: const BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                    )
                  : InkWell(
                      onTap: () => _selectImage(context),
                      child: Container(
                        height: 140,
                        width: 140,
                        child: Center(child: Text("Select Your logo")),
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
              SizedBox(
                height: size.height * 0.03,
              ),
              CommonInputField(
                  icon: Image.asset(
                    'assets/icons/utensils.png',
                    height: 20,
                    color: blueColor,
                  ),
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
      String res = await AuthMethods().signupUser(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          hotelname: nameController.text.trim(),
          file: _file!);
      if (res != 'success') {
        Utils.showSnackBar("success");
      }
      // if (res != 'success') {
      //   Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(builder: (context) => HomePage()));
      // }
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
  }
}
