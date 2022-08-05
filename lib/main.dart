import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:serve_easy/splash_screen.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/utils/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Serve Easy',
      theme: ThemeData(
          primaryColor: kPrimaryColor, scaffoldBackgroundColor: Colors.white),
      home: SplashScreen(),
    );
  }
}
