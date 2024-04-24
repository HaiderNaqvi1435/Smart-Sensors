import 'package:flutter/material.dart';

import '../../colors/app_colors/app_colors.dart';

class LargeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const LargeButton({
    super.key,
    required this.title ,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 30,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              gradient: const LinearGradient(
                colors: [
                  AppColors.linearColor1,
                  AppColors.linearColor2,
                  AppColors.linearColor1,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
          child: Center(
              child:  Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
      ),
    );
  }
}
