import 'package:flutter/material.dart';

import '../../colors/app_colors/app_colors.dart';

class TitleTextWidget extends StatelessWidget {
  final String title;
  const TitleTextWidget({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
          color: AppColors.titleTextColor,
          fontWeight: FontWeight.bold,
          fontSize: 24),
    );
  }
}