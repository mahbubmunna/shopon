

import 'package:dio/dio.dart';
import 'package:sunbulahome/src/configs/strings.dart';

class RegistrationProvider {
  static final _endpoint = "${api_base_url}register";
  static final _dio = Dio();

  static Future<dynamic> postRegistrationInfo(Map registrationInfo) async{
    _dio.options.contentType = Headers.formUrlEncodedContentType;
    try {
      Response response = await _dio.post(_endpoint, data: registrationInfo);
      print(response);
      return response;
    } catch (error, stacktrace){
      print("Exception occured: $error stackTrace: $stacktrace");
      return error;
    }

  }
}