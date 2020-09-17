
class PaymentCheckoutResponse {
  PaymentCheckout paymentCheckout;
  String error;

  PaymentCheckoutResponse.fromJson(Map<String, dynamic> json)
      : paymentCheckout = PaymentCheckout.fromJson(json),
        error = "";

  PaymentCheckoutResponse.withError(String errorValue)
      : paymentCheckout = PaymentCheckout(),
        error = errorValue;
}


class PaymentCheckout {
  bool success;
  PaymentCheckoutResults results;
  String message;

  PaymentCheckout({this.success, this.results, this.message});

  PaymentCheckout.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    results =
    json['results'] != null ? new PaymentCheckoutResults.fromJson(json['results']) : null;
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

class PaymentCheckoutResults {
  Result result;
  String buildNumber;
  String timestamp;
  String ndc;
  String id;
  String checkoutId;
  int orderId;

  PaymentCheckoutResults(
      {this.result,
        this.buildNumber,
        this.timestamp,
        this.ndc,
        this.id,
        this.checkoutId,
        this.orderId});

  PaymentCheckoutResults.fromJson(Map<String, dynamic> json) {
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    buildNumber = json['buildNumber'];
    timestamp = json['timestamp'];
    ndc = json['ndc'];
    id = json['id'];
    checkoutId = json['checkout_id'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['buildNumber'] = this.buildNumber;
    data['timestamp'] = this.timestamp;
    data['ndc'] = this.ndc;
    data['id'] = this.id;
    data['checkout_id'] = this.checkoutId;
    data['order_id'] = this.orderId;
    return data;
  }
}

class Result {
  String code;
  String description;

  Result({this.code, this.description});

  Result.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['description'] = this.description;
    return data;
  }
}