import 'package:smart_sensors/services/firebase_services/auth_services/auth_services.dart';
import 'package:smart_sensors/services/firebase_services/firestore_services/firestore_services.dart';
import 'package:get/get.dart';

import '../../../models/device_data_model/device_data_model.dart';

class FirestoreController extends GetxController {
  FireStoreServices fireStoreServices = FireStoreServices();
  AuthServices authServices = AuthServices();
  RxList<DeviceDataModel> datalist = <DeviceDataModel>[].obs;
  FirestoreController() {
    showData();
  }
  void showData() async {
    datalist.clear();
    datalist.addAll(await fireStoreServices.getData());
  }

  void logout() async {
    await authServices.signOut();
  }
}
