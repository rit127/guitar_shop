class Customer {
  int id;
  String name;
  String profile;
  String phone;
  String point;
  Customer({this.id, this.name, this.profile, this.phone, this.point});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    profile = json['profile'];
    phone = json['phone'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['profile'] = this.profile;
    data['phone'] = this.phone;
    data['point'] = this.point;
    return data;
  }
}
