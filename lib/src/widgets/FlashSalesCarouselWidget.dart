/*import 'package:smartcommercebd/src/blocs/flashsale_bloc.dart';
import 'package:smartcommercebd/src/models/product.dart';
import 'package:smartcommercebd/src/repositories/flashsale_repository.dart';
import 'package:smartcommercebd/src/utils/helper.dart';
import 'package:smartcommercebd/src/widgets/FlashSalesCarouselItemWidget.dart';
import 'package:flutter/material.dart';

class FlashSalesCarouselWidget extends StatefulWidget {
  final List<Product> productsList;
  final String heroTag;

  FlashSalesCarouselWidget({
    Key key,
    this.productsList,
    this.heroTag,
  }) : super(key: key);

  @override
  _FlashSalesCarouselWidgetState createState() =>
      _FlashSalesCarouselWidgetState();
}

class _FlashSalesCarouselWidgetState extends State<FlashSalesCarouselWidget> {
  ScrollController _scrollController;

  @override
  void initState() {
   // flashSaleBloc.getFlashSaleProducts();

    _scrollController = new ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        margin: EdgeInsets.only(top: 10),
       child: Container(),

      *//*  child: StreamBuilder<ProductResponse>(
          stream: flashSaleBloc.subject.stream,
          builder: (context, AsyncSnapshot<ProductResponse> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.error != null &&
                  snapshot.data.error.length > 0) {
                return Common.buildErrorWidget(snapshot.data.error);
              }
              return Container();

              //return _buildFlashProducts(snapshot.data);
            } else if (snapshot.hasError) {
              return Common.buildErrorWidget(snapshot.error);
            } else {
              return Common.buildLoadingWidget();
            }
          },
        )*//*);
  }

*//*  _buildFlashProducts(ProductResponse data) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: data.results.length,
      itemBuilder: (context, index) {
        double _marginLeft = 0;
        (index == 0) ? _marginLeft = 20 : _marginLeft = 0;
        return FlashSalesCarouselItemWidget(
          heroTag: this.widget.heroTag,
          marginLeft: _marginLeft,
          product: data.results.elementAt(index),
        );
      },
      scrollDirection: Axis.horizontal,
    );
  }*//*
}*/
