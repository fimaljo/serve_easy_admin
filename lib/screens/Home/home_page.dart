import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serve_easy/screens/Home/components/items_tab.dart';
import 'package:serve_easy/screens/Home/components/orders_tab.dart';
import 'package:serve_easy/screens/Home/components/payment_tab.dart';
import 'package:serve_easy/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: secondColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle,
              color: blueColor,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(
                  Icons.logout,
                  color: blueColor,
                ))
          ],
          backgroundColor: secondColor,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Image(
            height: 40,
            image: AssetImage(
              'assets/images/logo.jpeg',
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              indicator: BoxDecoration(
                  color: blueColor, borderRadius: BorderRadius.circular(20)),
              labelColor: Colors.white,
              unselectedLabelColor: blueColor,
              tabs: const [
                Tab(
                  text: 'ITEAMS',
                ),
                Tab(
                  text: 'ORDERS',
                ),
                Tab(
                  text: 'PAYMENTS',
                ),
              ],
            ),
            const Expanded(
                child: TabBarView(children: [
              ItemsTab(),
              OrdersTab(),
              PaymentTab(),
            ]))
          ],
        ),
      ),
    );
  }
}
