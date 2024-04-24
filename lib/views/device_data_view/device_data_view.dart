import 'package:smart_sensors/res/colors/app_colors/app_colors.dart';
import 'package:smart_sensors/res/components/custom_divider/custom_divider.dart';
import 'package:smart_sensors/views/device_data_view/widgets/show_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeviceDataView extends StatefulWidget {
  const DeviceDataView({super.key});
  @override
  State<DeviceDataView> createState() => _DeviceDataViewState();
}

class _DeviceDataViewState extends State<DeviceDataView> {
  final dataModel = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        titleTextStyle: const TextStyle(color: AppColors.whiteColor),
        // title: const Text('Devices'),
        backgroundColor: Colors.transparent,

        // bottom: const CustomDivider(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  showDeviceData(context, dataModel);
                },
                icon: Icon(
                  Icons.volume_up_sharp,
                  size: MediaQuery.of(context).size.height / 6,
                  color: AppColors.greyColor,
                )),
            const CustomDivider(),
            IconButton(
                onPressed: () {
                  showDeviceData(context, dataModel);
                },
                icon: Icon(
                  Icons.device_thermostat,
                  size: MediaQuery.of(context).size.height / 6,
                  color: AppColors.greyColor,
                )),
            const CustomDivider(),
            IconButton(
                onPressed: () {
                  showDeviceData(context, dataModel);
                },
                icon: Icon(
                  Icons.air_outlined,
                  size: MediaQuery.of(context).size.height / 6,
                  color: AppColors.greyColor,
                )),
          ],
        ),
      ),
    );
  }
}
// Center(
//               child: ListTile(
//             title: Text(
//               dataModel.deviceId!,
//               style: const TextStyle(
//                   color: AppColors.whiteColor, fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(
//               dataModel.characteristic.toString(),
//               style: const TextStyle(
//                 color: AppColors.whiteColor,
//               ),
//             ),
//           )),
