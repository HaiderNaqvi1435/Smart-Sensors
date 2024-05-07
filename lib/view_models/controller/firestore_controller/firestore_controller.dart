import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../models/device_data_model/device_data_model.dart';
import '../../../utils/utils.dart';

class FirestoreController extends GetxController {
  RxList<DeviceDataModel> dataList = <DeviceDataModel>[].obs;
  @override
  void onInit() async {
    dataList.value = await getData();
    super.onInit();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final RxBool isLoading = false.obs;
  // Store service UUID and characteristics in Firestore
  Future<void> storeData(DeviceDataModel deviceData) async {
    try {
      await _firestore
          .collection("device_data")
          .doc(deviceData.deviceId)
          .set(deviceData.toJson());
      dataList.value = await getData();
    } catch (e) {
      if (kDebugMode) {
        Utils.toastMessage("Error while storing data!");

        print('Error storing data: $e');
      }
    }
  }

  Future<List<DeviceDataModel>> getData() async {
    List<DeviceDataModel> result = <DeviceDataModel>[];
    try {
      isLoading(true);
      await _firestore
          .collection("device_data")
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        result = List.generate(value.size,
                (index) => DeviceDataModel.fromJson(value.docs[index].data()))
            .toList();

        if (kDebugMode) {
          print(result);
        }
      });
      isLoading(false);
    } catch (e) {
      isLoading(false);

      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
    return result;
  }

  testfirestore() async {
    DeviceDataModel data = DeviceDataModel(
      characteristic: [
        1,
        2,
        3,
        4,
        5,
        6,
        7,
        88,
      ],
      characteristicId: "dasdsa",
      deviceId: "3458877",
      serviceId: "dasdsa",
      userId: FirebaseAuth.instance.currentUser!.uid,
    );
    await storeData(data);
  }
}
