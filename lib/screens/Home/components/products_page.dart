import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productNameEditingController = TextEditingController();
    final productDescriptionEditingController = TextEditingController();
    final productPriceEditingController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Colors.red,
              child: TextField(
                controller: productNameEditingController,
                decoration: InputDecoration(
                  icon: Icon(Icons.ios_share_outlined),
                  hintText: 'update name',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              color: Colors.red,
              child: TextField(
                controller: productDescriptionEditingController,
                decoration: InputDecoration(
                  icon: Icon(Icons.ios_share_outlined),
                  hintText: 'update name',
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              color: Colors.red,
              child: TextField(
                controller: productPriceEditingController,
                decoration: InputDecoration(
                  icon: Icon(Icons.ios_share_outlined),
                  hintText: 'update name',
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
