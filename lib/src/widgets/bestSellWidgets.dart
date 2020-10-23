import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/product.dart';
import 'package:sunbulahome/src/screens/Category/Products.dart';
import 'package:sunbulahome/src/screens/product.dart';

class BestSellList extends StatefulWidget {
  AsyncSnapshot<List<Product>> bestSell;
  BestSellList({this.bestSell});
  @override
  _BestSellListState createState() => _BestSellListState();
}

class _BestSellListState extends State<BestSellList> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //   controller: _flash_scroll_controller,
      itemCount: widget.bestSell.data.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        double _marginLeft = 0;
        (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
        return InkWell(
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => ProductWidget(
                  product: widget.bestSell.data[index],
                )));
            /*   Navigator.of(context).pushNamed('/Product',
                        arguments: new RouteArgument(
                            id: provider.flash_list[index].id,
                            argumentsList: [
                              provider.flash_list[index],
                              "flash" + provider.flash_list[index].id
                            ]));*/
          },
          child: Container(
            margin:
            EdgeInsets.only(left: _marginLeft, right: 20),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                widget.bestSell.data[index].thumbnail_img == null
                    ? SizedBox(
                  width: 160,
                  height: 200,
                  child: Shimmer.fromColors(
                    baseColor: Colors.red,
                    highlightColor: Colors.yellow,
                    child: Text(
                      S.of(context).shimmer,
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
                              widget.bestSell.data[index]
                                  .thumbnail_img),
                    ),
                  ),
                ),
                /*    Positioned(
                          top: 6,
                          right: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                                color: Theme.of(context).accentColor),
                            alignment: AlignmentDirectional.topEnd,
                            child: Text(
                              '${bestSell.data.results[index].} %',
                              style: Theme.of(context).textTheme.body2.merge(
                                  TextStyle(
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ),
                        ),*/
                Container(
                  margin: EdgeInsets.only(top: 175),
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 15),
                  width: 152,
                  height: 70,
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
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: <Widget>[
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          child: Text(
                            widget.bestSell.data[index].name,
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
                              '${widget.bestSell.data[index].available == null ? "0" : widget.bestSell.data[index].available} ${S.of(context).available}',
                              style: Theme.of(context)
                                  .textTheme
                                  .body1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
//                                          Icon(
//                                            Icons.star,
//                                            color: Colors.amber,
//                                            size: 18,
//                                          ),
                          Text(
                            S.of(context).sar +
                                widget.bestSell.data[index].price
                                    .toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold),
                          )
                        ],
                        crossAxisAlignment:
                        CrossAxisAlignment.center,
                      ),
                      // SizedBox(height: 7),
                      /*   Text(
                                '${provider.flash_list[index].available} Available',
                                style: Theme.of(context).textTheme.body1,
                                overflow: TextOverflow.ellipsis,
                              ),*/
                      /*    AvailableProgressBarWidget(
                                  available: provider
                                      .flash_list[index].available
                                      .toDouble())*/
                    ],
                  ),
                )
              ],
            ),
          ),
        );
        /*FlashSalesCarouselItemWidget(
            heroTag: this.widget.heroTag,
            marginLeft: _marginLeft,
        product: data.results.elementAt(index),
    )*/
        ;
      },
      scrollDirection: Axis.horizontal,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
