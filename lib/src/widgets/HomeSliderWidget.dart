import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sunbulahome/src/blocs/slider_bloc.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/slider.dart';
import 'package:sunbulahome/src/models/slider.dart' as prefix0;
import 'package:sunbulahome/src/repositories/slider_repository.dart';
import 'package:sunbulahome/src/utils/helper.dart';
import 'package:flutter/material.dart';

class HomeSliderWidget extends StatefulWidget {
  @override
  _HomeSliderWidgetState createState() => _HomeSliderWidgetState();
}

class _HomeSliderWidgetState extends State<HomeSliderWidget> with AutomaticKeepAliveClientMixin{
  int _current = 0;
  SliderList _sliderList = new SliderList();

  @override
  void initState() {
    super.initState();
    sliderBloc.getSliders();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: StreamBuilder<SliderResponse>(
        stream: sliderBloc.subject.stream,
        builder: (context, AsyncSnapshot<SliderResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              return Common.buildErrorWidget(snapshot.data.error);
            }

            print("banner Data ${snapshot.data}");

            //  return Container();
            return _buildSliders(snapshot.data);
          } else if (snapshot.hasError) {
            return Common.buildErrorWidget(snapshot.error);
          } else {
            return Common.buildLoadingWidget();
          }
        },
      ),
    );
  }

  _buildSliders(SliderResponse data) {
    List<Widget> _images = data.results.map((slide) {
      print("Slide  ${slide.description}");
      return Builder(
        builder: (BuildContext context) {
          return Container(
            margin:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                  image: CachedNetworkImageProvider('$public_path_url${slide.image}'),
                  fit: BoxFit.cover),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                    offset: Offset(0, 4),
                    blurRadius: 9)
              ],
            ),
          );
        },
      );
    }).toList();

    data.results.map((element) {
      print("Slider   ${element.image}");
    });

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
//      fit: StackFit.expand,
      children: <Widget>[
        CarouselSlider(
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          height: 240,
          viewportFraction: 1.0,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
          items: _images
        ),
        Positioned(
          bottom: 25,
          right: 41,
//          width: config.App(context).appWidth(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: data.results.map((prefix0.Slider slide) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == data.results.indexOf(slide)
                        ? Theme.of(context).hintColor
                        : Theme.of(context).hintColor.withOpacity(0.3)),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
