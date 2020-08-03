import '../configs/strings.dart';

class Carts {
  bool success;
  Results results;
  String message;

  Carts({this.success, this.results, this.message});

  Carts.fromJson(Map<String, dynamic> json) {
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
  List<Cart> cart;

  Results({this.cart});

  Results.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = new List<Cart>();
      json['cart'].forEach((v) {
        cart.add(new Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  var id;
  var name;
  var images;
  var flashDealDiscount;
  var productDiscount;
  var choice1;
  var choice2;
  var quantity;
  var unitPrice;
  var totalPrice;
  var tax;
  var shipping;

  Cart(
      {this.id,
      this.name,
      this.images,
      this.flashDealDiscount,
      this.productDiscount,
      this.choice1,
      this.choice2,
      this.quantity,
      this.unitPrice,
      this.totalPrice,
      this.tax,
      this.shipping});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    images = /*List.from(json['photos'])*/ json["images"].toString();
    print('List of images $images');
    print('List of images ${images[0]}');
    flashDealDiscount = json['flash_deal_discount'];
    productDiscount = json['product_discount'];
    choice1 = json['choice_1'];
    choice2 = json['choice_2'];
    quantity = json['quantity'];
    unitPrice = json['unitPrice'];
    totalPrice = json['total_price'];
    tax = json['tax'];
    shipping = json['shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flash_deal_discount'] = this.flashDealDiscount;
    data['product_discount'] = this.productDiscount;
    data['choice_1'] = this.choice1;
    data['choice_2'] = this.choice2;
    data['quantity'] = this.quantity;
    data['unit_price'] = this.unitPrice;
    data['total_price'] = this.totalPrice;
    data['tax'] = this.tax;
    data['shipping'] = this.shipping;
    return data;
  }
}
