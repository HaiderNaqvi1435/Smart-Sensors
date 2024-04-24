import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_sensors/models/device_data_model/device_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Store service UUID and characteristics in Firestore
  Future<void> storeData(DeviceDataModel deviceData) async {
    try {
      await _firestore
          .collection("device_data")
          .doc(deviceData.deviceId)
          .set(deviceData.toJson())
          .then(
        (value) {
          print('Data stored successfully for device ');
        },
      );
    } catch (e) {
      print('Error storing data: $e');
    }
  }

  Future<List<DeviceDataModel>> getData() async {
    List<DeviceDataModel> result = <DeviceDataModel>[];
    try {
      await _firestore
          .collection("device_data")
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        result = List.generate(value.size,
                (index) => DeviceDataModel.fromJson(value.docs[index].data()))
            .toList();

        print(result);
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
    return result;
  }

  Future<DeviceDataModel?> getDeviceData(String deviceId) async {
    try {
      await _firestore
          .collection("device_data")
          .doc(deviceId)
          .get()
          .then((value) {
        if (value.exists) {
          return DeviceDataModel.fromJson(value.data()!);
        } else {
          print('No data found for device $deviceId');
          return null;
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
    return null;
  }
}
