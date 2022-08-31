import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: const [
        SizedBox(
          height: 50,
        ),
        Center(
            child: CircleAvatar(
          radius: 50,
        )),
      ],
    ));
  }
}
