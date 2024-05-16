import 'dart:async';

import 'package:smart_sensors/res/colors/app_colors/app_colors.dart';
import 'package:smart_sensors/view_models/controller/bluetooth_controller/bluetooth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/components/available_device_container/available_device_container.dart';
import '../../res/components/device_button/device_button.dart';
import '../../res/components/custom_divider/custom_divider.dart';
import '../../res/components/default_text/default_text.dart';
import '../../res/routes/routes_name.dart';
import 'widgets/data_table_widget.dart';

class MyDevicesView extends StatefulWidget {
  const MyDevicesView({super.key});

  @override
  State<MyDevicesView> createState() => _MyDevicesViewState();
}

class _MyDevicesViewState extends State<MyDevicesView> {
  final BluetoothController btc = Get.put(BluetoothController());
  late final Timer timer;

  @override
  void initState() {
    btc.initBluetooth();
    timer = Timer.periodic(const Duration(seconds: 10), (_) async {
      if (btc.connectedDevice !=null ) {
        await btc.getCharacteristics(btc.connectedDevice!);
      } else{
        print ("Device is not connected");

      }
   
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

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
                  await btc.authController.signOut();
                },
                icon: const Icon(Icons.logout)),
            // IconButton(
            //     onPressed: () async {
            //       firestoreController.testfirestore();
            //     },
            //     icon: const Icon(Icons.add)),
          ],
        ),
        body: btc.firestore.isLoading.isTrue
            ? const Center(
                child: CircularProgressIndicator(
                  color: AppColors.linearColor1,
                ),
              )
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: btc.firestore.dataList.isNotEmpty
                    ? SingleChildScrollView(
                        child: Column(
                        children: [
                          const AvailableDeviceContainner(),
                          const SizedBox(height: 20),
                          DataTableWidget(
                            deviceList: btc.firestore.dataList,
                          ),
                        ],
                      ))
                    : const Center(
                        child: DefaultText(text: 'No Device Available'),
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
