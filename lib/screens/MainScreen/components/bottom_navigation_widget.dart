import 'package:flutter/material.dart';
import 'package:serve_easy/utils/colors.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int newIndex, _) {
          return BottomNavigationBar(
              currentIndex: newIndex,
              onTap: (index) {
                indexChangeNotifier.value = index;
              },
              // elevation: 0,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: blueColor,
              selectedIconTheme: const IconThemeData(color: Color(0xFF6F35A5)),
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/home.png',
                      height: 20,
                      color: blueColor,
                    ),
                    label: 'Home'),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/inbox-in.png',
                      height: 20,
                      color: blueColor,
                    ),
                    label: 'Orders'),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/time-past.png',
                      height: 20,
                      color: blueColor,
                    ),
                    label: 'History'),
              ]);
        });
  }
}
