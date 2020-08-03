class UserModel {
  int id;
  String username;
  String email;
  String provider;
  int customer;

  UserModel(
      {this.id,
        this.username,
        this.email,
        this.provider,
        this.customer});

  UserModel.fromJson(Map<String, dynamic> json, String type) {
    if(type == 'register') {
      id = json['id'];
      username = json['username'];
      email = json['email'];
      provider = json['provider'];
      customer = json['customer'];
    }else {
      id = json['id'];
      username = json['username'];
      email = json['email'];
      provider = json['provider'];
      customer = json['customer'] != null ? json['customer']['id'] : null;
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['provider'] = this.provider;
    data['customer'] = this.customer;
    return data;
  }
}
