import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';
import 'package:serve_easy/models/product.dart';
import 'package:serve_easy/screens/Home/items_tab.dart';
import 'package:serve_easy/screens/MainScreen/home_page.dart';
import 'package:serve_easy/screens/providers.dart';
import 'package:serve_easy/services/firestore_service.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/utils/utils.dart';
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
  Widget build(BuildContext context) {
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
            SizedBox(
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
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SubmitButton(
                  onPressed: () async {
                    {
                      String res = await FirestoreService().addProducts(
                        productNameEditingController.text,
                        productDescriptionEditingController.text,
                        double.parse(productPriceEditingController.text),
                        widget.snap['categoryId'],
                        _file!,
                      );
                      if (res == "success") {
                        Utils.showSnackBar("product added successfully");
                        Navigator.pop(context);
                      }
                    }
                  },
                  text: "Add",
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
