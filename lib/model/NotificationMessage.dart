class NotificationMessage {
  int id;
  String title;
  String reciever;
  String createdAt;
  String updatedAt;
  Icon icon;

  NotificationMessage(
      {this.id,
        this.title,
        this.reciever,
        this.createdAt,
        this.updatedAt,
        this.icon});

  NotificationMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    reciever = json['reciever'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    icon = json['icon'] != null ? new Icon.fromJson(json['icon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['reciever'] = this.reciever;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.icon != null) {
      data['icon'] = this.icon.toJson();
    }
    return data;
  }
}

class Icon {
  int id;
  Formats formats;
  String url;
  String createdAt;
  String updatedAt;

  Icon({this.id, this.formats, this.url, this.createdAt, this.updatedAt});

  Icon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formats =
    json['formats'] != null ? new Formats.fromJson(json['formats']) : null;
    url = json['url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.formats != null) {
      data['formats'] = this.formats.toJson();
    }
    data['url'] = this.url;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
