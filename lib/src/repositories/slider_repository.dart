

import 'package:sunbulahome/src/models/slider.dart';
import 'package:sunbulahome/src/providers/slider_provider.dart';

class SliderRepository{

  static Future<SliderResponse> getSliders() {
    return SliderProvider.getSliders();
  }
}