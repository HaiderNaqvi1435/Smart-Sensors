import 'package:smart_sensors/res/app_constants/app_constants.dart';
import 'package:smart_sensors/res/components/default_text/default_text.dart';
import 'package:smart_sensors/res/routes/routes_name.dart';
import 'package:smart_sensors/view_models/login_view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/components/have_account_widget/have_account_widget.dart';
import '../../res/components/large_button/large_button.dart';
import '../../res/components/textfield_widget/textfield_widget.dart';
import '../../res/components/title_text_widget/title_text_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginVM = Get.put(LoginViewModel());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstants.verticalPadding,
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleTextWidget(
                title: "Login",
              ),
              const SizedBox(height: 40),
              TextFieldWidget(
                controller: loginVM.emailController.value,
                focusNode: loginVM.emailFocusNode.value,
                hintText: "Email",
                prefixIcon: Icons.email_outlined,
              ),
              TextFieldWidget(
                controller: loginVM.passwordController.value,
                focusNode: loginVM.passwordFocusNode.value,
                hintText: "Password",
                prefixIcon: Icons.lock,
                suffixIcon: loginVM.obscureText.value
                    ? Icons.visibility
                    : Icons.visibility_off_outlined,
                obscureText: loginVM.obscureText.value,
                onPressed: () {
                  loginVM.obscureText.value = !loginVM.obscureText.value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: loginVM.isChecked.value,
                        onChanged: (newValue) {
                          loginVM.isChecked.value = newValue!;
                        },
                      ),
                      const DefaultText(text: 'Remember me', fontSize: 9),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const DefaultText(
                        text: 'Forgot Password?', fontSize: 9),
                  ),
                ],
              ),
              LargeButton(
                title: "LOGIN",
                onPressed: () async{
                  loginVM.login();
                },
              ),
              HaveAccountWidget(
                isLoginPage: true,
                onPressed: () {
                  Get.offAndToNamed(RouteName.signUpView);
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
