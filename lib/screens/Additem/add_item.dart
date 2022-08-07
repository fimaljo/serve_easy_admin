import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serve_easy/utils/colors.dart';
import 'package:serve_easy/widgets/common_input_field.dart';
import 'package:serve_easy/widgets/rounded_button.dart';

class AdminAddProductPage extends ConsumerStatefulWidget {
  const AdminAddProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddProductPageState();
}

class _AdminAddProductPageState extends ConsumerState<AdminAddProductPage> {
  final titleTextEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: secondColor,
        title: const Text('ADD PRODUCT'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CommonInputField(
            nameController: titleTextEditingController,
            hintText: 'Add Category Name',
            icon: Icons.category_outlined,
          ),
          RoundedButton(
            text: "Add Category Image",
            onPressed: () {},
          ),
          Spacer(),
          RoundedButton(text: 'Create Category', onPressed: () {})
          //there is some logic problem creating category
        ],
      ),
    );
  }
}
