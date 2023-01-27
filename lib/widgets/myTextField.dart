import 'package:flutter/material.dart';

Widget myTextField(String labelText, keyBoardType, controller) {
  return TextField(
    keyboardType: keyBoardType,
    controller: controller,
    decoration: InputDecoration(labelText: labelText),
  );
}
