import 'package:smart_sensors/models/user_data_model/user_data_model.dart';
import 'package:smart_sensors/services/firebase_services/auth_services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  final authServices = AuthServices();
  RxBool obscureText = true.obs;
  RxBool obscureText1 = true.obs;

  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final houseNoController = TextEditingController().obs;
  final streetNoController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final stateController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final nameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final phoneFocusNode = FocusNode().obs;
  final houseNoFocusNode = FocusNode().obs;
  final streetNoFocusNode = FocusNode().obs;
  final cityFocusNode = FocusNode().obs;
  final stateFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final confirmPasswordFocusNode = FocusNode().obs;

  void signUp() async {
    Address address = Address(
      houseNo: houseNoController.value.text,
      streetNo: streetNoController.value.text,
      city: cityController.value.text,
      state: stateController.value.text,
    );
    UserDataModel userDataModel = UserDataModel(
      name: nameController.value.text,
      email: emailController.value.text,
      phone: phoneController.value.text,
      address: address,
    );

    await authServices.signUp(emailController.value.text,
        passwordController.value.text, userDataModel);
  }
}
