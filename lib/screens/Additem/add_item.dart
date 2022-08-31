import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';
import 'package:serve_easy/models/category.dart';
import 'package:serve_easy/screens/Additem/add_product.dart';
import 'package:serve_easy/screens/Home/items_tab.dart';
import 'package:serve_easy/screens/providers.dart';
import 'package:serve_easy/services/firestore_service.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/utils/utils.dart';
import 'package:serve_easy/widgets/common_input_field.dart';
import 'package:serve_easy/widgets/rounded_button.dart';

class AdminAddCategoryPage extends ConsumerStatefulWidget {
  const AdminAddCategoryPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddCategoryPageState();
}

class _AdminAddCategoryPageState extends ConsumerState<AdminAddCategoryPage> {
  final titleTextEditingController = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  final categoryImageEditingController = TextEditingController();
//  final descriptionEditingController = TextEditingController();
  //FirestoreService firestoreService = FirestoreService(uid: uid);
  _addcategory(
    String uid,
  ) async {
    final isValid = formKey.currentState!.validate();

    if (!isValid) return;
    {
      String res = await FirestoreService().addCategory(
        titleTextEditingController.text,
        categoryImageEditingController.text,
        uid,
      );
      if (res == "success") {
        Utils.showSnackBar("category created successfully");
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
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
            'assets/images/category.png',
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CommonInputField(
              nameController: titleTextEditingController,
              hintText: 'Add Category Name',
              icon: Image.asset(
                'assets/icons/apps.png',
                height: 20,
                color: blueColor,
              ),
            ),
            CommonInputField(
              nameController: categoryImageEditingController,
              hintText: 'Add Category Image Url',
              icon: Image.asset(
                'assets/icons/link-alt.png',
                height: 20,
                color: blueColor,
              ),
            ),
            const Spacer(),
            RoundedButton(
                text: 'Create Category',
                onPressed: () {
                  _addcategory(_auth.currentUser!.uid);
                }),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
