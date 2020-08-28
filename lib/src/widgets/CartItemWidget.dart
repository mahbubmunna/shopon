import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:smartcommercebd/src/FlutterProvider/CartProvider/CartProvider.dart';
import 'package:smartcommercebd/src/models/Cart.dart';
import 'package:smartcommercebd/src/models/product.dart';
import 'package:smartcommercebd/src/models/route_argument.dart';
import 'package:flutter/material.dart';
import 'package:smartcommercebd/src/screens/product.dart';

import '../configs/strings.dart';

typedef countCallBack = Function(int num);

class CartItemWidget extends StatefulWidget {
  String heroTag;
  Cart product;
  var quantity;
  Map cartProductIdMap;
  countCallBack onChanged;
  int index;


  CartItemWidget(
      {Key key,
      this.product,
      this.heroTag,
      this.cartProductIdMap,
      this.quantity,
      this.onChanged,
      this.index})
      : super(key: key);

  @override
  _CartItemWidgetState createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    // print("Image   ${widget.product.images}");
    //  print("unitPrice   ${widget.product.unitPrice}");
    //print("quantity    ${widget.product.quantity}");

    final provider = Provider.of<CartProvider>(context);
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        //  Navigator.of(context).push(new MaterialPageRoute(builder: (context)=>ProductWidget(product: widget.product,)));

        /*Navigator.of(context).pushNamed('/Product',
            arguments: RouteArgument(
                id: widget.product.id,
                argumentsList: [widget.product, widget.heroTag]));*/
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.9),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.1),
                blurRadius: 5,
                offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: UniqueKey().toString(),
              child: Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          widget.product.images.toString().contains("https")
                              ? widget.product.images
                              : public_path_url + widget.product.images),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.product.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subhead,
                        ),
                        Text(
                          widget.product.unitPrice.toString(),
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          /*setState(() {
                            widget.quantity =
                                this.incrementQuantity(widget.quantity);
                          });*/

                          print("Count  increase  first  ${widget.quantity}");

                          setState(() {
                            widget.quantity =
                                int.parse(widget.quantity.toString()) + 1;
                          });

                          widget.onChanged(widget.quantity);
                          print("Count  increase   ${widget.quantity}");
                          /* provider.updateCard(
                              widget.product, widget.quantity, widget.index);*/
                        },
                        iconSize: 30,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        icon: Icon(Icons.add_circle_outline),
                        color: Theme.of(context).hintColor,
                      ),
                      Text(widget.quantity.toString(),
                          style: Theme.of(context).textTheme.subhead),
                      IconButton(
                        onPressed: () {
                          /*setState(() {
                            widget.quantity =
                                this.decrementQuantity(widget.quantity);

                          });*/

                          print("Count  descrisse  first ${widget.quantity}");

                          if (widget.quantity > 1) {
                            setState(() {
                              widget.quantity =
                                  int.parse(widget.quantity.toString()) - 1;
                            });

                            widget.onChanged(widget.quantity);

                            print("Count  descrisse  ${widget.quantity}");

                            /* provider.updateCard(
                                widget.product, widget.quantity, widget.index);*/
                          }
                        },
                        iconSize: 30,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        icon: Icon(Icons.remove_circle_outline),
                        color: Theme.of(context).hintColor,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  incrementQuantity(int quantity) {
    if (quantity <= 99) {
      return ++quantity;
    } else {
      return quantity;
    }
  }

  decrementQuantity(int quantity) {
    if (quantity > 1) {
      return --quantity;
    } else {
      // print(widget.cartProductIdMap);
      //  removeProductFromCart();

    }
  }

/* void removeProductFromCart() {
    print(widget.cartProductIdMap[int.parse(widget.product.id)]);
    Map cartData = {
      'cart_id' : widget.cartProductIdMap[int.parse(widget.product.id)]};
    var response = CartRepository.deleteDataFromCart(cartData);
    print(response.then((value) => print(value)));
    AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        body: Text('successfully deteted from cart')
    ).show();
  }*/
}
