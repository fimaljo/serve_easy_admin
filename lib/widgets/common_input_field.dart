import 'package:flutter/material.dart';
import 'package:serve_easy/utils/colors.dart';

class CommonInputField extends StatelessWidget {
  const CommonInputField({
    Key? key,
    required this.nameController,
    required this.hintText,
    required this.icon,
  }) : super(key: key);
  final String hintText;
  final TextEditingController nameController;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      decoration: BoxDecoration(
          color: kPrimaryLightColor, borderRadius: BorderRadius.circular(29)),
      child: TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hintText,
          border: InputBorder.none,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) =>
            value != null && value.length < 3 ? 'Enter Data' : null,
      ),
    );
  }
}
