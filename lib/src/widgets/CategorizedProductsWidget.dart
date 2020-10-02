import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/FlutterProvider/CategoryProvider/CategoryProvider.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/product.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:sunbulahome/src/screens/product.dart';
import 'package:sunbulahome/src/utils/common_utils.dart';
import 'package:sunbulahome/src/widgets/ProductGridItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CategorizedProductsWidget extends StatefulWidget {
  const CategorizedProductsWidget({
    Key key,
    @required this.animationOpacity,
    List<Product> productsList,
  })  : _productsList = productsList,
        super(key: key);

  final Animation animationOpacity;
  final List<Product> _productsList;

  @override
  _CategorizedProductsWidgetState createState() =>
      _CategorizedProductsWidgetState();
}

class _CategorizedProductsWidgetState extends State<CategorizedProductsWidget>
    with TickerProviderStateMixin {
  ScrollController _scrollControllerl;

  var product_current_page = 1;

  var physic;

  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "Category Products   Productssssssssssssssssssss  ${widget._productsList}");

    final category_products_provider = Provider.of<CategoryProvider>(context);

    return FadeTransition(
      opacity: widget.animationOpacity,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Consumer<CategoryProvider>(
          builder: (context, provider, _) {
            _scrollControllerl = ScrollController()
              ..addListener(() {
                /*  print(_scrollControllerl.position.pixels);
                print(_scrollControllerl.position.maxScrollExtent);*/
                print(
                    " Category   Scrolll   ${_scrollControllerl.position.pixels}");

                //pagination
                if (_scrollControllerl.position.pixels ==
                    _scrollControllerl.position.maxScrollExtent) {
                  category_products_provider
                      .setPage(category_products_provider.page + 1);

                  category_products_provider.CategoryProductsPagination();
                }

                //scroll physics change depend on scroll position....

                /* if (_scrollControllerl.position.pixels == 0.0) {
                  setState(() {
                    physic = NeverScrollableScrollPhysics();
                  });
                } else if (_scrollControllerl.position.maxScrollExtent ==
                    _scrollControllerl.position.pixels) {
                  if (provider.category_status &&
                      CommonUtils.home_scroll_value == 937.4488977677665) {
                    setState(() {
                      physic = null;
                    });

                    provider.setSelectedcategory(false);
                  } else {
                    setState(() {
                      physic = NeverScrollableScrollPhysics();
                    });
                  }
                }*/
              });

            return !provider.isError
                ? provider.categoryProductsList.length > 0
                    ? StaggeredGridView.countBuilder(
                        controller: _scrollControllerl,
                        physics: physic,

                        primary: false,
                        shrinkWrap: true,
                        crossAxisCount: 4,
                        itemCount: provider.categoryProductsList.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(
                              "The thamble image is   ${provider.categoryProductsList[index].thumbnail_img}");
                          print(
                              "Category Products Length  ${provider.categoryProductsList.length}");

                          /*    Product product =
                              widget._productsList.elementAt(index);*/
                          return InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(new MaterialPageRoute(
                                        builder: (context) => ProductWidget(
                                              product: provider
                                                  .categoryProductsList[index],
                                            )));
                              },
                              child: Container(
                                // margin: EdgeInsets.only(left: _marginLeft, right: 20),
                                child: Stack(
                                  alignment: AlignmentDirectional.topCenter,
                                  children: <Widget>[
                                    Hero(
                                      tag: "category" +
                                          provider
                                              .categoryProductsList[index].id
                                              .toString(),
                                      child: provider
                                                  .categoryProductsList[index]
                                                  .thumbnail_img ==
                                              null
                                          ? SizedBox(
                                              width: 160,
                                              height: 200,
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.red,
                                                highlightColor: Colors.yellow,
                                                child: Text(
                                                  'Shimmer',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 40.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 160,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: CachedNetworkImageProvider(
                                                      public_path_url +
                                                          provider
                                                              .categoryProductsList[
                                                                  index]
                                                              .thumbnail_img),
                                                ),
                                              ),
                                            ),
                                    ),
                                    Positioned(
                                      top: 6,
                                      right: 10,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 3),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100)),
                                            color:
                                                Theme.of(context).accentColor),
                                        alignment: AlignmentDirectional.topEnd,
                                        child: Text(
                                          '${provider.categoryProductsList[index].discount} %',
                                          style: Theme.of(context)
                                              .textTheme
                                              .body2
                                              .merge(TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 175),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      width: 152,
                                      height: 70,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Theme.of(context)
                                                    .hintColor
                                                    .withOpacity(0.15),
                                                offset: Offset(0, 3),
                                                blurRadius: 10)
                                          ]),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,

                                            child:Container(
                                              child: new Text(
                                                provider.categoryProductsList[index]
                                                    .name,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .body2,
                                                maxLines: 1,
                                                softWrap: false,
                                                overflow: TextOverflow.fade,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              // The title of the product
                                              Expanded(
                                                child: Text(
                                                  '${provider.categoryProductsList[index].sales==null? "0":provider.categoryProductsList[index].sales} Sales',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .body1,
                                                  overflow: TextOverflow.fade,
                                                  softWrap: false,
                                                ),
                                              ),
//                                              Icon(
//                                                Icons.star,
//                                                color: Colors.amber,
//                                                size: 18,
//                                              ),
                                              Text(
                                                'SAR '+provider
                                                    .categoryProductsList[index]
                                                    .price
                                                    .toString(),
                                                style: TextStyle(fontWeight: FontWeight.bold)
                                              )
                                            ],
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                          ),
                                          SizedBox(height: 7),
                                          /* Text(
                                  '${provider.brands_product[index].available} Available',
                                  style: Theme.of(context).textTheme.body1,
                                  overflow: TextOverflow.ellipsis,
                                ),*/
                                          /*  AvailableProgressBarWidget(
                                    available: provider
                                        .brands_product[index].available
                                        .toDouble())*/
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ));
                        },
//              staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 1),
                        staggeredTileBuilder: (int index) =>
                            new StaggeredTile.fit(2),
                        mainAxisSpacing: 15.0,
                        crossAxisSpacing: 15.0,
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      )
                : Center(
                    child: Text(S.of(context).empty),
                  );
          },
        ),
      ),
    );
  }
}
