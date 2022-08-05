import 'package:flutter/material.dart';
import 'package:serve_easy/screens/Welcome/welcome_screen.dart';

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
      body: Center(
        child: Image(
            image: NetworkImage(
                "https://is2-ssl.mzstatic.com/image/thumb/Purple114/v4/9a/53/e8/9a53e8fb-0ebf-9616-8118-245b30b7f0b0/AppIcon-1x_U007emarketing-0-10-0-0-85-220.png/1200x600wa.png")),
      ),
    );
  }

  Future<void> gotoHome() async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WelcomeScreen(),
      ),
    );
  }
}
