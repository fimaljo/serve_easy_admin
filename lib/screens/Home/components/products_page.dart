import 'package:flutter/material.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productNameEditingController = TextEditingController();
    final productDescriptionEditingController = TextEditingController();
    final productPriceEditingController = TextEditingController();
    return SafeArea(
      child: Scaffold(body: Column()),
    );
  }
}
