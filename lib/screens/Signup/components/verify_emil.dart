import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serve_easy/screens/Home/home_page.dart';
import 'package:serve_easy/screens/Login/components/background.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/utils/utils.dart';
import 'package:serve_easy/widgets/rounded_button.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;
  @override
  void initState() {
    super.initState();
    //user needs to be created before!
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    //call after email verification!
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomePage()
      : Scaffold(
          body: Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "VERIFY EMAIL",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 70,
                ),
                const Text(
                  " A verification email has been \n sent to your email\n check the spam folder also",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: kPrimaryColor),
                ),
                const SizedBox(
                  height: 70,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: Container(
                    width: 270,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                    ),
                    child: TextButton(
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                      child: Text(
                        "Resent Email",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: Container(
                    width: 270,
                    height: 50,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                    ),
                    child: TextButton(
                      onPressed: () => FirebaseAuth.instance.signOut(),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
}
