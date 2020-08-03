import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/RelatedProduct.dart';
import 'package:smartcommercebd/src/models/route_argument.dart';
import 'package:smartcommercebd/src/screens/product.dart';

class RelatedProductView extends StatelessWidget {
  Results results;

  RelatedProductView({this.results});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>ProductWidget(results:results,)));


        /*Navigator.of(context).pushNamed('/Product',
            arguments: RouteArgument(
                //  id: widget.product.id,
                argumentsList: [
                  results,
                ]));*/
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Container(
              width: 160,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                  CachedNetworkImageProvider("${public_path_url}${results.thumbnailImg}"),
                ),
              ),
            ),
            /*  Positioned(
              top: 6,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(100)), color: Theme.of(context).accentColor),
                alignment: AlignmentDirectional.topEnd,
                child: Text(
                  '',
                  style: Theme.of(context).textTheme.body2.merge(TextStyle(color: Theme.of(context).primaryColor)),
                ),
              ),
            ),*/
            Container(
              margin: EdgeInsets.only(top: 170),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              width: 155,
              height: 80,
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
                  Text(
                    results.name,
                    style: Theme.of(context).textTheme.body2,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.fade,
                  ),
                  Row(
                    children: <Widget>[
                      // The title of the product
                      /* Expanded(
                        child: Text(
                          'Sales',
                          style: Theme.of(context).textTheme.body1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                        ),
                      ),*/
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),
                      Text(
                        results.rating.toString(),
                        style: Theme.of(context).textTheme.body2,
                      )
                    ],
                    crossAxisAlignment: CrossAxisAlignment.center,
                  ),
                  SizedBox(height: 7),
                  /*          Text(
                    '${results.} Available',
                    style: Theme.of(context).textTheme.body1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  AvailableProgressBarWidget(available: product.available.toDouble())*/
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
