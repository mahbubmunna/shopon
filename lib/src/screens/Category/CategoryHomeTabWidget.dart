import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/src/models/brand.dart';
import 'package:sunbulahome/src/models/product.dart';
import 'package:sunbulahome/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:sunbulahome/src/widgets/HomeSliderWidget.dart';
import 'package:flutter/material.dart';

class CategoryHomeTabWidget extends StatefulWidget {
  Product product;

  ///ProductsList _productsList = new ProductsList();

  CategoryHomeTabWidget({this.product});

  @override
  _CategoryHomeTabWidgetState createState() => _CategoryHomeTabWidgetState();
}

class _CategoryHomeTabWidgetState extends State<CategoryHomeTabWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.flag,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              widget.product.name,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        HomeSliderWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.favorites,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Description',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Text('${widget.product.meta_description}'),
        ),
        /*   Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.trophy,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              'Featured Products',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),*/

        //   FlashSalesCarouselWidget(heroTag: 'brand_featured_products', productsList: widget._productsList.flashSalesList),
      ],
    );
  }
}
