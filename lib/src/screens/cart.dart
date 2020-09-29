import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/generated/l10n.dart';
import 'package:smartcommercebd/src/FlutterProvider/CartProvider/CartProvider.dart';
import 'package:smartcommercebd/src/models/Cart.dart';
import 'package:smartcommercebd/src/models/product.dart';
import 'package:smartcommercebd/src/models/route_argument.dart';
import 'package:smartcommercebd/src/screens/ShippingAddress.dart';
import 'package:smartcommercebd/src/screens/checkout.dart';
import 'package:smartcommercebd/src/screens/splash.dart';
import 'package:smartcommercebd/src/utils/common_utils.dart';
import 'package:smartcommercebd/src/utils/helper.dart';
import 'package:smartcommercebd/src/widgets/CartItemWidget.dart';
import 'package:flutter/material.dart';

class CartWidget extends StatefulWidget {
  @override
  _CartWidgetState createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  List<Cart> _cart_list = new List<Cart>();

  // var _totalPrice = 0;

  var price = 0.0;

  @override
  void initState() {
    super.initState();
    //  cartBloc.getCartProducts();

    print(CommonUtils.cart_list);

    var carts = CommonUtils.cart_list;

    for (int i = 0; i < carts.length; i++) {
      print("The Carts is   ${carts[i]}");
      _cart_list.add(Cart.fromJson(json.decode(carts[i])));
    }

    for (int i = 0; i < _cart_list.length; i++) {
      price += double.parse(_cart_list[i].unitPrice.toString()) *
          int.parse(_cart_list[i].quantity.toString());
    }

    //print("Carts List  ${_cart_list[0].id}");

    //Cart.fromJson(json.decode(CommonUtils.cart_list.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);
    double _productVat = price * .15;
    double _shippingCost = price < 50 ? 10 : 0;
    double _shippingVat = price < 50 ? 1.5 : 0;
    double _totalPrice = price + _productVat + _shippingCost + _shippingVat;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(UiIcons.return_icon,
                color: Theme.of(context).hintColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            S.of(context).cart,
            style: Theme.of(context).textTheme.display1,
          ),
          actions: <Widget>[
//            Container(
//                width: 30,
//                height: 30,
//                margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
//                child: InkWell(
//                  borderRadius: BorderRadius.circular(300),
//                  onTap: () {
//                    Navigator.of(context).pushNamed('/Tabs', arguments: 1);
//                  },
//                  child: CircleAvatar(
//                    backgroundImage: CachedNetworkImageProvider(appUser.avatar),
//                  ),
//                )),
          ],
        ),
        body: price > 0 ? Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 150),
              padding: EdgeInsets.only(bottom: 15),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 0),
                        leading: Icon(
                          UiIcons.shopping_cart,
                          color: Theme.of(context).hintColor,
                        ),
                        title: Text(
                          S.of(context).shoppingCart,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.display1,
                        ),
                        subtitle: Text(
                          S.of(context).verifyYourQuantityAndClickCheckout,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ),
                    ),
                    _cart_list != null
                        ? ListView.separated(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            primary: false,
                            itemCount: _cart_list.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 15);
                            },
                            itemBuilder: (context, index) {
                              return CartItemWidget(
                                product: _cart_list.elementAt(index),
                                index: index,
                                quantity: _cart_list[index].quantity,
                                onChanged: (quantity) {
                                  print("The count  ${quantity}");

                                  _cart_list[index].quantity = quantity;

                                  print(
                                      "Qantity is  ${_cart_list[index].quantity}");

                                  provider.updateCard(
                                      _cart_list[index], quantity, index);

                                  setState(() {
                                    price = 0.0;

                                    for (int i = 0;
                                        i < _cart_list.length;
                                        i++) {
                                      print(
                                          "Price calculation   === >  ${quantity} x ${_cart_list[i].unitPrice.toString()}");

                                      price += double.parse(_cart_list[i]
                                              .unitPrice
                                              .toString()) *
                                          int.parse(_cart_list[i]
                                              .quantity
                                              .toString());

                                      print("Price   ===>  ${price}");
                                    }
                                  });

                                  /*        provider.updateCard(
                                      _cart_list[index], quantity, index);*/
                                },
                              );
                            },
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 200,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                          color: Theme.of(context).focusColor.withOpacity(0.15),
                          offset: Offset(0, -2),
                          blurRadius: 5.0)
                    ]),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).subtotal,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          Text('${S.of(context).sar} ${price.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.subhead),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).vat15,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          Text('${S.of(context).sar} ${_productVat.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.subhead),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).shippingCost,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          Text('${S.of(context).sar} ${_shippingCost.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.subhead),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              S.of(context).shippingVat15,
                              style: Theme.of(context).textTheme.body2,
                            ),
                          ),
                          Text('${S.of(context).sar} ${_shippingVat.toStringAsFixed(2)}',
                              style: Theme.of(context).textTheme.subhead),
                        ],
                      ),
                      SizedBox(height: 10),
                      Stack(
                        fit: StackFit.loose,
                        alignment: AlignmentDirectional.centerEnd,
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: FlatButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/Checkout',
                                    arguments: RouteArgument(
                                        argumentsList: [
                                          _totalPrice
                                        ]));

                              },
                              padding: EdgeInsets.symmetric(vertical: 14),
                              color: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    S.of(context).checkout,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  Text(
                                    '${S.of(context).sar} ${(_totalPrice).toStringAsFixed(2)}',
                                    textScaleFactor: 1.2,
                                    style: TextStyle(fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor),
                                  ),
                                ],

                              )
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            )
          ],
        ) : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.remove_shopping_cart),
              Text(S.of(context).noItemsInTheCart)
            ],
          ),
        ) /*FutureBuilder(
        future: provider.getAllCarts(),
        builder: (BuildContext context, AsyncSnapshot<Carts> snapshot) {
          if (snapshot.hasData) {
            _cart_list = snapshot.data.results.cart;
            _totalPrice = 0;


          } else if (snapshot.hasError) {
            return Common.buildErrorWidget("Error");
          } else
            return Common.buildLoadingWidget();
        },
      ),*/
        );
  }
}
