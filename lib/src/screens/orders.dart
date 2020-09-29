import 'package:provider/provider.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/FlutterProvider/Order/OrderProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/Order/PaidProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/Order/PendingProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/Order/ShippedProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/Order/UnpaidProvider.dart';
import 'package:smartcommercebd/src/screens/orders_products.dart';
import 'package:smartcommercebd/src/widgets/DrawerWidget.dart';
import 'package:smartcommercebd/src/widgets/EmptyOrdersProductsWidget.dart';
import 'package:smartcommercebd/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';

class OrdersWidget extends StatefulWidget {
  int currentTab;

  OrdersWidget({Key key, this.currentTab}) : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: widget.currentTab ?? 0,
        length: 5,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: DrawerWidget(),
          appBar: AppBar(
            automaticallyImplyLeading: false,
//        leading: new IconButton(
//          icon: new Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
//          onPressed: () => Navigator.of(context).pop(),
//        ),
            leading: new IconButton(
              icon: new Icon(Icons.sort, color: Theme.of(context).hintColor),
              onPressed: () => _scaffoldKey.currentState.openDrawer(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              S.of(context).myOrders,
              style: Theme.of(context).textTheme.display1,
            ),
            actions: <Widget>[
              new ShoppingCartButtonWidget(
                  iconColor: Theme.of(context).hintColor,
                  labelColor: Theme.of(context).accentColor),
//              Container(
//                  width: 30,
//                  height: 30,
//                  margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
//                  child: InkWell(
//                    borderRadius: BorderRadius.circular(300),
//                    onTap: () {
//                      Navigator.of(context).pushNamed('/Tabs', arguments: 1);
//                    },
//                    child: CircleAvatar(
//                      backgroundImage: AssetImage('assets/img/user2.jpg'),
//                    ),
//                  )),
            ],
            bottom: TabBar(
                indicatorPadding: EdgeInsets.all(10),
                labelPadding: EdgeInsets.symmetric(horizontal: 5),
                unselectedLabelColor: Theme.of(context).accentColor,
                labelColor: Theme.of(context).primaryColor,
                isScrollable: true,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Theme.of(context).accentColor),
                tabs: [
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(S.of(context).all),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(S.of(context).unpaid),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(S.of(context).paid),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(S.of(context).shipped),
                      ),
                    ),
                  ),
                  Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Theme.of(context).accentColor, width: 1)),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(S.of(context).pending),
                      ),
                    ),
                  ),
                ]),
          ),
          body: Consumer5<OrderProvider, PaidProvider, UnpaidProvider,
              ShippedProvider, PendingProvider>(
            builder: (context, allprovider, paidProvider, unpaidProvider,
                shippedProvider, pendingProvider, _) {
              print("List            ==>   ${allprovider.listData}");

              return allprovider.listData == null
                  ? Center(
                      child: Center(
                        child: EmptyOrdersProductsWidget(),
                      ),
                    )
                  : TabBarView(children: [
                      OrdersProductsWidget(ordersList: allprovider.listData),
                      OrdersProductsWidget(ordersList: unpaidProvider.listData),
                      OrdersProductsWidget(ordersList: paidProvider.listData),
                      OrdersProductsWidget(
                          ordersList: shippedProvider.listData),
                      OrdersProductsWidget(
                          ordersList: pendingProvider.listData),
                    ]);
            },
          ),
        ));
  }
}
