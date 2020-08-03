class CheckoutModel {
  bool success;
  Results results;
  String message;

  CheckoutModel({this.success, this.results, this.message});

  CheckoutModel.fromJson(Map<String, dynamic> json) {
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
  int orderId;

  Results({this.orderId});

  Results.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    return data;
  }
}
