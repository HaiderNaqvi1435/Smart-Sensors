import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:smart_sensors/models/user_data_model/user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/routes/routes_name.dart';
import '../../utils/utils.dart';

class SignUpViewModel extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool obscureText = true.obs;
  RxBool obscureText1 = true.obs;
  RxBool isloading = false.obs;

  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final phoneController = TextEditingController().obs;
  final houseNoController = TextEditingController().obs;
  final streetNoController = TextEditingController().obs;
  final cityController = TextEditingController().obs;
  final stateController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmpasswordController = TextEditingController().obs;

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

    createUser(emailController.value.text, passwordController.value.text,
        userDataModel);
  }

  void createUser(
      String email, String password, UserDataModel userDataModel) async {
    try {
      isloading(true);
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        await _firestore
            .collection("user_data")
            .doc(user.uid)
            .set(userDataModel.toJson());
        if (kDebugMode) {
          print("Sign up successfully");
        }
        Utils.toastMessage("Signup successfully!");
        Get.offNamed(RouteName.verifyEmailView);
      } else {
        // Handle the case when the user is null
        Utils.toastMessage("User creation failed. Please try again.");
      }
      isloading(false);
    } on FirebaseAuthException catch (e) {
      isloading(false);

      if (kDebugMode) {
        print("Error message: ${e.message}");
      }
      Utils.toastMessage(e.message ?? "Something went wrong. Try again!");
    } catch (e) {
      isloading(false);

      if (kDebugMode) {
        print("Error message: $e");
      }
      Utils.toastMessage("An unexpected error occurred. Try again!");
    }
  }
}
