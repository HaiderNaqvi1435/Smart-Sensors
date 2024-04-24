import 'package:flutter/material.dart';

import '../../colors/app_colors/app_colors.dart';
import 'dart:ui' as ui;

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onPressed;
  final bool? obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.onPressed,
    this.obscureText,
    this.controller,
    this.focusNode
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText ?? false,
      cursorColor: AppColors.linearColor1,
      style: const TextStyle(color: AppColors.whiteColor),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) {
            return ui.Gradient.linear(
              const Offset(24.0, 0.0),
              const Offset(0.0, 24.0),
              [AppColors.linearColor1, AppColors.linearColor2],
            );
          },
          child: Icon(prefixIcon),
        ),
        suffixIcon: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) {
            return ui.Gradient.linear(
              const Offset(24.0, 0.0),
              const Offset(0.0, 24.0),
              [AppColors.linearColor1, AppColors.linearColor2],
            );
          },
          child: IconButton(onPressed: onPressed, icon: Icon(suffixIcon)),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.linearColor2),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.linearColor1),
        ),
      ),
    );
  }
}
