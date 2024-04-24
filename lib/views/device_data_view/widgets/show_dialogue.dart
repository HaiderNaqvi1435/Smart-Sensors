import 'package:smart_sensors/models/device_data_model/device_data_model.dart';
import 'package:smart_sensors/res/colors/app_colors/app_colors.dart';
import 'package:flutter/material.dart';

void showDeviceData(BuildContext context, DeviceDataModel dataModel) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppColors.blackColor,
        titleTextStyle: const TextStyle(color: AppColors.whiteColor),
        title: Text(
          dataModel.deviceId!,
        ),
        content: Text(
          dataModel.characteristic.toString(),
          style: const TextStyle(color: AppColors.whiteColor),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Close',
              style: TextStyle(color: AppColors.whiteColor),
            ),
          ),
        ],
      );
    },
  );
}
