import 'dart:async';
import 'dart:io';
import 'package:smart_sensors/models/device_data_model/device_data_model.dart';
import 'package:smart_sensors/services/firebase_services/firestore_services/firestore_services.dart';
import 'package:smart_sensors/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../res/routes/routes_name.dart';

class BluetoothController extends GetxController {
  RxList<ScanResult> scanResults = <ScanResult>[].obs;
  // RxList<int> characteristics = <int>[].obs;
  Future<void> startBluetoothScan() async {
    if (await Permission.bluetoothScan.isGranted && Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
      var subscription = FlutterBluePlus.adapterState
          .listen((BluetoothAdapterState state) async {
        print(state);
        if (state == BluetoothAdapterState.on) {
          await startScan();
        }
      });
      FlutterBluePlus.cancelWhenScanComplete(subscription);
    }
  }

  Future<void> startScan() async {
    print("startScan complete");
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
      FlutterBluePlus.onScanResults.listen((results) {
        print(results);
        scanResults.clear();
        if (results.isNotEmpty) {
          scanResults.addAll(results);
          print('Devices found!');
        } else {
          print("No device found!");
        }
      }, onError: (e) => print(e));
    } catch (e) {
      print(e);
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    print(device);
    try {
      // Utils.toastMessage("Connecting to device ${device.remoteId}");
      await device.connect(timeout: const Duration(seconds: 10));
      BluetoothConnectionState connectionState =
          await device.connectionState.firstWhere(
        (state) => state == BluetoothConnectionState.connected,
        orElse: () {
          throw Exception('Failed to connect to device');
        },
      );
      if (connectionState == BluetoothConnectionState.connected) {
        Utils.toastMessage("Device is connected");
        Get.toNamed(RouteName.myDevicesView, arguments: [device]);
        await getCharacteristics(device);
      }
    } catch (e) {
      print("Failed to connect to device: $e");
      Utils.toastMessage("Failed to connect!");
    }
  }

  Future getCharacteristics(BluetoothDevice device) async {
    try {
      FireStoreServices firebaseServices = FireStoreServices();
      DeviceDataModel deviceDataModel = DeviceDataModel();
      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        print('Service UUID: ${service.uuid}');
        for (BluetoothCharacteristic characteristic
            in service.characteristics) {
          print('Characteristic UUID: ${characteristic.uuid}');
          await characteristic.read().then((value) async {
            deviceDataModel.characteristic!.addAll(value);
            deviceDataModel.deviceId = device.remoteId.toString();
            deviceDataModel.characteristicId = characteristic.uuid.toString();
            deviceDataModel.serviceId = service.uuid.toString();
            deviceDataModel.userId =
                FirebaseAuth.instance.currentUser!.uid.toString();

            print('Characteristic Value: $value');
          }).then((value) async {
            await firebaseServices.storeData(deviceDataModel);
          });
        }
      }
    } catch (e) {
      print('Error getting characteristics: $e');
    }
  }
}
