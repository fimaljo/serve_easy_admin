import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serve_easy/screens/Welcome/components/body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
