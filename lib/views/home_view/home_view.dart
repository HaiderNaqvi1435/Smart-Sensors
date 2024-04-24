import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_sensors/views/login_view/login_view.dart';

import '../../view_models/login_view_model/login_view_model.dart';
import '../my_devices_view/my_devices_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final loginVM = Get.put(LoginViewModel());
  @override
  Widget build(BuildContext context) {
    // Widget screen = _adapterState == BluetoothAdapterState.on
    //     ? const ScanView()
    //     : BluetoothOffScreen(adapterState: _adapterState);
    return Obx(() {
      if (loginVM.user.value == null) {
        return const LoginView();
      } else {
        return const MyDevicesView();
      }
    });
  }
}
