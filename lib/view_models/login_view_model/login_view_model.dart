import 'package:smart_sensors/services/firebase_services/auth_services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginViewModel extends GetxController {
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;

  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  RxBool loading = false.obs;

  AuthServices authServices = AuthServices();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> user = Rxn<User>();
  RxBool obscureText = true.obs;
  RxBool isChecked = false.obs;
  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  login() async {
    await authServices.signIn(
        emailController.value.text, passwordController.value.text);
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   user.bindStream(_auth.authStateChanges());
  // }
}
