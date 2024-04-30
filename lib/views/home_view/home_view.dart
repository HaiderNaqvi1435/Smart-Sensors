import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_sensors/view_models/controller/auth__controller/auth__controller.dart';
import 'package:smart_sensors/views/login_view/login_view.dart';
import 'package:smart_sensors/views/verify_email_view/verify_email_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final auth = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    // Widget screen = _adapterState == BluetoothAdapterState.on
    //     ? const ScanView()
    //     : BluetoothOffScreen(adapterState: _adapterState);
    return Obx(() {
      if (auth.user.value == null) {
        return const LoginView();
      } else {
        return const VerifyEmailView();
      }
    });
  }
}
