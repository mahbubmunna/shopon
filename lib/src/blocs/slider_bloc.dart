

import 'package:smartcommercebd/src/models/slider.dart';
import 'package:smartcommercebd/src/repositories/slider_repository.dart';
import 'package:rxdart/rxdart.dart';

class SliderBloc {
  final BehaviorSubject<SliderResponse> _subject =
      BehaviorSubject<SliderResponse>();

  getSliders() async {
    SliderResponse response = await SliderRepository.getSliders();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<SliderResponse> get subject => _subject;
}
final sliderBloc = SliderBloc();