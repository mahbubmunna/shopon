

import 'package:smartcommercebd/src/models/slider.dart';
import 'package:smartcommercebd/src/providers/slider_provider.dart';

class SliderRepository{

  static Future<SliderResponse> getSliders() {
    return SliderProvider.getSliders();
  }
}