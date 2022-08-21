import 'package:flutter/material.dart';
import 'package:serve_easy/screens/Welcome/welcome_screen.dart';
import 'package:serve_easy/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    gotoHome();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: blueColor,
      body: Center(
        child: Image(
            height: 90, image: AssetImage("assets/images/flashlogo.jpeg")),
      ),
    );
  }

  Future<void> gotoHome() async {
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }
}
