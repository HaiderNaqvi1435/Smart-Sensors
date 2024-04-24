import 'package:flutter/material.dart';

import '../../colors/app_colors/app_colors.dart';

class DefaultText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  const DefaultText({
    super.key,
    this.fontSize,
    this.color,
    this.fontWeight,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color ?? AppColors.whiteColor,
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
