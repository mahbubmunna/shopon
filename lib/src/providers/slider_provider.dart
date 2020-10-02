

import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/slider.dart';
import 'package:sunbulahome/src/utils/helper.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;


class SliderProvider {
  static final  _endpoint = "${api_base_url}banner";

  static Future<SliderResponse> getSliders() async {
    try{
      var response = await http.get(_endpoint);
      var formatted = Helper.trimTrailing(response.body);
      return SliderResponse.fromJson(convert.jsonDecode(formatted));
    } catch (error, stacktrace) {
      print('Exception occured: $error stackTrace: $stacktrace');
      return SliderResponse.withError(Common.handleError(error));;
    }
  }
}