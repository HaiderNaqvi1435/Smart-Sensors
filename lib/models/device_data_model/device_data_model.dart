class DeviceDataModel {
  String? deviceId;
  String? deviceName;
  String? serviceId;
  String? characteristicId;
  String? userId;
  List<int>? characteristic;

  DeviceDataModel(
      {this.deviceId,
      this.deviceName,
      this.serviceId,
      this.characteristic,
      this.characteristicId,
      this.userId,});

  DeviceDataModel.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    deviceName = json['deviceName'];
    serviceId = json['serviceId'];
    characteristicId = json['characteristicId'];
    userId = json['userId'];
    characteristic = json['characteristic'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = deviceId;
    data['deviceName'] = deviceName;
    data['userId'] = userId;
    data['characteristicId'] = characteristicId;
    data['serviceId'] = serviceId;
    data['characteristic'] = characteristic;
    return data;
  }
}
