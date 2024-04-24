import 'package:permission_handler/permission_handler.dart';

class PermissionServices {
  Future getPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();
    print(statuses[Permission.location]);
  }

  
}
