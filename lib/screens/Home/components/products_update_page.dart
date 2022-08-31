import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/utils/shimmer_widget.dart';
import 'package:serve_easy/utils/utils.dart';
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
  TextEditingController productNameEditingController = TextEditingController();
  TextEditingController productDescriptionEditingController =
      TextEditingController();
  TextEditingController productPriceEditingController = TextEditingController();
  // static final formKey = GlobalKey<FormState>();
  Uint8List? _file;
  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add Your logo'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.pop(context);
                  Uint8List file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    productNameEditingController.text = widget.snap['name'];
    productDescriptionEditingController.text = widget.snap['description'];
    productPriceEditingController.text = widget.snap['price'].toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              hintText: 'Update Product Name',
              icon: Image.asset(
                'assets/icons/apps.png',
                height: 20,
                color: blueColor,
              ),
            ),
            CommonInputField(
              nameController: productDescriptionEditingController,
              hintText: "Enter Your Product Discription ",
              icon: Image.asset(
                'assets/icons/edit.png',
                height: 20,
                color: blueColor,
              ),
            ),
            CommonInputField(
              nameController: productPriceEditingController,
              hintText: "Enter Your Product Price",
              icon: Image.asset(
                'assets/icons/rupee.png',
                height: 20,
                color: blueColor,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            _file != null
                ? InkWell(
                    onTap: () => _selectImage(context),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        child: Image(
                          image: MemoryImage(_file!),
                          height: 200,
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () => _selectImage(context),
                    child: SizedBox(
                      child: Column(
                        children: const [
                          Image(
                            image:
                                AssetImage('assets/images/Images-rafiki.png'),
                            height: 300,
                          ),
                          Text("Add Product Image")
                        ],
                      ),
                    ),
                  ),
            const Spacer(),
            Center(
              child: SubmitButton(
                text: "Submit",
                onPressed: () async {
                  await FirestoreService().updateProducts(
                    productNameEditingController.text,
                    productDescriptionEditingController.text,
                    double.parse(productPriceEditingController.text),
                    _file!,
                    widget.snap['categoryId'] ?? "0",
                    widget.snap['productid'] ?? "0",
                  );
                  Utils.showSnackBar("Product Updated Successfully");
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
        ));
  }
}
