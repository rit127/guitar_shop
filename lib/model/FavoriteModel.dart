class FavoriteModel {
  int id;
  String code;
  int price;
  String description;
  String productType;
  int brand;
  int category;
  List<Images> images;

  FavoriteModel(
      {this.id,
        this.code,
        this.price,
        this.description,
        this.productType,
        this.brand,
        this.category,
        this.images});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['code'] = this.code;
    data['price'] = this.price;
    data['description'] = this.description;
    data['product_type'] = this.productType;
    data['brand'] = this.brand;
    data['category'] = this.category;
    if (this.images != null) {
      data['images'] = this.images.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int id;
  String name;
  int width;
  int height;
  Formats formats;
  String url;

  Images({this.id, this.name, this.width, this.height, this.formats, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    width = json['width'];
    height = json['height'];
    formats =
    json['formats'] != null ? new Formats.fromJson(json['formats']) : null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['width'] = this.width;
    data['height'] = this.height;
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
  String hash;
  String ext;
  String mime;
  int width;
  int height;
  double size = 0;
  String path;
  String url;

  Thumbnail(
      {this.hash,
        this.ext,
        this.mime,
        this.width,
        this.height,
        this.size,
        this.path,
        this.url});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    width = json['width'];
    height = json['height'];
    if(json.containsKey('size')){
      size = double.parse(json['size'].toString());
    }

    path = json['path'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['width'] = this.width;
    data['height'] = this.height;
    data['size'] = this.size;
    data['path'] = this.path;
    data['url'] = this.url;
    return data;
  }
}
