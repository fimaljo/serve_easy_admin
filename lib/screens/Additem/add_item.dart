import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';
import 'package:serve_easy/models/category.dart';
import 'package:serve_easy/screens/Additem/add_product.dart';
import 'package:serve_easy/screens/providers.dart';
import 'package:serve_easy/services/firestore_service.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/utils/utils.dart';
import 'package:serve_easy/widgets/common_input_field.dart';
import 'package:serve_easy/widgets/rounded_button.dart';

class AdminAddCategoryPage extends ConsumerStatefulWidget {
  final snap;
  const AdminAddCategoryPage({Key? key, required this.snap}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddCategoryPageState();
}

class _AdminAddCategoryPageState extends ConsumerState<AdminAddCategoryPage> {
  final titleTextEditingController = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  final categoryImageEditingController = TextEditingController();
  //final categoryid = randomAlphaNumeric(16);
//  final descriptionEditingController = TextEditingController();
  //FirestoreService firestoreService = FirestoreService(uid: uid);
  _addcategory() async {
    final storage = ref.read(databaseProvider);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final isValid = formKey.currentState!.validate();
    if (storage == null) {
      return;
    }
    if (!isValid) return;
    {
      await storage.addCategory(
        Category(
            categoryName: titleTextEditingController.text,
            categoryImage: categoryImageEditingController.text,
            categoryId: _auth.currentUser!.uid,
            uid: _auth.currentUser!.uid),
      );
      Utils.showSnackBar("Category created successfully");
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => AdminAddProductPage(),
      ),
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
            'assets/images/logo.jpeg',
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
              icon: Icons.cabin,
            ),
            CommonInputField(
              nameController: categoryImageEditingController,
              hintText: 'Add Category Image Url',
              icon: Icons.image,
            ),
            const Spacer(),
            RoundedButton(
                text: 'Create Category',
                onPressed: () {
                  _addcategory();
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
