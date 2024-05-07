import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_sensors/utils/utils.dart';
import '../../res/app_constants/app_constants.dart';
import '../../res/components/have_account_widget/have_account_widget.dart';
import '../../res/components/large_button/large_button.dart';
import '../../res/components/textfield_widget/textfield_widget.dart';
import '../../res/components/title_text_widget/title_text_widget.dart';
import '../../res/routes/routes_name.dart';
import '../../view_models/sign_up_view_model/sign_up_view_model.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final signUpVM = Get.put(SignUpViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: AppConstants.verticalPadding,
            child: Obx(() {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TitleTextWidget(
                    title: "Create an Account",
                  ),
                  const SizedBox(height: 40),
                  TextFieldWidget(
                    controller: signUpVM.nameController.value,
                    focusNode: signUpVM.nameFocusNode.value,
                    hintText: "Name",
                    prefixIcon: Icons.person_outline,
                  ),
                  TextFieldWidget(
                    controller: signUpVM.emailController.value,
                    focusNode: signUpVM.emailFocusNode.value,
                    hintText: "Email",
                    prefixIcon: Icons.email_outlined,
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.phone,
                    controller: signUpVM.phoneController.value,
                    focusNode: signUpVM.phoneFocusNode.value,
                    hintText: "Phone Number",
                    prefixIcon: Icons.phone_outlined,
                  ),
                  TextFieldWidget(
                    controller: signUpVM.houseNoController.value,
                    focusNode: signUpVM.houseNoFocusNode.value,
                    hintText: "House no",
                    prefixIcon: Icons.home_outlined,
                  ),
                  TextFieldWidget(
                    controller: signUpVM.streetNoController.value,
                    focusNode: signUpVM.streetNoFocusNode.value,
                    hintText: "Street no",
                    prefixIcon: Icons.location_on_outlined,
                  ),
                  TextFieldWidget(
                    controller: signUpVM.cityController.value,
                    focusNode: signUpVM.cityFocusNode.value,
                    hintText: "City",
                    prefixIcon: Icons.location_city_outlined,
                  ),
                  TextFieldWidget(
                    controller: signUpVM.stateController.value,
                    focusNode: signUpVM.stateFocusNode.value,
                    hintText: "State",
                    prefixIcon: Icons.my_location,
                  ),
                  TextFieldWidget(
                    controller: signUpVM.passwordController.value,
                    focusNode: signUpVM.passwordFocusNode.value,
                    hintText: "Password",
                    prefixIcon: Icons.lock,
                    suffixIcon: signUpVM.obscureText.value
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                    obscureText: signUpVM.obscureText.value,
                    onPressed: () {
                      signUpVM.obscureText.value = !signUpVM.obscureText.value;
                    },
                  ),
                  TextFieldWidget(
                    controller: signUpVM.confirmpasswordController.value,
                    hintText: "Confirm Password",
                    prefixIcon: Icons.lock,
                    suffixIcon: signUpVM.obscureText1.value
                        ? Icons.visibility
                        : Icons.visibility_off_outlined,
                    obscureText: signUpVM.obscureText1.value,
                    onPressed: () {
                      signUpVM.obscureText1.value =
                          !signUpVM.obscureText1.value;
                    },
                  ),
                  const SizedBox(height: 30),
                  LargeButton(
                    isloading: signUpVM.isloading.value,
                    title: "SIGNUP",
                    onPressed: () async {
                      if (signUpVM.passwordController.value.text ==
                              signUpVM.confirmpasswordController.value.text &&
                          EmailValidator.validate(
                              signUpVM.emailController.value.text)) {
                        signUpVM.signUp();
                      } else {
                        if (signUpVM.passwordController.value.text !=
                            signUpVM.confirmpasswordController.value.text) {
                          Utils.toastMessage("Passwords do not match");
                        } else {
                          Utils.toastMessage("Invalid email address");
                        }
                      }
                    },
                  ),
                  HaveAccountWidget(
                    isLoginPage: false,
                    onPressed: () {
                      Get.offNamed(RouteName.loginView);
                    },
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
