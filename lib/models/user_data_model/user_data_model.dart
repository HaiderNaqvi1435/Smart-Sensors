class UserDataModel {
  String? name;
  String? email;
  String? phone;
  Address? address;

  UserDataModel({this.name, this.email, this.phone, this.address});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Address {
  String? houseNo;
  String? streetNo;
  String? city;
  String? state;

  Address({this.houseNo, this.streetNo, this.city, this.state});

  Address.fromJson(Map<String, dynamic> json) {
    houseNo = json['house_no'];
    streetNo = json['street_no'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['house_no'] = houseNo;
    data['street_no'] = streetNo;
    data['city'] = city;
    data['state'] = state;
    return data;
  }
}