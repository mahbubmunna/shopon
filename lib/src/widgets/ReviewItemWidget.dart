import 'package:cached_network_image/cached_network_image.dart';
import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/src/configs/strings.dart';
import 'package:smartcommercebd/src/models/Review.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReviewItemWidget extends StatelessWidget {
  Data data;

  ReviewItemWidget({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      runSpacing: 10,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                image: DecorationImage(
                    image: data.profilePic == null
                        ? AssetImage("assets/img/user1.jpg")
                        : CachedNetworkImageProvider(
                            "${public_path_url}${this.data.profilePic}"),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              this.data.name,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.title.merge(
                                  TextStyle(
                                      color: Theme.of(context).hintColor)),
                            ),
                            Row(
                              children: <Widget>[
                                Icon(
                                  UiIcons.calendar,
                                  color: Theme.of(context).focusColor,
                                  size: 20,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  this.data.createdAt,
                                  style: Theme.of(context).textTheme.caption,
                                  overflow: TextOverflow.fade,
                                  softWrap: false,
                                ),
                              ],
                            ),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Chip(
                        padding: EdgeInsets.all(0),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(data.rating.toString(),
                                style: Theme.of(context).textTheme.body2.merge(
                                    TextStyle(
                                        color:
                                            Theme.of(context).primaryColor))),
                            Icon(
                              Icons.star_border,
                              color: Theme.of(context).primaryColor,
                              size: 16,
                            ),
                          ],
                        ),
                        backgroundColor:
                            Theme.of(context).accentColor.withOpacity(0.9),
                        shape: StadiumBorder(),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        Text(
          data.comment,
          style: Theme.of(context).textTheme.body1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          maxLines: 3,
        )
      ],
    );
  }
}
