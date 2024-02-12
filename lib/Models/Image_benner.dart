// ignore: file_names
class Bannerimage {
  int? id;
  String? banner;
  String? createdAt;
  String? updatedAt;

  Bannerimage({this.id, this.banner, this.createdAt, this.updatedAt});

  Bannerimage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
class Latestproduct {
  int? id;
  String? latestProduct;
  String? createdAt;
  String? updatedAt;

  Latestproduct({this.id, this.latestProduct, this.createdAt, this.updatedAt});

  Latestproduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latestProduct = json['latest_product'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latest_product'] = this.latestProduct;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
