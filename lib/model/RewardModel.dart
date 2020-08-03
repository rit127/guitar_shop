class RewardModel {
  int id;
  int point;
  Product product;

  RewardModel({this.id, this.point, this.product});

  RewardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    point = json['point'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['point'] = this.point;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    return data;
  }
}

class Product {
  int id;
  String title;
  String code;
  int price;
  String description;
  String productType;
  int brand;
  int category;
  List<Images> images;

  Product(
      {this.id,
        this.title,
        this.code,
        this.price,
        this.description,
        this.productType,
        this.brand,
        this.category,
        this.images});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    price = json['price'];
    description = json['description'];
    productType = json['product_type'];
    brand = json['brand'];
    category = json['category'];
    if (json['image'] != null) {
      images = new List<Images>();
      json['image'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['code'] = this.code;
    data['price'] = this.price;
    data['description'] = this.description;
    data['product_type'] = this.productType;
    data['brand'] = this.brand;
    data['category'] = this.category;
    if (this.images != null) {
      data['image'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int id;
  Formats formats;
  String url;

  Images({this.id, this.formats, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formats =
    json['formats'] != null ? new Formats.fromJson(json['formats']) : null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.formats != null) {
      data['formats'] = this.formats.toJson();
    }
    data['url'] = this.url;
    return data;
  }
}

class Formats {
  Large large;
  Large medium;
  Large small;

  Formats({this.large, this.medium, this.small});

  Formats.fromJson(Map<String, dynamic> json) {
    large = json['large'] != null ? new Large.fromJson(json['large']) : null;
    medium = json['medium'] != null ? new Large.fromJson(json['medium']) : null;
    small = json['small'] != null ? new Large.fromJson(json['small']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.large != null) {
      data['large'] = this.large.toJson();
    }
    if (this.medium != null) {
      data['medium'] = this.medium.toJson();
    }
    if (this.small != null) {
      data['small'] = this.small.toJson();
    }
    return data;
  }
}

class Large {
  String url;

  Large({this.url});

  Large.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
