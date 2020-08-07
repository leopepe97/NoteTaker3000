import 'package:flutter/material.dart';

class CustomColors {
  static const MaterialColor grayMaterialColor = MaterialColor(
    _grayPrimaryValue,
    <int, Color>{
      50: grayPrimaryColor,
      100: grayPrimaryColor,
      200: grayPrimaryColor,
      300: grayPrimaryColor,
      400: grayPrimaryColor,
      500: grayPrimaryColor,
      600: grayPrimaryColor,
      700: grayPrimaryColor,
      800: grayPrimaryColor,
      900: grayPrimaryColor,
    },
  );
  static const int _grayPrimaryValue = 0xFF2E2E38;
  static const Color grayPrimaryColor = Color(_grayPrimaryValue);

  static const Color _cyan = Color(0xFF96DFE4);
  static const Color _cherryBlossom = Color(0xFFF7CFE1);
  static const Color _yellowIris = Color(0xFFEEE78E);
  static const Color _peachBud = Color(0xFFFCB3A8);
  static const Color _lettuceGreen = Color(0xFFBFD58E);

  static const List<Color> noteColors = [
    _cyan,
    _cherryBlossom,
    _yellowIris,
    _peachBud,
    _lettuceGreen,
  ];
}