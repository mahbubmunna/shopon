class Shipped {
  bool success;
  Results results;
  String message;

  Shipped({this.success, this.results, this.message});

  Shipped.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    results =
    json['results'] != null ? new Results.fromJson(json['results']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.results != null) {
      data['results'] = this.results.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Results {
  var currentPage;
  List<Data> data;
  var firstPageUrl;
  var from;
  var lastPage;
  var lastPageUrl;
  var nextPageUrl;
  var path;
  var perPage;
  var prevPageUrl;
  var to;
  var total;

  Results(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  Results.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  var id;
  var paymentType;
  var paymentStatus;
  var createdAt;
  List<OrderDetails> orderDetails;

  Data(
      {this.id,
        this.paymentType,
        this.paymentStatus,
        this.createdAt,
        this.orderDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    createdAt = json['created_at'];
    if (json['order_details'] != null) {
      orderDetails = new List<OrderDetails>();
      json['order_details'].forEach((v) {
        orderDetails.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    if (this.orderDetails != null) {
      data['order_details'] = this.orderDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  var id;
  var name;
  var categoryName;
  var subCategoryName;
  var subSubCategoryName;
  var brand;
  List<String> image;
  var thumbnailImg;
  var featuredImg;
  var colors;
  var price;
  var quantity;

  OrderDetails(
      {this.id,
        this.name,
        this.categoryName,
        this.subCategoryName,
        this.subSubCategoryName,
        this.brand,
        this.image,
        this.thumbnailImg,
        this.featuredImg,
        this.colors,
        this.price,
        this.quantity});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryName = json['category_name'];
    subCategoryName = json['sub_category_name'];
    subSubCategoryName = json['sub_sub_category_name'];
    brand = json['brand'];
    image = json['image'].cast<String>();
    thumbnailImg = json['thumbnail_img'];
    featuredImg = json['featured_img'];
    colors = json['colors'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_name'] = this.categoryName;
    data['sub_category_name'] = this.subCategoryName;
    data['sub_sub_category_name'] = this.subSubCategoryName;
    data['brand'] = this.brand;
    data['image'] = this.image;
    data['thumbnail_img'] = this.thumbnailImg;
    data['featured_img'] = this.featuredImg;
    data['colors'] = this.colors;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
