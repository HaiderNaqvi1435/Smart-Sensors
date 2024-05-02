import 'dart:async';

import 'package:smart_sensors/res/colors/app_colors/app_colors.dart';
import 'package:smart_sensors/view_models/controller/bluetooth_controller/bluetooth_controller.dart';
import 'package:smart_sensors/view_models/controller/firestore_controller/firestore_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/components/available_device_container/available_device_container.dart';
import '../../res/components/device_button/device_button.dart';
import '../../res/components/custom_divider/custom_divider.dart';
import '../../res/components/default_text/default_text.dart';
import '../../res/routes/routes_name.dart';
import '../../services/permission_services/permission_services.dart';
import '../../view_models/controller/auth__controller/auth__controller.dart';
import 'widgets/data_table_widget.dart';

class MyDevicesView extends StatefulWidget {
  const MyDevicesView({super.key});

  @override
  State<MyDevicesView> createState() => _MyDevicesViewState();
}

class _MyDevicesViewState extends State<MyDevicesView> {
  FirestoreController firestoreController = Get.put(FirestoreController());
  final PermissionServices permissionServices = PermissionServices();
  final AuthController authController = Get.put(AuthController());
  final btc = Get.put(BluetoothController());
  late final Timer timer;

  @override
  void initState() {
    super.initState();
    // Always initialize the timer.
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (btc.connecteddevice != null) {
        btc.getCharacteristics(btc.connecteddevice!).then((value) {
          firestoreController.showData();
        });
      }
    });

    permissionServices.getPermissions();
  }

  @override
  void dispose() {
    // Since timer is always initialized, it's safe to cancel it here.
    timer.cancel();
    super.dispose();
  }

  // List<String> deviceId = [
  //   "001",
  //   "002",
  // ];
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          titleTextStyle: const TextStyle(color: AppColors.whiteColor),
          title: const Text('Devices'),
          backgroundColor: Colors.transparent,
          bottom: const CustomDivider(),
          actions: [
            IconButton(
                onPressed: () async {
                  await authController.signOut();
                },
                icon: const Icon(Icons.logout)),
            // IconButton(
            //     onPressed: () async {
            //       firestoreController.testfirestore();
            //     },
            //     icon: const Icon(Icons.add)),
          ],
        ),
        body: firestoreController.datalist.isNotEmpty
            ? Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const AvailableDeviceContainner(),
                      const SizedBox(height: 20),
                      DataTableWidget(
                        deviceList: firestoreController.datalist,
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: FutureBuilder<void>(
                  future: Future.delayed(
                      const Duration(seconds: 2)), // Simulate a 2-second delay
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(
                        color: AppColors.linearColor1,
                      ); // Show progress indicator
                    } else {
                      return const DefaultText(text: 'No Device Available');
                    }
                  },
                ),
              ),
        bottomSheet: DeviceButton(
          title: "Add Device",
          icon: const Icon(
            Icons.bluetooth,
            size: 10,
            color: AppColors.blackColor,
          ),
          onPressed: () {
            Get.toNamed(RouteName.scanView);
          },
        ),
      );
    });
  }
}
