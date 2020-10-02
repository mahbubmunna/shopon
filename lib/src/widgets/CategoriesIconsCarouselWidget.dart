import 'package:provider/provider.dart';
import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/src/FlutterProvider/CategoryProvider/CategoryProvider.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/category.dart';
import 'package:sunbulahome/src/models/product.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:sunbulahome/src/screens/Category/CategorysWidget.dart';
import 'package:sunbulahome/src/screens/brands.dart';
import 'package:sunbulahome/src/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';

class CategoriesIconsCarouselWidget extends StatefulWidget {
  String heroTag;
  ScrollController controller;

  ValueChanged<String> onChanged;

  CategoriesIconsCarouselWidget(
      {Key key, this.heroTag, this.onChanged, @required this.controller})
      : super(key: key);

  @override
  _CategoriesIconsCarouselWidgetState createState() =>
      _CategoriesIconsCarouselWidgetState();
}

class _CategoriesIconsCarouselWidgetState
    extends State<CategoriesIconsCarouselWidget> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);

    return SizedBox(
      height: 65,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: 80,
            margin: EdgeInsets.only(left: 0),
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(1),
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(60),
                  topRight: Radius.circular(60)),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => CategorysWidget()));
              },
              icon: Icon(
                UiIcons.settings_2,
                size: 28,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withOpacity(1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      topLeft: Radius.circular(60)),
                ),
                child: Consumer<CategoryProvider>(
                  builder: (context, provider, _) {
                    return ListView.builder(
                      controller: widget.controller,
                      shrinkWrap: true,
                      itemCount: provider.category_list.length,
                      itemBuilder: (context, index) {
                        double _marginLeft = 0;
                        (index == 0) ? _marginLeft = 12 : _marginLeft = 0;
                        return InkWell(
                          splashColor: Theme.of(context).accentColor,
                          highlightColor: Theme.of(context).accentColor,
                          onTap: () {
                            provider.setSelectedcategory(
                                provider.category_list[index].id);

                            provider.setPage(1);

                            provider.categoryProductsList.clear();
                            provider.CategoryProductsPagination();

                            provider.isError = false;

                            print(
                                "Category Product  id =  ${provider.selectedcategory}  page  ==  ${provider.page} ");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 350),
                              curve: Curves.easeInOut,
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                color: provider.category_list[index].id ==
                                        provider.selectedcategory
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Image.network(
                                    "${public_path_url}${provider.category_list[index].icon}",
//                                    color: provider.category_list[index].id ==
//                                            provider.selectedcategory
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
                                        Text(
                                          provider.category_list[index].id ==
                                                  provider.selectedcategory
                                              ? provider
                                                  .category_list[index].name
                                                  .toString()
                                              : provider
                                                  .category_list[index].name
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
        ],
      ),
    );
  }
}
