import 'package:dio/dio.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/token.dart';
import 'package:sunbulahome/src/utils/helper.dart';

class TokenProvider {
  static final _endPoint = "${api_base_url}login";
  static final _dio = Dio();

  static Future<Token> getToken(Map loginInfo) async {
    _dio.options.contentType = Headers.formUrlEncodedContentType;
    try {
      Response response = await _dio.post(_endPoint, data: loginInfo);
      print(response);
      if (response.data['results'] == null) {
        return Token.withError('Invalid credential');
      } else {
        return Token.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return Token.withError(Common.handleError(error));
    }
  }
}
