class LocationModel {
  int id;
  String address;
  String phone;
  String delivery;

  LocationModel({this.id, this.address, this.phone, this.delivery});

  LocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    phone = json['phone'];
    delivery = json['delivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['delivery'] = this.delivery;
    return data;
  }
}
