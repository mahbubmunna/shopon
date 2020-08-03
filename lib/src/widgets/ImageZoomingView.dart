import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoomingView extends StatelessWidget {
  var image;

  ImageZoomingView(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: PhotoView(
    //  imageProvider: NetworkImage("${image}"),
      imageProvider: CachedNetworkImageProvider("${image}"),
    ));
  }
}
