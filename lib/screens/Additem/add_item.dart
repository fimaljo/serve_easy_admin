import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_string/random_string.dart';
import 'package:serve_easy/models/category.dart';
import 'package:serve_easy/screens/Additem/add_product.dart';
import 'package:serve_easy/screens/providers.dart';
import 'package:serve_easy/services/firestore_service.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/widgets/common_input_field.dart';
import 'package:serve_easy/widgets/rounded_button.dart';

class AdminAddCategoryPage extends ConsumerStatefulWidget {
  const AdminAddCategoryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddProductPageState();
}

class _AdminAddProductPageState extends ConsumerState<AdminAddCategoryPage> {
  final titleTextEditingController = TextEditingController();
  static final formKey = GlobalKey<FormState>();
  final categoryImageEditingController = TextEditingController();
//  final descriptionEditingController = TextEditingController();
  //FirestoreService firestoreService = FirestoreService(uid: uid);
  _addcategory() async {
    final storage = ref.read(databaseProvider);
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final isValid = formKey.currentState!.validate();
    // final categoryid = randomAlphaNumeric(16);
    if (storage == null) {
      return;
    }
    if (!isValid) return;
    {
      await storage.addCategory(
          Category(
              categoryImage: categoryImageEditingController.text,
              categoryName: titleTextEditingController.text),
          _auth.currentUser!.uid);
    }

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminAddProductPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: secondColor,
          title: const Text('A D D  C A T E G O R Y'),
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
              SizedBox(
                height: 30,
              )
              //there is some logic problem creating category
            ],
          ),
        ),
      ),
    );
  }
}
