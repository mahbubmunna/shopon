import 'package:provider/provider.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/FlutterProvider/ReviewProvider.dart';
import 'package:smartcommercebd/src/widgets/ReviewItemWidget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ReviewsListWidget extends StatefulWidget {
  final product_id;

  ReviewsListWidget({
    this.product_id,
    Key key,
  }) : super(key: key);

  @override
  _ReviewsListWidgetState createState() => _ReviewsListWidgetState();
}

class _ReviewsListWidgetState extends State<ReviewsListWidget> {
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ReviewProvider>(
      create: (_) => ReviewProvider(widget.product_id),
      child: Consumer<ReviewProvider>(
        builder: (context, provider, _) {
          scrollController = new ScrollController()
            ..addListener(() {
              var scroll_max = scrollController.position.maxScrollExtent;
              var current_position = scrollController.position.pixels;

              if (current_position == scroll_max) {
                provider.ReviewPagination();
              }
            });

          if (provider.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.listData == null) {
            return Center(
              child: Text(S.of(context).noReview),
            );
          } else {
            return ListView.separated(
              controller: scrollController,
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemBuilder: (context, index) {
                return ReviewItemWidget(
                    data: provider.review.results.data[index]);
              },
              separatorBuilder: (context, index) {
                return Divider(
                  height: 30,
                );
              },
              itemCount: provider.listData.length,
              primary: false,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            );
          }
        },
      ),
    );
  }
}
