import 'package:provider/provider.dart';
import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/FlutterProvider/Order/OrderProvider.dart';
import 'package:smartcommercebd/src/models/Order.dart';
import 'package:smartcommercebd/src/widgets/EmptyOrdersProductsWidget.dart';
import 'package:smartcommercebd/src/widgets/OrderListItemWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OrdersProductsWidget extends StatefulWidget {
  var ordersList;

  @override
  _OrdersProductsWidgetState createState() => _OrdersProductsWidgetState();

  OrdersProductsWidget({Key key, this.ordersList}) : super(key: key);
}

class _OrdersProductsWidgetState extends State<OrdersProductsWidget> {
  ScrollController scrollController;

  String layout = 'list';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);

    scrollController = new ScrollController()
      ..addListener(() {
        print("Scroll position ${scrollController.position.pixels}");
        print(
            "Max Scroll position ${scrollController.position.maxScrollExtent}");

        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          print("Pagination Start");

          if (!provider.loading) {
            provider.OrderPagination();
          }

          print("Length ${provider.listData.length}");
        }
      });


    print("Order List   ${widget.ordersList}");

    return widget.ordersList == null
        ? Center(
            child: EmptyOrdersProductsWidget(),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Offstage(
                // offstage: widget.ordersList.isEmpty,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    leading: Icon(
                      UiIcons.inbox,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      S.of(context).ordersList,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      style: Theme.of(context).textTheme.display1,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            setState(() {
                              this.layout = 'list';
                            });
                          },
                          icon: Icon(
                            Icons.format_list_bulleted,
                            color: this.layout == 'list'
                                ? Theme.of(context).accentColor
                                : Theme.of(context).focusColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              this.layout = 'grid';
                            });
                          },
                          icon: Icon(
                            Icons.apps,
                            color: this.layout == 'grid'
                                ? Theme.of(context).accentColor
                                : Theme.of(context).focusColor,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Offstage(
                  offstage: this.layout != 'list',
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: scrollController,

                            //physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.ordersList.length,
                            itemBuilder: (context, int i) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.separated(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount:
                                      widget.ordersList[i].orderDetails.length,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(height: 10);
                                  },
                                  itemBuilder: (context, index) {
                                    return OrderListItemWidget(
                                      heroTag: 'orders_list',
                                      order_details: widget
                                          .ordersList[i].orderDetails[index],
                                      data: widget.ordersList[i],
                                      onDismissed: () {
                                        setState(() {
                                          widget.ordersList.removeAt(index);
                                        });
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        provider.loading
                            ? CircularProgressIndicator()
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
              /* Offstage(
          offstage: this.layout != 'grid',
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.ordersList.length,
              itemBuilder: (context, int i) {
                return new StaggeredGridView.countBuilder(
                  primary: false,
                  shrinkWrap: true,
                  crossAxisCount: 4,
                  itemCount: widget.ordersList[i].orderDetails.length,
                  itemBuilder: (BuildContext context, int index) {
                    Data data = widget.ordersList.elementAt(index);
                    return OrderGridItemWidget(
                      order_details: widget.ordersList[i].orderDetails[index],
                      heroTag: 'orders_grid',
                    );
                  },
//                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(index % 2 == 0 ? 1 : 2),
                  staggeredTileBuilder: (int index) =>
                      new StaggeredTile.fit(2),
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                );
              },
            ),
          ),
        ),*/
              Offstage(
                offstage: widget.ordersList.isNotEmpty,
                child: EmptyOrdersProductsWidget(),
              )
            ],
          );
  }
}
