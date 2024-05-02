import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final resetemailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  RxBool obscureText = true.obs;
  RxBool isChecked = false.obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  RxBool isloading = false.obs;
  Rxn<User> user = Rxn<User>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void loginUser(String email, String password) async {
    try {
      isloading(true); // Start loading
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!userCredential.user!.emailVerified) {
        if (kDebugMode) {
          print('Email not verified');
        }
        Get.offNamed(RouteName.verifyEmailView);
      } else {
        if (kDebugMode) {
          print('Email verified');
        }
        Get.offNamed(RouteName.homeView);
        Utils.toastMessage("Login successfully!");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Utils.toastMessage("Something went wrong!");
    } finally {
      isloading(false); // Stop loading regardless of the outcome
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      Get.offNamed(RouteName.loginView);
      Utils.toastMessage("Signed out");
    } catch (e) {
      if (kDebugMode) {
        print("Sign out error: $e");
      }
      Utils.toastMessage("Failed to sign out. Please try again.");
    }
  }

  void resendVerificationEmail() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      // Update the UI to show a message that the verification email has been resent
    }
  }

  void sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Utils.toastMessage('A password reset link has been sent to your email.');
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Password reset error: ${e.message}");
      }
      Utils.toastMessage(e.message ??
          'An error occurred while sending the password reset link.');
    } catch (e) {
      if (kDebugMode) {
        print("Unknown error: $e");
      }
      Utils.toastMessage('An unexpected error occurred. Please try again.');
    }
  }
  // AuthServices authServices = AuthServices();
}
