class PaymentCheckoutBody {
  ShippingInfo shippingInfo;
  List<Cart> cart;
  String locale;
  String paymentOption;

  PaymentCheckoutBody(
      {this.shippingInfo, this.cart, this.locale, this.paymentOption});

  PaymentCheckoutBody.fromJson(Map<String, dynamic> json) {
    shippingInfo = json['shipping_info'] != null
        ? new ShippingInfo.fromJson(json['shipping_info'])
        : null;
    if (json['cart'] != null) {
      cart = new List<Cart>();
      json['cart'].forEach((v) {
        cart.add(new Cart.fromJson(v));
      });
    }
    locale = json['locale'];
    paymentOption = json['payment_option'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shippingInfo != null) {
      data['shipping_info'] = this.shippingInfo.toJson();
    }
    if (this.cart != null) {
      data['cart'] = this.cart.map((v) => v.toJson()).toList();
    }
    data['locale'] = this.locale;
    data['payment_option'] = this.paymentOption;
    return data;
  }
}

class ShippingInfo {
  String email;
  String address;
  String city;
  String country;

  ShippingInfo({this.email, this.address, this.city, this.country});

  ShippingInfo.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    return data;
  }
}

class Cart {
  String id;
  String price;
  String tax;
  String quantity;
  String shipping;
  String caseSize;
  String shippingType;
  String choice0 = 'PCs';

  Cart(
      {this.id,
        this.price,
        this.tax,
        this.quantity,
        this.shipping,
        this.caseSize,
        this.shippingType,
        this.choice0});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    tax = json['tax'];
    quantity = json['quantity'];
    shipping = json['shipping'];
    caseSize = json['case_size'];
    shippingType = json['shipping_type'];
    choice0 = json['choice_0'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['tax'] = this.tax;
    data['quantity'] = this.quantity;
    data['shipping'] = this.shipping;
    data['case_size'] = this.caseSize;
    data['shipping_type'] = this.shippingType;
    data['choice_0'] = this.choice0;
    return data;
  }
}
