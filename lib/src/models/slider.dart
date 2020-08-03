class Slider {
  String image;
  String button;
  String description;
  String url;

  Slider({this.image, this.button, this.description, this.url});

  Slider.fromJson(Map<String, dynamic> json)
      : image = json['photo'],
        url = json['url'],
        button = 'Visit',
        description = 'Description';
}

class SliderList {
  List<Slider> _list;

  List<Slider> get list => _list;

  SliderList() {
    /*_list = [
      new Slider(
          image: 'assets/img/slider3.jpg',
          button: 'Collection',
          description: 'A room without books is like a body without a soul.'),
      new Slider(
          image: 'assets/img/slider1.jpg',
          button: 'Explore',
          description: 'Be yourself, everyone else is already taken.'),
      new Slider(
          image: 'assets/img/slider2.jpg',
          button: 'Visit Store',
          description: 'So many books, so little time.'),
    ];*/
  }
}

class SliderResponse {
  final List<Slider> results;
  final String error;

  SliderResponse.fromJson(Map<String, dynamic> json)
      : results = (json['results'] as List)
            .map((item) => Slider.fromJson(item))
            .toList(),
        error = '';

  SliderResponse.withError(String errorValue)
      : results = List(),
        error = errorValue;
}
