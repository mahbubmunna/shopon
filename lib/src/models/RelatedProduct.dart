class RelatedProduct {
  bool success;
  List<Results> results;
  String message;

  RelatedProduct({this.success, this.results, this.message});

  RelatedProduct.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Results {
  var id;
  var name;
  var thumbnailImg;
  var unitPrice;
  var purchasePrice;
  var rating;

  Results(
      {this.id,
      this.name,
      this.thumbnailImg,
      this.unitPrice,
      this.purchasePrice,
      this.rating});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumbnailImg = json['thumbnail_img'];
    unitPrice = json['unit_price'];
    purchasePrice = json['purchase_price'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumbnail_img'] = this.thumbnailImg;
    data['unit_price'] = this.unitPrice;
    data['purchase_price'] = this.purchasePrice;
    data['rating'] = this.rating;
    return data;
  }
}
