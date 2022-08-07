import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serve_easy/screens/Login/login_screen.dart';
import 'package:serve_easy/screens/Signup/sign_up_screen.dart';
import 'package:serve_easy/screens/Welcome/components/background.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/widgets/rounded_button.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'WELCOME TO SERVE EASY',
              style:
                  TextStyle(color: scaffoldColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Image.asset(
              "assets/icons/chat.png",
              height: size.height * 0.45,
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            RoundedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              color: blueColor,
              text: 'LOGIN',
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            RoundedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                );
              },
              text: 'SIGN UP',
              textColor: Colors.black,
              color: kPrimaryLightColor,
            ),
          ],
        ),
      ),
    );
  }
}
