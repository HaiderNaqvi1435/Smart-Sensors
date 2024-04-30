import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_sensors/models/user_data_model/user_data_model.dart';
import 'package:smart_sensors/res/routes/routes_name.dart';

import '../../../utils/utils.dart';

class AuthController extends GetxController {
// final UserCredential user ;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(_auth.authStateChanges());
  }

  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  RxBool obscureText = true.obs;
  RxBool isChecked = false.obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  RxBool loading = false.obs;
  Rxn<User> user = Rxn<User>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void createUser(
      String email, String password, UserDataModel userDataModel) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        await _firestore
            .collection("user_data")
            .doc(userCredential.user!.uid)
            .set(userDataModel.toJson())
            .then((value) {
          if (kDebugMode) {
            print("Sign up successfully");
          }
          Utils.toastMessage("Signup successfully!");
          Get.offAllNamed(RouteName.verifyEmailView);
        });

        // Update the UI to show a message to check their email
      }
    } catch (e) {
      Utils.toastMessage("Something went wrong!");

      // Handle errors
    }
  }

  void loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (!userCredential.user!.emailVerified) {
        if (kDebugMode) {
          print('email${!userCredential.user!.emailVerified}');
        }
        Get.offNamed(RouteName.verifyEmailView);

        // Update the UI to prompt the user to verify their email
      } else {
        if (kDebugMode) {
          print('email${userCredential.user!.emailVerified}');
        }

        Get.offNamed(RouteName.homeView);
        Utils.toastMessage("Login successfully!");

        // Navigate to the home screen
      }
    } catch (e) {
      Utils.toastMessage("Something went wrong!");

      // Handle errors
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed(RouteName.loginView);
    Utils.toastMessage("Signed out");
  }

  void resendVerificationEmail() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      // Update the UI to show a message that the verification email has been resent
    }
  }

  
  // AuthServices authServices = AuthServices();
}
