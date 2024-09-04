import 'package:flutter/material.dart';

class AppText {
  static TextStyle style(
      {double? fontSize = 14, FontWeight fontWeight = FontWeight.w400}) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle body = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
}
