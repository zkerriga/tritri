import 'dart:math';
import 'dart:ui' show Color;
import 'package:flutter/material.dart';

class MyColors {
  static const Color transparent  = Color(0x00000000);
  static const Color purple       = Color(0xFFCDB4DB);
  static const Color lightPink    = Color(0xFFFFC8DD);
  static const Color pink         = Color(0xFFFFAFCC);
  static const Color lightBlue    = Color(0xFFBDE0FE);
  static const Color brightBlue   = Color(0xFFA2D2FF);
  static const Color white        = Color(0xFFFFFCFC);
  static const Color black        = Color(0xFF141414);

  static const MaterialColor palette = MaterialColor(
    _palettePrimaryValue,
    <int, Color>{
      50: Color(0xFFFFFCFC),
      100: Color(0xFFBDE0FE),
      200: Color(0xFFA2D2FF),
      300: Color(0xFFFFC8DD),
      400: Color(0xFFFFAFCC),
      500: Color(_palettePrimaryValue),
      600: Color(0xFFCDB4DB),
      700: Color(0xFFCDB4DB),
      800: Color(0xFFCDB4DB),
      900: Color(0xFFCDB4DB),
    },
  );

  static const int _palettePrimaryValue = 0xFFFFFCFC;

  Color randomColor() {
    int i = Random().nextInt(4);
    if (i == 0) return purple;
    else if (i == 1) return lightPink;
    else if (i == 2) return lightBlue;
    else return pink;
  }
}

