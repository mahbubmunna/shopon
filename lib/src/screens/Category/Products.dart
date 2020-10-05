import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:sunbulahome/src/FlutterProvider/CategoryProvider/CategoryProvider.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:sunbulahome/src/screens/product.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var barndProduct_page = 1;
  ScrollController _brand_products_scroll_controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CategoryProvider>(context);
    return provider.categoryProductsList.length > 0
        ? NotificationListener<ScrollNotification>(
            // ignore: missing_return
            onNotification: (scrollNotification) {
              print("Scroll start  $scrollNotification");
            },
            child: StaggeredGridView.countBuilder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 4,
              itemCount: provider.categoryProductsList.length,
              itemBuilder: (BuildContext context, int index) {
                print(
                    "Image is  ${provider.categoryProductsList[index].thumbnail_img}");
                return InkWell(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (context) => ProductWidget(
                                product: provider.categoryProductsList[index],
                              )));

                      /* Navigator.of(context).pushNamed('/Product',
                          arguments: new RouteArgument(
                              id: provider.categoryProductsList[index].id,
                              argumentsList: [
                                provider.categoryProductsList[index],
                                "Brands" +
                                    provider.categoryProductsList[index].id
                              ]));*/
                    },
                    child: Container(
                      // margin: EdgeInsets.only(left: _marginLeft, right: 20),
                      child: Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: <Widget>[
                          provider.categoryProductsList[index].thumbnail_img ==
                                  null
                              ? SizedBox(
                                  width: 160,
                                  height: 200,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.red,
                                    highlightColor: Colors.yellow,
                                  ),
                                )
                              : Container(
                                  width: 160,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          "${public_path_url + provider.categoryProductsList[index].thumbnail_img}"),
                                    ),
                                  ),
                                ),
                          // Positioned(
                          //   top: 6,
                          //   right: 10,
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: 10, vertical: 3),
                          //     decoration: BoxDecoration(
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(100)),
                          //         color: Theme.of(context).accentColor),
                          //     alignment: AlignmentDirectional.topEnd,
                          //     child: Text(
                          //       '${provider.categoryProductsList[index].discount} %',
                          //       style: Theme.of(context).textTheme.body2.merge(
                          //           TextStyle(
                          //               color: Theme.of(context).primaryColor)),
                          //     ),
                          //   ),
                          // ),
                          Container(
                            margin: EdgeInsets.only(top: 170),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            width: 140,
                            height: 113,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      color: Theme.of(context)
                                          .hintColor
                                          .withOpacity(0.15),
                                      offset: Offset(0, 3),
                                      blurRadius: 10)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  provider.categoryProductsList[index].name,
                                  style: Theme.of(context).textTheme.body2,
                                  maxLines: 1,
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                                Row(
                                  children: <Widget>[
                                    // The title of the product
                                    Expanded(
                                      child: Text(
                                        '${provider.categoryProductsList[index].sales ==null?"0":provider.categoryProductsList[index].sales} ${S.of(context).available}',
                                        style:
                                            Theme.of(context).textTheme.body1,
                                        overflow: TextOverflow.fade,
                                        softWrap: false,
                                      ),
                                    ),
                                    Text(
                                      S.of(context).sar +
                                          provider
                                              .categoryProductsList[
                                          index]
                                              .price
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold),
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),

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
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
            ))
        : Center(
            child: Padding(padding: EdgeInsets.only(top: 150),child: Text("Loding.."),)
          );
  }

  Future<bool> thredData() async {
    await sleep(new Duration(seconds: 5));

    return true;
  }
}
