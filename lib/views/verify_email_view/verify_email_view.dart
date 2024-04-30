import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:smart_sensors/res/components/device_button/device_button.dart';
import 'package:smart_sensors/res/routes/routes_name.dart';
import 'package:smart_sensors/views/my_devices_view/my_devices_view.dart';

import '../../res/colors/app_colors/app_colors.dart';
import '../../res/components/custom_divider/custom_divider.dart';
import '../../view_models/controller/auth__controller/auth__controller.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  final AuthController authController = Get.put(AuthController());
  final user = FirebaseAuth.instance.currentUser!;
  late Timer timer;
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      reloadUser();
    });
    // TODO: implement initState
    super.initState();
  }

  reloadUser() async {
    await user.reload();
  }

  @override
  void dispose() {
    timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FirebaseAuth.instance.currentUser!.emailVerified
        ? const MyDevicesView()
        : // Your home page widget
        Scaffold(
            appBar: AppBar(
              titleTextStyle: const TextStyle(color: AppColors.whiteColor),
              backgroundColor: Colors.transparent,
              bottom: const CustomDivider(),
              title: const Text('Verify Your Email'),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      textAlign: TextAlign.center,
                      'A verification email has been sent to your email. Please verify to continue.',
                      style: TextStyle(color: AppColors.whiteColor),
                    ),
                    const SizedBox(height: 20),
                    DeviceButton(
                      onPressed: () {
                        authController.resendVerificationEmail();
                      },
                      icon: const Icon(Icons.send,
                          size: 10, color: AppColors.blackColor),
                      title: "Resend Email",
                    ),
                    DeviceButton(
                      onPressed: () {
                        Get.offNamed(RouteName.signUpView);
                      },
                      icon: const Icon(Icons.login,
                          size: 10, color: AppColors.blackColor),
                      title: "Sign up",
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
