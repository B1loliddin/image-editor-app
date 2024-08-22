import 'package:flutter/material.dart';

class TextInfoModel {
  String text;
  double left;
  double top;
  Color color;
  double fontSize;
  FontWeight fontWeight;
  FontStyle fontStyle;
  TextAlign textAlign;

  TextInfoModel({
    required this.text,
    required this.left,
    required this.top,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.fontStyle,
    required this.textAlign,
  });
}
