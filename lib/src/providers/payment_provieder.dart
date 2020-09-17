

import 'package:dio/dio.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/payment.dart';
import 'package:smartcommercebd/src/providers/shared_pref_provider.dart';
import 'package:smartcommercebd/src/utils/helper.dart';

class PaymentProvider {
  static final Dio _dio = Dio();
  static Future<PaymentCheckoutResponse> postUserUpdatedData(Map<String, dynamic> updatedData) async {
    var token = await SharedPrefProvider.getString(token_key);
    var _endpoint = "${otp_base_url}checkout/id";
    _dio.options.headers = {
      'Content-type': '${Headers.formUrlEncodedContentType}',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.post(_endpoint, data: updatedData);
      return PaymentCheckoutResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return PaymentCheckoutResponse.withError(Common.handleError(error));
    }
  }
}