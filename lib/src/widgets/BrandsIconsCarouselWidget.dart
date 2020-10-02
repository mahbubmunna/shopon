import 'package:provider/provider.dart';
import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/brand.dart';
import 'package:sunbulahome/src/screens/brands.dart';
import 'package:sunbulahome/src/screens/home.dart';
import 'package:sunbulahome/src/utils/helper.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:flutter/material.dart';

class BrandsIconsCarouselWidget extends StatefulWidget {
  ScrollController controller;

  ValueChanged<String> onChanged;

  BrandsIconsCarouselWidget(
      {Key key, this.onChanged, @required this.controller})
      : super(key: key);

  @override
  _BrandsIconsCarouselWidgetState createState() =>
      _BrandsIconsCarouselWidgetState();
}

class _BrandsIconsCarouselWidgetState extends State<BrandsIconsCarouselWidget>
    with TickerProviderStateMixin {
//  BrandsList _brandsList = new BrandsList();

  // List<Brand> brandList;

  @override
  Widget build(BuildContext context) {
    print("Brands   ");
    final provider = Provider.of<BrandsProvider>(context);

    setState(() {
      brandsList = provider.brands_list;
    });

    return SizedBox(
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withOpacity(1),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(60),
                      topRight: Radius.circular(60)),
                ),
                child: Consumer<BrandsProvider>(
                  builder: (context, provider, _) {
                    return ListView.builder(
                      controller: widget.controller,
                      shrinkWrap: true,
                      itemCount: provider.brands_list.length,
                      itemBuilder: (context, index) {
                        print("Logo   ${provider.brands_list[index].logo}");

                        double _marginLeft = 0;
                        (index == 0) ? _marginLeft = 12 : _marginLeft = 0;
                        return InkWell(
                          splashColor: Theme.of(context).accentColor,
                          highlightColor: Theme.of(context).accentColor,
                          onTap: () {
                            /*setState(() {
                            widget.onPressed(widget.brand.id);
                          });*/

                            provider
                                .selecteBrand(provider.brands_list[index].id);

                            //  provider.brands_product.clear();
                            provider.BrandsProductPageination(1);
                            provider.isError = false;

                            //widget.controller.initialScrollOffset;

                            /*  widget.controller
                                .jumpTo(widget.controller.initialScrollOffset);*/
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: provider.brands_list[index].id ==
                                        provider.selectedBrandId
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Image.network(
                                    public_path_url +
                                        provider.brands_list[index].logo,
//                                    color: provider.brands_list[index].id ==
//                                            provider.selectedBrandId
//                                        ? Theme.of(context).accentColor
//                                        : Theme.of(context).primaryColor,
                                    width: 32,
                                    height: 32,

//                height: 18,
                                  ),
                                  SizedBox(width: 10),
                                  AnimatedSize(
                                    duration: Duration(milliseconds: 350),
                                    curve: Curves.easeInOut,
                                    vsync: this,
                                    child: Row(
                                      children: <Widget>[
                                        /*  Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: provider.brands_list[index].id ==
                                                  provider.selectedBrandId
                                              ? 18
                                              : 0,
                                        ),*/
                                        Text(
                                          provider.brands_list[index].id ==
                                                  provider.selectedBrandId
                                              ? provider.brands_list[index].name
                                                  .toString()
                                              : provider.brands_list[index].name
                                              .toString(),
                                          style:
                                              Theme.of(context).textTheme.body2,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                        ;
                      },
                      scrollDirection: Axis.horizontal,
                    );
                  },
                )),
          ),
          Container(
            width: 80,
            margin: EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  topLeft: Radius.circular(60)),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => BrandsWidget()));
              },
              icon: Icon(
                UiIcons.settings_2,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

/* Widget _buildBrandIcons(BrandResponse response) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: response.results.length,
      itemBuilder: (context, index) {
        double _marginLeft = 0;
        (index == 0) ? _marginLeft = 12 : _marginLeft = 0;
        return BrandIconWidget(
            heroTag: widget.heroTag,
            marginLeft: _marginLeft,
            brand: response.results.elementAt(index),
            onPressed: (String id) {
              setState(() {
                response.selectById(id);
                widget.onChanged(id);
              });
            });
      },
      scrollDirection: Axis.horizontal,
    );
  }*/
}
