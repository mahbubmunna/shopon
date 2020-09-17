
import 'package:smartcommercebd/src/models/payment.dart';
import 'package:smartcommercebd/src/providers/payment_provieder.dart';


class PaymentCheckoutRepository {

  static Future<PaymentCheckoutResponse> getPaymentStatus() {
    return null;
  }

  static Future<PaymentCheckoutResponse> postPaymentCheckout(Map<String, dynamic> updatedData) {
    return PaymentProvider.postUserUpdatedData(updatedData);
  }
}