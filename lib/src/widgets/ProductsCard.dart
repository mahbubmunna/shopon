import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/product.dart';
import 'package:smartcommercebd/src/screens/product.dart';

class ProductCardWidget extends StatelessWidget {
  Product product;

  var marginLeft;

  ProductCardWidget({this.product, this.marginLeft});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => ProductWidget(
                  product: product,
                )));
      },
      child: Container(
        margin: EdgeInsets.only(left: marginLeft, right: 20),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            product.thumbnail_img == null
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
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            public_path_url + product.thumbnail_img),
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              width: 152,
              height: 70,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                        color: Theme.of(context).hintColor.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 10)
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      child: Text(
                        product.name,
                        style: Theme.of(context).textTheme.body2,
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
                          '${product.sales == null ? "0" : product.sales} Sales',
                          style: Theme.of(context).textTheme.body1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Text(
                        product.rate.toString(),
                        style: Theme.of(context).textTheme.body2,
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
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
    ;
  }
}
