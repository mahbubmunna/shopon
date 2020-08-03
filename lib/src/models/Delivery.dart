class Delivery {
  String paymentOption;
  ShippingInfo shippingInfo;
  List<Cart> cart= new List<Cart>();

  Delivery({this.paymentOption, this.shippingInfo, this.cart});

/*  Delivery.fromJson(Map<String, dynamic> json) {
    paymentOption = json['payment_option'];
    shippingInfo = json['shipping_info'] != null
        ? new ShippingInfo.fromJson(json['shipping_info'])
        : null;
    if (json['cart'] != null) {
      cart = new List<Cart>();
      json['cart'].forEach((v) {
        cart.add(new Cart.fromJson(v));
      });
    }
  }*/

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_option'] = this.paymentOption;
    if (this.shippingInfo != null) {
      data['shipping_info'] = this.shippingInfo.toJson();
    }
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingInfo {
  String name;
  String email;
  String address;
  String country;
  String city;
  String postalCode;
  String phone;

  ShippingInfo(
      {this.name,
      this.email,
      this.address,
      this.country,
      this.city,
      this.postalCode,
      this.phone});

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    address = json['address'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['country'] = this.country;
    data['city'] = this.city;
    data['postal_code'] = this.postalCode;
    data['phone'] = this.phone;
    return data;
  }
}

class Cart {
  var id;
  var name;
  var images;
  var flashDealDiscount;
  var productDiscount;
  var quantity;
  var price;
  var tax;

  Cart(
      {this.id,
      this.name,
      this.images,
      this.flashDealDiscount,
      this.productDiscount,
      this.quantity,
      this.price,
      this.tax});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    images = json['images'];
    flashDealDiscount = json['flashDealDiscount'];
    productDiscount = json['productDiscount'];
    quantity = json['quantity'];
    price = json['price'];
    tax = json['tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['images'] = this.images;
    data['flashDealDiscount'] = this.flashDealDiscount;
    data['productDiscount'] = this.productDiscount;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['tax'] = this.tax;
    return data;
  }
}
