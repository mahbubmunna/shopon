
import 'package:dio/dio.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/user.dart';
import 'package:smartcommercebd/src/providers/shared_pref_provider.dart';
import 'package:smartcommercebd/src/utils/helper.dart';

class ShippingProvider{
  static final String _endpoint = "${api_base_url}shipping_info";
  static final Dio _dio = Dio();

  static Future<UserResponse> postUserUpdatedData(Map updatedData) async {
    var token = await SharedPrefProvider.getString('access_token');
    _dio.options.headers = {
      'Content-type': '${Headers.formUrlEncodedContentType}',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.post(_endpoint, data: updatedData);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError(Common.handleError(error));;
    }
  }

}