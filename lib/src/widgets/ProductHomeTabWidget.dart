import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/FlutterProvider/MessageProvider.dart';
import 'package:sunbulahome/src/FlutterProvider/RelatedProductProvider.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/RelatedProduct.dart';
import 'package:sunbulahome/src/models/product.dart';
import 'package:sunbulahome/src/models/product_color.dart';
import 'package:sunbulahome/src/models/product_size.dart';
import 'package:sunbulahome/src/repositories/favorites_repository.dart';
import 'package:sunbulahome/src/screens/messages.dart';
import 'package:sunbulahome/src/screens/product.dart';
import 'package:sunbulahome/src/utils/common_utils.dart';
import 'package:sunbulahome/src/utils/helper.dart';
import 'package:sunbulahome/src/widgets/FlashSalesCarouselWidget.dart';
import 'package:flutter/material.dart';
import 'package:sunbulahome/config/app_config.dart' as config;
import 'package:sunbulahome/src/widgets/ProductsCard.dart';
import 'package:sunbulahome/src/widgets/RelatedProductView.dart';

class ProductHomeTabWidget extends StatefulWidget {
  Product product;

  //ProductsList _productsList = new ProductsList();

  ProductHomeTabWidget({
    this.product,
  });

  @override
  productHomeTabWidgetState createState() => productHomeTabWidgetState();
}

class productHomeTabWidgetState extends State<ProductHomeTabWidget> {
  var fullHeart = true;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RelatedProductProvider>(context);
    final message_provider = Provider.of<MessageProvider>(context);


    print("Product Page");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
//        Padding(
//          padding: const EdgeInsets.all(8.0),
//          child: InkWell(
//            onTap: () =>
//                statConvercation(context, message_provider, widget.product),
//            child: Container(
//              decoration: BoxDecoration(
//                  borderRadius: BorderRadius.all(Radius.circular(50)),
//                  color: config.Colors().mainColor(1)),
//              height: 50,
//              child: Center(
//                child: Text(
//                  "Message Seller",
//                  style: TextStyle(
//                      color: Colors.white, fontWeight: FontWeight.w300),
//                ),
//              ),
//            ),
//          ),
//        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.product.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.display2,
                ),
              ),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      addProductToFavorites();
                      fullHeart = false;
                    });
                  },
                  padding: EdgeInsets.symmetric(vertical: 14),
                  color: Theme.of(context).accentColor,
                  shape: StadiumBorder(),
                  child: fullHeart ? Icon(
                    UiIcons.heart,
                    color: Theme.of(context).primaryColor,
                  ): Icon(Icons.assignment_turned_in_outlined,  color: Theme.of(context).primaryColor),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(widget.product.getPrice(),
                  style: Theme.of(context).textTheme.display3),
              SizedBox(width: 10),
              SizedBox(width: 10),
            ],
          ),
        ),
        widget.product.colors.toString() == null
            ? Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).focusColor.withOpacity(0.15),
                        blurRadius: 5,
                        offset: Offset(0, 2)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            S.of(context).selectColor,
                            style: Theme.of(context).textTheme.body2,
                          ),
                        ),
                        /*MaterialButton(
                    onPressed: () {},
                    padding: EdgeInsets.all(0),
                    minWidth: 0,
                    child: Text(
                      'Clear All',
                      style: Theme.of(context).textTheme.body1,
                    ),
                  )*/
                      ],
                    ),
                    SizedBox(height: 10),
                    widget.product.colors.toString() == null
                        ? SelectColorWidget(
                            product: widget.product,
                          )
                        : Container(),
                  ],
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            leading: Icon(
              UiIcons.box,
              color: Theme.of(context).hintColor,
            ),
            title: Text(
              S.of(context).relatedPoducts,
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ),
        FutureBuilder(
            future: provider.getRelatedProduct(widget.product.id),
            builder: (context, AsyncSnapshot<List<Product>> data) {
              // print("The related data is  ${data.data}");

              if (data.data != null) {
                // print("The related data is  ${data.data[0]}");

                return Container(
                  height: 300,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: data.data.length,
                      itemBuilder: (context, int index) {
                        return Container(
                          height: 300,
                          child: ListView.builder(
                            //   controller: _flash_scroll_controller,
                            itemCount: data.data.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              double _marginLeft = 0;
                              (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
                              return ProductCardWidget(
                                product: data.data[index],
                                marginLeft: _marginLeft,
                              );
                              /*FlashSalesCarouselItemWidget(
            heroTag: this.widget.heroTag,
            marginLeft: _marginLeft,
        product: data.results.elementAt(index),
    )*/
                              ;
                            },
                            scrollDirection: Axis.horizontal,
                          ),
                        );
                      }),
                );
              } else {
                return Container(
                  height: 100,
                );
              }
            })

/*        FlashSalesCarouselWidget(
            heroTag: 'product_related_products', productsList: widget._productsList.flashSalesList),*/
      ],
    );
  }

  void addProductToFavorites() {
    Map favoriteData = {'product_id': int.parse(widget.product.id)};
    var response =
    FavoritesRepository.postDataToCart(favoriteData).catchError((error) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          body: Text(Common.handleError(error)))
          .show();
      Timer(Duration(seconds: 3), () {
        Navigator.pop(context);
      });

    });
    print(response.then((value) => print(value)));
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        body: Text(S.of(context).successfullyAddedToFavorites))
        .show();
    Timer(Duration(seconds: 3), () {
      Navigator.pop(context);
    });
  }

  Future<String> statConvercation(
    BuildContext context,
    MessageProvider message_provider,
    Product product,
    /* Results result,*/
  ) async {
    String title = '';
    String description = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        print("Status Value   ${message_provider.loading}");

        return AlertDialog(
          title: Text(S.of(context).startConvercation),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    new Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        new TextField(
                          autofocus: true,
                          decoration: new InputDecoration(
                            labelText: S.of(context).title,
                            hintText: S.of(context).title,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                          ),
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                        new TextField(
                          maxLength: 500,
                          maxLines: 5,
                          autofocus: true,
                          decoration: new InputDecoration(
                            labelText: S.of(context).description,
                            hintText: S.of(context).description,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black26),
                            ),
                          ),
                          onChanged: (value) {
                            description = value;
                          },
                        )
                      ],
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: new Consumer<MessageProvider>(
                          builder: (context, provider, _) {
                            print("Status  ${provider.loading}");

                            return provider.loading == true
                                ? CircularProgressIndicator()
                                : Container();
                          },
                        ),
                      ),
                    )

/*
                     message_provider.loading ? Positioned.fill(child:Align(alignment: Alignment.center,child: CircularProgressIndicator(),) ) : Container()
*/
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                S.of(context).cancel,
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(S.of(context).send),
              onPressed: () {
                message_provider.setLoading(true);

                if (title.isNotEmpty && description.isNotEmpty) {
                  message_provider
                      .startConversetion(widget.product.id, title, description)
                      .then((value) {
                    if (value.success) {
                      message_provider.setLoading(false);
                      Navigator.of(context).pop();

                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => MessagesWidget()));
                    }
                  });
                } else {
                  message_provider.setLoading(false);
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class SelectColorWidget extends StatefulWidget {
  Product product;

  SelectColorWidget({
    this.product,
    Key key,
  }) : super(key: key);

  @override
  _SelectColorWidgetState createState() => _SelectColorWidgetState();
}

class _SelectColorWidgetState extends State<SelectColorWidget> {
  List<dynamic> colors;

  @override
  Widget build(BuildContext context) {
    colors = json.decode(widget.product.colors.toString());

    print("Colors   ${colors}");
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(colors.length, (index) {
        print("Colors   ${index}");

        var _color = colors.elementAt(index);
        return buildColor(_color);
      }),
    );
  }

  SizedBox buildColor(color) {
    print("The colors is ${color}");
    var colors = color.toString().replaceAll("#", "");
    var backgroundColor = "0xff${colors}";

    return SizedBox(
      width: 38,
      height: 38,
      child: FilterChip(
        label: Text(''),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        backgroundColor: Color(int.parse(backgroundColor)),
        selectedColor: Color(int.parse(backgroundColor)),
        selected: CommonUtils.selected_color == null
            ? false
            : CommonUtils.selected_color == colors ? true : false,
        shape: StadiumBorder(),
        avatar: Text(''),
        onSelected: (bool value) {
          setState(() {
            CommonUtils.selected_color = colors;
          });
        },
      ),
    );
  }
}

class SelectSizeWidget extends StatefulWidget {
  SelectSizeWidget({
    Key key,
  }) : super(key: key);

  @override
  _SelectSizeWidgetState createState() => _SelectSizeWidgetState();
}

class _SelectSizeWidgetState extends State<SelectSizeWidget> {
  ProductSizesList _productSizesList = new ProductSizesList();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(_productSizesList.list.length, (index) {
        var _size = _productSizesList.list.elementAt(index);
        return buildSize(_size);
      }),
    );
  }

  SizedBox buildSize(ProductSize size) {
    return SizedBox(
      height: 38,
      child: RawChip(
        label: Text(size.code),
        labelStyle: TextStyle(color: Theme.of(context).hintColor),
        padding: EdgeInsets.symmetric(horizontal: 7, vertical: 7),
        backgroundColor: Theme.of(context).focusColor.withOpacity(0.05),
        selectedColor: Theme.of(context).focusColor.withOpacity(0.2),
        selected: size.selected,
        shape: StadiumBorder(
            side: BorderSide(
                color: Theme.of(context).focusColor.withOpacity(0.05))),
        onSelected: (bool value) {
          setState(() {
            size.selected = value;
          });
        },
      ),
    );
  }
}
