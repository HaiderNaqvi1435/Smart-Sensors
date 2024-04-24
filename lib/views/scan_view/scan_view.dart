import 'package:smart_sensors/res/components/available_device_container/available_device_container.dart';
import 'package:smart_sensors/res/components/device_button/device_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_sensors/view_models/controller/bluetooth_controller/bluetooth_controller.dart';

import '../../res/colors/app_colors/app_colors.dart';
import '../../res/components/custom_divider/custom_divider.dart';
import '../../res/components/default_text/default_text.dart';

class ScanView extends StatefulWidget {
  const ScanView({super.key});

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  final BluetoothController _bluetoothController =
      Get.put(BluetoothController());

  @override
  void initState() {
    super.initState();
    _bluetoothController.startBluetoothScan();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleTextStyle: const TextStyle(color: AppColors.whiteColor),
        title: const Text('Bluetooth'),
        backgroundColor: Colors.transparent,
        bottom: const CustomDivider(),
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: Obx(() {
        final scanResults = _bluetoothController.scanResults;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: Column(
            children: <Widget>[
              const AvailableDeviceContainner(),
              const SizedBox(height: 20),
              scanResults.isEmpty
                  ? const Center(
                      heightFactor: 20,
                      child: DefaultText(
                        text: 'No Device found!',
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: scanResults.length,
                        itemBuilder: (context, index) {
                          final result = scanResults[index];
                          return Column(
                            children: [
                              ListTile(
                                  iconColor: AppColors.whiteColor,
                                  onTap: () async {
                                    await _bluetoothController
                                        .connectToDevice(result.device);
                                  },
                                  leading: const Icon(
                                      Icons.perm_device_info_outlined),
                                  title: DefaultText(
                                      fontSize: 12,
                                      text:
                                          result.device.platformName.isNotEmpty
                                              ? result.device.platformName
                                              : "Unknown Device"),
                                  // subtitle: Text(result.device.remoteId.toString()),
                                  trailing: const Icon(Icons.info_outline)),
                              const CustomDivider(),
                            ],
                          );
                        },
                      ),
                    ),
            ],
          ),
        );
      }),
      bottomSheet: DeviceButton(
        title: "Scan Devices",
        onPressed: () async {
          await _bluetoothController.startBluetoothScan();
        },
      ),
    );
  }
}
