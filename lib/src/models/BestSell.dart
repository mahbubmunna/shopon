class BestSell {
  bool success;
  List<Results> results;
  String message;

  BestSell({this.success, this.results, this.message});

  BestSell.fromJson(Map<String, dynamic> json) {
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
  int id;
  int categoryId;
  String photos;
  String featuredImg;
  String flashDealImg;
  int numOfSale;
  String name;
  String thumbnailImg;
  int unitPrice;
  int purchasePrice;
  int rating;

  Results(
      {this.id,
        this.categoryId,
        this.photos,
        this.featuredImg,
        this.flashDealImg,
        this.numOfSale,
        this.name,
        this.thumbnailImg,
        this.unitPrice,
        this.purchasePrice,
        this.rating});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    photos = json['photos'];
    featuredImg = json['featured_img'];
    flashDealImg = json['flash_deal_img'];
    numOfSale = json['num_of_sale'];
    name = json['name'];
    thumbnailImg = json['thumbnail_img'];
    unitPrice = json['unit_price'];
    purchasePrice = json['purchase_price'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['photos'] = this.photos;
    data['featured_img'] = this.featuredImg;
    data['flash_deal_img'] = this.flashDealImg;
    data['num_of_sale'] = this.numOfSale;
    data['name'] = this.name;
    data['thumbnail_img'] = this.thumbnailImg;
    data['unit_price'] = this.unitPrice;
    data['purchase_price'] = this.purchasePrice;
    data['rating'] = this.rating;
    return data;
  }
}