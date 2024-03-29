import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/FlutterProvider/CheckoutProvider.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/Delivery.dart';
import 'package:sunbulahome/src/models/Delivery.dart';
import 'package:sunbulahome/src/providers/shared_pref_provider.dart';
import 'package:sunbulahome/src/utils/common_utils.dart';
import 'package:sunbulahome/src/widgets/ShoppingCartButtonWidget.dart';
import 'package:flutter/material.dart';

class ShippingAddress extends StatefulWidget {
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddress> {
  final controller_address = new TextEditingController();
  final controller_country = new TextEditingController();
  final controller_city = new TextEditingController();
  final controller_postal_code = new TextEditingController();
  final controller_phone = new TextEditingController();
  final controller_name = new TextEditingController();
  final controller_email = new TextEditingController();

  GlobalKey<ScaffoldState> _globalKey = new GlobalKey();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final provider = Provider.of<CheckoutProvider>(context);

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon:
              new Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          S.of(context).shippingAddress,
          style: Theme.of(context).textTheme.display1,
        ),
      ),
      body: AbsorbPointer(
        absorbing: loading ? true : false,
        child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextField(
                        controller: controller_name,
                        decoration: new InputDecoration(
                          labelText: S.of(context).name,
                          hintText: S.of(context).name,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextField(
                        controller: controller_email,
                        decoration: new InputDecoration(
                          labelText: S.of(context).email,
                          hintText: S.of(context).email,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextField(
                        controller: controller_city,
                        decoration: new InputDecoration(
                          labelText: S.of(context).city,
                          hintText: S.of(context).city,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextField(
                        controller: controller_country,
                        decoration: new InputDecoration(
                          labelText: S.of(context).country,
                          hintText: S.of(context).country,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextField(
                        controller: controller_address,
                        decoration: new InputDecoration(
                          labelText: S.of(context).address,
                          hintText: S.of(context).address,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextField(
                        controller: controller_postal_code,
                        decoration: new InputDecoration(
                          labelText: S.of(context).postalCode,
                          hintText: S.of(context).postalCode,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new TextField(
                        controller: controller_phone,
                        decoration: new InputDecoration(
                          labelText: S.of(context).phone,
                          hintText: S.of(context).phone,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26),
                          ),
                        ),
                      ),
                    ),

                    /*  style: Theme.of(context).textTheme.display1.merge(
                      TextStyle(
                          color: Theme.of(context).primaryColor)*/

                    InkWell(
                      onTap: () => shipping_address(provider),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).accentColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            child: Center(
                              child: Text(S.of(context).checkout,
                                  style: Theme.of(context)
                                      .textTheme
                                      .display1
                                      .merge(
                                        TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )),
                            )),
                      ),
                    )
                  ],
                ),
                loading
                    ? Positioned.fill(
                        child: Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ))
                    : Container()
              ],
            )),
      ),
    );
  }

  shipping_address(CheckoutProvider provider) {
    if (controller_address.value.text.isEmpty &&
        controller_country.value.text.isEmpty &&
        controller_city.value.text.isEmpty &&
        controller_postal_code.value.text.isEmpty &&
        controller_phone.value.text.isEmpty &&
        controller_name.value.text.isEmpty &&
        controller_email.value.text.isEmpty) {
      _globalKey.currentState
          .showSnackBar(new SnackBar(content: new Text(S.of(context).empty)));
    } else {
      setState(() {
        loading = true;
      });

      /*
      * 
      *   Navigator.of(context)
              .push(new MaterialPageRoute(builder: (context) => Checkout()));
      * 
      * */

      Delivery delivery = new Delivery();

      delivery.shippingInfo = ShippingInfo(
          email: controller_email.value.text,
          name: controller_name.value.text,
          address: controller_address.value.text,
          country: controller_country.value.text,
          city: controller_country.value.text,
          postalCode: controller_postal_code.value.text,
          phone: controller_phone.value.text);

      var carts = json.decode(CommonUtils.cart_list.toString());

      print("cartsss  ==>  ${carts[0]["id"]}");

      List<Cart> _carts_list = new List();
      for (int i = 0; i < carts.length; i++) {
        _carts_list.add(new Cart(
            id: int.parse(carts[i]["id"].toString()),
            name: carts[i]["name"],
            images: carts[i]["images"],
            flashDealDiscount: carts[i]["flashDealDiscount"],
            quantity: carts[i]["quantity"],
            price: carts[i]["unitPrice"]));
      }

      delivery.cart = _carts_list;

      /*  for (int i = 0; i < carts.length; i++) {
        print("The Carts is   ${carts[i]["id"]}");
        delivery.cart.add(Cart.fromJson(json.decode(carts[i])));
      }*/

      delivery.paymentOption = "cash_on_delivery";

      /* print("Deliver  payment type  =  >  ${delivery.paymentOption}");
      print("Deliver  payment cart  =  >  ${delivery.cart[1].price}");
      print("Deliver  shipping address  =  >  ${delivery.shippingInfo}");*/

      provider.delivery_checkout(delivery).then((value) {
        if (value.success) {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.SUCCES,
              animType: AnimType.BOTTOMSLIDE,
              tittle: S.of(context).success,
              desc: S.of(context).successfulCheckout,
              btnOkOnPress: () {
                CommonUtils.cart_list.clear();

                print("Cart List  ${CommonUtils.cart_list}");

                removeAllCarts();

                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/Tabs', ModalRoute.withName('/'),
                    arguments: 2);
              }).show();

          setState(() {
            loading = false;
          });
        } else {
          setState(() {
            loading = false;
          });

          _globalKey.currentState.showSnackBar(new SnackBar(
            content: new Text(
              S.of(context).failedToCheckout,
            ),
            backgroundColor: Colors.red,
          ));
        }
      });
    }
  }

  void removeAllCarts() async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    sp.remove(cart_list_key);
  }
}
