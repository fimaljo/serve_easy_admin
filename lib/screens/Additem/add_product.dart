import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';
import 'package:serve_easy/models/product.dart';
import 'package:serve_easy/screens/Home/home_page.dart';
import 'package:serve_easy/screens/providers.dart';
import 'package:serve_easy/services/firestore_service.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/widgets/common_input_field.dart';
import 'package:serve_easy/widgets/rounded_button.dart';
import 'package:serve_easy/widgets/submit_button.dart';

class AdminAddProductPage extends ConsumerStatefulWidget {
  final snap;
  const AdminAddProductPage({Key? key, required this.snap}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddProductPageState();
}

class _AdminAddProductPageState extends ConsumerState<AdminAddProductPage> {
  final productNameEditingController = TextEditingController();
  final productDescriptionEditingController = TextEditingController();
  final productPriceEditingController = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  // final productsid = randomAlphaNumeric(16);
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // _addproduct() async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   final isValid = formKey.currentState!.validate();
  //   //  final categoryid = randomAlphaNumeric(16);

  //   if (!isValid) return;
  //   {
  //     String res = await FirestoreService().addProducts(
  //         productNameEditingController.text,
  //         productDescriptionEditingController.text,
  //         double.parse(productPriceEditingController.text),
  //         "Product Image",
  //         "");
  //     //  await storage.addProductData(
  //     //  Product(
  //     //  name: productNameEditingController.text,
  //     // description: productDescriptionEditingController.text,
  //     // price: double.parse(productPriceEditingController.text),
  //     // imageUrl: "productimg",
  //     //  productid: productsid),
  //     // productsid,
  //     // );
  //   }

  //   Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => AdminAddProductPage(),
  //       ));
  // }

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
          backgroundColor: secondColor,
          centerTitle: true,
          elevation: 0,
          title: const Image(
            height: 40,
            image: AssetImage(
              'assets/images/Serve easy-08.png',
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: Column(
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
              SizedBox(
                height: 15,
              ),
              RoundedButton(text: "Select Product Image", onPressed: () {}),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: SubmitButton(
                      onPressed: () async {
                        {
                          await FirestoreService().addProducts(
                              productNameEditingController.text,
                              productDescriptionEditingController.text,
                              double.parse(productPriceEditingController.text),
                              "Product Image",
                              widget.snap['categoryId']);
                          Navigator.pop(context);
                        }
                      },
                      text: "Add",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
