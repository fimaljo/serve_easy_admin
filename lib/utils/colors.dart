import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const Color scaffoldColor = Color(0xffF3F3F0); //Yellow

const Color blueColor = Color(0xFF6F35A5);
const Color backgroundColor = Color(0xffebecee);
const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

const double defaultPadding = 16.0;
const Color secondColor = Colors.white;
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  log('No image selected');
}
