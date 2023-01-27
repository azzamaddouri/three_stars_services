// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppColors {
  static const Color deep_orange = Color(0xFF152b99);
  static const Color deep_blue = Colors.orangeAccent;
  static const MaterialColor kToDark = MaterialColor(
    0xFF152b99, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF152b99), //10%
      100: Color(0xFF152b99), //20%
      200: Color(0xFF152b99), //30%
      300: Color(0xFF152b99), //40%
      400: Color(0xFF152b99), //50%
      500: Color(0xFF152b99), //60%
      600: Color(0xFF152b99), //70%
      700: Color(0xFF152b99), //80%
      800: Color(0xFF152b99), //90%
      900: Color(0xFF152b99), //100%
    },
  );
} //
