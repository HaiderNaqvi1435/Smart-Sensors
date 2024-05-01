import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_sensors/res/components/large_button/large_button.dart';
import 'package:smart_sensors/res/components/textfield_widget/textfield_widget.dart';
import 'package:smart_sensors/utils/utils.dart';

import '../../res/colors/app_colors/app_colors.dart';
import '../../res/components/custom_divider/custom_divider.dart';
import '../../view_models/controller/auth__controller/auth__controller.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        titleTextStyle: const TextStyle(color: AppColors.whiteColor),
        backgroundColor: Colors.transparent,
        bottom: const CustomDivider(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter your email address to reset your password.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.whiteColor),
            ),
            const SizedBox(height: 20),
            TextFieldWidget(
              controller: authController.resetemailController.value,
              hintText: 'Email',
              prefixIcon: Icons.email,
            ),
            const SizedBox(height: 20),
            LargeButton(
                onPressed: () {
                  if (!authController.resetemailController.value.text.isEmail) {
                    Utils.toastMessage("Check your email");
                    // Call the AuthController to send the password reset email
                  } else {
                    authController.sendPasswordResetEmail(
                        authController.resetemailController.value.text);
                  }
                },
                title: "Reset")
          ],
        ),
      ),
    );
  }
}
