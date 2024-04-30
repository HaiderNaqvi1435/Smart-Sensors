import 'package:flutter/material.dart';

import '../../colors/app_colors/app_colors.dart';
import '../default_text/default_text.dart';

class DeviceButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Icon icon;
  const DeviceButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: const LinearGradient(
                colors: [
                  AppColors.linearColor1,
                  AppColors.linearColor2,
                  AppColors.linearColor1,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                icon,
                const SizedBox(width: 8),
                DefaultText(
                  text: title,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blackColor,
                  fontSize: 9,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
