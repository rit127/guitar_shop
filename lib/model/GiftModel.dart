class GiftModel {
  int id;
  String title;
  String code;
  int price;
  String description;
  String productType;
  List<Images> images;
  List<Rewards> rewards;

  GiftModel(
      {this.id,
        this.title,
        this.code,
        this.price,
        this.description,
        this.productType,
        this.images,
        this.rewards});

  GiftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    price = json['price'];
    description = json['description'];
    productType = json['product_type'];
    if (json['image'] != null) {
      images = new List<Images>();
      json['image'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    if (json['rewards'] != null) {
      rewards = new List<Rewards>();
      json['rewards'].forEach((v) {
        rewards.add(new Rewards.fromJson(v));
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
    if (this.images != null) {
      data['image'] = this.images.map((v) => v.toJson()).toList();
    }
    if (this.rewards != null) {
      data['rewards'] = this.rewards.map((v) => v.toJson()).toList();
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
  Thumbnail thumbnail;
  Thumbnail large;
  Thumbnail medium;
  Thumbnail small;

  Formats({this.thumbnail, this.large, this.medium, this.small});

  Formats.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'] != null
        ? new Thumbnail.fromJson(json['thumbnail'])
        : null;
    large =
    json['large'] != null ? new Thumbnail.fromJson(json['large']) : null;
    medium =
    json['medium'] != null ? new Thumbnail.fromJson(json['medium']) : null;
    small =
    json['small'] != null ? new Thumbnail.fromJson(json['small']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail.toJson();
    }
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

class Thumbnail {
  String url;

  Thumbnail({this.url});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}

class Rewards {
  int id;
  int point;
  int product;

  Rewards({this.id, this.point, this.product});

  Rewards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    point = json['point'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['point'] = this.point;
    data['product'] = this.product;
    return data;
  }
}
