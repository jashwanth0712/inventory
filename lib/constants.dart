import 'package:flutter/material.dart';

mixin AppColors {
  static const primaryColor = Color(0xFF346068);
  static const secondaryColor = Color(0xFFDEE9E1);
  static Color secondaryTextColor = const Color(0xFFBABFC4);
}
mixin AppTextFields {
  static InputDecoration minimalTextFieldDecoration = InputDecoration(
    focusColor: Colors.black,
    hintText: 'Enter a value',
    helperStyle: TextStyle(
      color: Colors.green.shade400,
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 2.0,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 10.0,
      horizontal: 0,
    ),
    labelStyle: const TextStyle(
      color: Colors.black,
    ),
    hintStyle: const TextStyle(
      color: Colors.black,
    ),
  );
}
