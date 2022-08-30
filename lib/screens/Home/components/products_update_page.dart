import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/utils/shimmer_widget.dart';
import 'package:serve_easy/widgets/common_input_field.dart';
import 'package:serve_easy/widgets/rounded_button.dart';
import 'package:serve_easy/widgets/submit_button.dart';

import '../../../services/firestore_service.dart';

class ProductsUpdatePage extends StatefulWidget {
  ProductsUpdatePage({Key? key, this.snap}) : super(key: key);
  final snap;

  @override
  State<ProductsUpdatePage> createState() => _ProductsUpdatePageState();
}

class _ProductsUpdatePageState extends State<ProductsUpdatePage> {
  final productNameEditingController = TextEditingController();

  final productDescriptionEditingController = TextEditingController();

  final productPriceEditingController = TextEditingController();

  // static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: blueColor,
              ),
            ),
            title: Text(
              "Update Products",
              style: TextStyle(
                  color: blueColor, fontWeight: FontWeight.w200, fontSize: 25),
            ),
            backgroundColor: secondColor,
            centerTitle: true,
            elevation: 0,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              CommonInputField(
                nameController: productNameEditingController,
                hintText: "Enter Your Product Name",
                icon: Icons.food_bank,
              ),
              CommonInputField(
                nameController: productDescriptionEditingController,
                hintText: "Enter Your Product Discription ",
                icon: Icons.description,
              ),
              CommonInputField(
                nameController: productPriceEditingController,
                hintText: "Enter Your Product Price",
                icon: Icons.price_change,
              ),
              const SizedBox(
                height: 15,
              ),
              RoundedButton(text: "Select Product Image", onPressed: () {}),
              const Spacer(),
              Center(
                child: SubmitButton(
                  text: "Submit",
                  onPressed: () async {
                    await FirestoreService().updateProducts(
                      productNameEditingController.text,
                      productDescriptionEditingController.text,
                      double.parse(productPriceEditingController.text),
                      "Product Image",
                      widget.snap['categoryId'] ?? "0",
                      widget.snap['productid'] ?? "0",
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              const SizedBox(
                height: 30,
              )
            ],
          )),
    );
  }
}
