class CategoryMenu {
  int id;
  String name;
  IconImage iconImage;
  Category category;
  List<Categories> categories;
  CategoryMenu(
      {this.id, this.name, this.iconImage, this.category, this.categories});

  CategoryMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconImage =
        json['icon'] != null ? new IconImage.fromJson(json['icon']) : null;
    category = json['category'] != null
        ? json['category']['id'] != null ? new Category.fromJson(json['category'])
        : null : null;
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    if (this.iconImage != null) {
      data['image'] = this.iconImage.toJson();
    }
    return data;
  }
}

class IconImage {
  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  String url;

  IconImage(
      {this.id,
      this.name,
      this.alternativeText,
      this.caption,
      this.width,
      this.height,
      this.url});

  IconImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alternativeText = json['alternativeText'];
    caption = json['caption'];
    width = json['width'];
    height = json['height'];
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
    data['url'] = this.url;
    return data;
  }
}

class Category {
  int id;
  String name;
  int category;
  IconImage icon;

  Category(
      {this.id,
        this.name,
        this.category,
        this.icon});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    icon = json['icon'] != null ? new IconImage.fromJson(json['icon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    if (this.icon != null) {
      data['icon'] = this.icon.toJson();
    }
    return data;
  }
}

class Categories {
  int id;
  String name;
  int category;
  IconImage icon;

  Categories({this.id, this.name, this.category, this.icon});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    icon = json['icon'] != null ? IconImage.fromJson(json['icon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['icon'] = this.icon;
    return data;
  }
}