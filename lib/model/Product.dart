import 'package:guitarfashion/repository/CategoryRepository.dart';

class Product {
  int id;
  String title;
  String code;
  int price;
  String description;
  String productType;
  Brand brand;
  Brand category;
  List<ProductImage> image;

  Product(
      {this.id,
      this.title,
      this.code,
      this.price,
      this.description,
      this.productType,
      this.brand,
      this.category,
      this.image});

  Product.fromJson(Map<String, dynamic> json) {
    CategoryRepository cateRepo = CategoryRepository();

    id = json['id'];
    title = json['title'];
    code = json['code'];
    price = json['price'];
    description = json['description'];
    productType = json['product_type'];
//    brand = json['brand'] != null ? new Brand.fromJson(json['brand']) : null;
    if (json['category'] is int) {
//      category = new Brand(
////        id: myBrand.id,
////        name: myBrand.name,
////        icon: myBrand.icon,
////      );
    } else {
      category =
      json['category'] != null ? new Brand.fromJson(json['category']) : null;
    }

    if (json['image'] != null) {
      image = new List<ProductImage>();
      json['image'].forEach((v) {
        image.add(new ProductImage.fromJson(v));
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
    if (this.brand != null) {
      data['brand'] = this.brand.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.toJson();
    }
    if (this.image != null) {
      data['image'] = this.image.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brand {
  int id;
  String name;
  String icon;

  Brand({this.id, this.name, this.icon});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class ProductImage {
  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  Formats formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;

  ProductImage(
      {this.id,
      this.name,
      this.alternativeText,
      this.caption,
      this.width,
      this.height,
      this.formats,
      this.hash,
      this.ext,
      this.mime,
      this.size,
      this.url});

  ProductImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
    formats =
        json['formats'] != null ? new Formats.fromJson(json['formats']) : null;
    hash = json['hash'];
    ext = json['ext'];
    mime = json['mime'];
    size = json['size'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['alternativeText'] = this.alternativeText;
    data['caption'] = this.caption;
    data['width'] = this.width;
    data['height'] = this.height;
    if (this.formats != null) {
      data['formats'] = this.formats.toJson();
    }
    data['hash'] = this.hash;
    data['ext'] = this.ext;
    data['mime'] = this.mime;
    data['size'] = this.size;
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
