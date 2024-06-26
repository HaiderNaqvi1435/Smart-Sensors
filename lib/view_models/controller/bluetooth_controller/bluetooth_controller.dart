import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:smart_sensors/models/device_data_model/device_data_model.dart';
import 'package:smart_sensors/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smart_sensors/view_models/controller/firestore_controller/firestore_controller.dart';
import '../../../res/routes/routes_name.dart';
import '../../../services/permission_services/permission_services.dart';
import '../auth__controller/auth__controller.dart';

class BluetoothController extends GetxController {
  final PermissionServices permissionServices = PermissionServices();
  final AuthController authController = Get.put(AuthController());
  final firestore = Get.put(FirestoreController());
  BluetoothDevice? connectedDevice;
  RxList<ScanResult> scanResults = <ScanResult>[].obs;

  void initBluetooth() async {
    try {
      await permissionServices.getPermissions();
      firestore.dataList.value = await firestore.getData();
    } catch (e) {
      print('Error initializing Bluetooth: $e');
    }
  }

  Future<void> startBluetoothScan() async {
    if (await Permission.bluetoothScan.isGranted && Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
      var subscription = FlutterBluePlus.adapterState
          .listen((BluetoothAdapterState state) async {
        if (kDebugMode) {
          print(state);
        }
        if (state == BluetoothAdapterState.on) {
          await startScan();
        }
      });
      FlutterBluePlus.cancelWhenScanComplete(subscription);
    }
  }

  Future<void> startScan() async {
    if (kDebugMode) {
      print("startScan complete");
    }
    try {
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10));
      FlutterBluePlus.onScanResults.listen((results) {
        if (kDebugMode) {
          print(results);
        }
        scanResults.clear();
        if (results.isNotEmpty) {
          scanResults.addAll(results);
          if (kDebugMode) {
            print('Devices found!');
          }
        } else {
          if (kDebugMode) {
            print("No device found!");
          }
        }
      }, onError: (e) => print(e));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<BluetoothDevice?> connectToDevice(BluetoothDevice device) async {
    if (kDebugMode) {
      print(device);
    }
    try {
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
        await getCharacteristics(device).then((value) {
          return Get.toNamed(RouteName.myDevicesView);
        });

        return device;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Failed to connect to device: $e");
      }
      Utils.toastMessage("Failed to connect!");
    }
    return null;
  }

  Future<void> getCharacteristics(BluetoothDevice device) async {
    try {
      List<BluetoothService> services = await device.discoverServices();
      for (var service in services) {
        debugPrintServiceUUID(service);
        await readServiceCharacteristics(service, device);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting characteristics: $e');
      }
    }
  }

  void debugPrintServiceUUID(BluetoothService service) {
    if (kDebugMode) {
      print('Service UUID: ${service.uuid}');
    }
  }

  Future<void> readServiceCharacteristics(
      BluetoothService service, BluetoothDevice device) async {
    for (var characteristic in service.characteristics) {
      debugPrintCharacteristicUUID(characteristic);
      var characteristicValue = await characteristic.read();
      debugPrintCharacteristicValue(characteristicValue);
      await storeCharacteristicData(
          characteristic, service, device, characteristicValue);
    }
  }

  void debugPrintCharacteristicUUID(BluetoothCharacteristic characteristic) {
    if (kDebugMode) {
      print('Characteristic UUID: ${characteristic.uuid}');
    }
  }

  void debugPrintCharacteristicValue(List<int> value) {
    if (kDebugMode) {
      print('Characteristic Value: $value');
    }
  }

  Future<void> storeCharacteristicData(BluetoothCharacteristic characteristic,
      BluetoothService service, BluetoothDevice device, List<int> value) async {
    DeviceDataModel deviceDataModel = DeviceDataModel(
      characteristic: value,
      deviceId: device.remoteId.toString(),
      deviceName: device.platformName,
      characteristicId: characteristic.uuid.toString(),
      serviceId: service.uuid.toString(),
      userId: FirebaseAuth.instance.currentUser!.uid,
    );

    await firestore
        .storeData(deviceDataModel)
        .then((value) => print("Data uploading successfully"));
  }
}
