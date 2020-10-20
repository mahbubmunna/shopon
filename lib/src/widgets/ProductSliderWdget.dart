import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sunbulahome/src/configs/strings.dart';

typedef callback = Function(int);

class ProductSliderWidget extends StatefulWidget {
  List<dynamic> data;

  final callback changeIndex;

  ProductSliderWidget({this.data, this.changeIndex});

  @override
  _ProductSliderWidgetState createState() => _ProductSliderWidgetState();
}

class _ProductSliderWidgetState extends State<ProductSliderWidget> {
  @override
  Widget build(BuildContext context) {
    int _current;

    return Stack(
      //alignment: AlignmentDirectional.bottomEnd,
//      fit: StackFit.expand,
      children: <Widget>[
        CarouselSlider(
          autoPlay: false,
          autoPlayInterval: Duration(seconds: 5),
          height: double.infinity,
          viewportFraction: 1.0,
          onPageChanged: (index) {


            widget.changeIndex(index);


            setState(() {
              _current = index;
            });
          },
          items: widget.data.map((slide) {
            // print("Slide  ${slide.description}");
            return Builder(
              builder: (BuildContext context) {


                return InkWell(


                  child: Container(
             /*       margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 20),*/
                    height: 360,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: CachedNetworkImageProvider('$public_path_url$slide'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2),
                            offset: Offset(0, 4),
                            blurRadius: 9)
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 10,
          right: 41,
//          width: config.App(context).appWidth(100),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: widget.data.map((slide) {
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == widget.data.indexOf(slide)
                        ? Theme.of(context).hintColor
                        : Theme.of(context).hintColor.withOpacity(0.3)),
              );
            }).toList(),
          ),
        ),
      ],
    );
    ;
  }
}
