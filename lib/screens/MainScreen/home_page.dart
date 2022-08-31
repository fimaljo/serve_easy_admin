import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serve_easy/screens/Home/items_tab.dart';
import 'package:serve_easy/screens/Orders/orders_tab.dart';
import 'package:serve_easy/screens/History/payment_tab.dart';
import 'package:serve_easy/screens/MainScreen/components/bottom_navigation_widget.dart';
import 'package:serve_easy/screens/Profile/profile_screen.dart';
import 'package:serve_easy/utils/colors.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _pages = [
    ItemsTab(),
    OrdersTab(),
    PaymentTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
            valueListenable: indexChangeNotifier,
            builder: (context, int index, _) {
              return _pages[index];
            }),
        bottomNavigationBar: BottomNavigationWidget(),
      ),
    );
  }
}
