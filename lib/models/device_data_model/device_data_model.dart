class DeviceDataModel {
  String? deviceId;
  String? serviceId;
  String? characteristicId;
  String? userId;
  List<int>? characteristic;

  DeviceDataModel(
      {this.deviceId,
      this.serviceId,
      this.characteristic,
      this.characteristicId,
      this.userId,});

  DeviceDataModel.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    serviceId = json['serviceId'];
    characteristicId = json['characteristicId'];
    userId = json['userId'];
    characteristic = json['characteristic'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceId'] = deviceId;
    data['userId'] = userId;
    data['characteristicId'] = characteristicId;
    data['serviceId'] = serviceId;
    data['characteristic'] = characteristic;
    return data;
  }
}
