import 'package:dio/dio.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/product.dart';
import 'package:smartcommercebd/src/providers/shared_pref_provider.dart';
import 'package:smartcommercebd/src/utils/helper.dart';

class FavoriteApiProvider {
  static final _endpoint = "${api_base_url}wishlist";
  static final Dio _dio = Dio();

  static Future<FavoritesResponse> getFavorites() async {
    var token = await SharedPrefProvider.getString(token_key);
    _dio.options.headers = {
      'Content-type': '${Headers.formUrlEncodedContentType}',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.get(_endpoint);
      return FavoritesResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return FavoritesResponse.withError(Common.handleError(error));
    }
  }

  static Future<dynamic> postDataToFavorite(Map favoriteData) async {
    var token = await SharedPrefProvider.getString(token_key);
    _dio.options.headers = {
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };

    try {
      Response response = await _dio.post(_endpoint, data: favoriteData);
      print(response);
      return response;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }
  }
}
