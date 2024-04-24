import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_sensors/models/user_data_model/user_data_model.dart';
import 'package:smart_sensors/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../res/routes/routes_name.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> signUp(
      String email, String password, UserDataModel userDataModel) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await _firestore
            .collection("user_data")
            .doc(value.user!.uid)
            .set(userDataModel.toJson())
            .then((value) {
          print("Sign up successfully");
          Get.offAndToNamed(RouteName.loginView);
        });
      });
    } catch (e) {
      print('Error signing up: $e');
      Utils.toastMessage("Something went wrong!");
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.offAndToNamed(RouteName.myDevicesView);
      });
    } catch (e) {
      Utils.toastMessage("Something went wrong!");
      print('Error signing in: $e');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut().then((value) {
      Get.offAndToNamed(RouteName.loginView);
      Utils.toastMessage("Signing out");
      print("Signing out");
    });
  }
}
