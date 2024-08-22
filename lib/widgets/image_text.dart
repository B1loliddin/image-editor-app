import 'package:flutter/material.dart';
import 'package:image_editor_app/models/text_info_model.dart';

class ImageText extends StatelessWidget {
  final TextInfoModel textInfoModel;

  const ImageText({super.key, required this.textInfoModel});

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfoModel.text,
      textAlign: textInfoModel.textAlign,
      style: TextStyle(
        fontSize: textInfoModel.fontSize,
        fontWeight: textInfoModel.fontWeight,
        fontStyle: textInfoModel.fontStyle,
        color: textInfoModel.color,
      ),
    );
  }
}
