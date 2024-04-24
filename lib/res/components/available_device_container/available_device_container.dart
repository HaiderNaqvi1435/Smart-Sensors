import 'package:flutter/material.dart';

import '../../colors/app_colors/app_colors.dart';
import '../default_text/default_text.dart';

class AvailableDeviceContainner extends StatelessWidget {
  const AvailableDeviceContainner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.maxFinite,
      decoration:
          const BoxDecoration(color: AppColors.greyColor),
      child: const Padding(
          padding:
              EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          child: DefaultText(text: "Available Devices")),
    );
  }
}