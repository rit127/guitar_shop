class CategoryMenu {
  int id;
  String name;
  IconImage iconImage;

  CategoryMenu({this.id, this.name, this.iconImage});

  CategoryMenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    iconImage = json['icon'] != null
        ? new IconImage.fromJson(json['icon'])
        : null;
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
