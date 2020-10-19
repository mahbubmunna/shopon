
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sunbulahome/config/ui_icons.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/order_status.dart';
import 'package:sunbulahome/src/models/payment.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:sunbulahome/src/providers/shared_pref_provider.dart';
import 'package:sunbulahome/src/repositories/payment_repository.dart';
import 'package:sunbulahome/src/screens/splash.dart';
import 'package:sunbulahome/src/utils/common_utils.dart';
import 'package:sunbulahome/src/widgets/ShoppingCartButtonWidget.dart';


class CheckoutWidget extends StatefulWidget {
  final RouteArgument routeArgument;
  double orderPrice;

  CheckoutWidget({this.routeArgument}) {
    orderPrice = routeArgument.argumentsList[0] as double;
  }
  @override
  _CheckoutWidgetState createState() => _CheckoutWidgetState();
}

class _CheckoutWidgetState extends State<CheckoutWidget>
    with TickerProviderStateMixin{

  Animation animationCashOnDelivery;
  AnimationController animationCashOnDeliveryController;
  Animation<double> sizeCheckCashOnDeliveryAnimation;
  Animation<double> rotateCheckCashOnDeliveryAnimation;
  Animation<double> opacityCashOnDeliveryAnimation;
  Animation opacityCheckCashOnDeliveryAnimation;

  Animation animationOnlinePayment;
  AnimationController animationOnlinePaymentController;
  Animation<double> sizeCheckOnlinePaymentAnimation;
  Animation<double> rotateCheckOnlinePaymentAnimation;
  Animation<double> opacityOnlinePaymentAnimation;
  Animation opacityCheckOnlinePaymentAnimation;

  Animation animationStripe;
  AnimationController animationStripeController;
  Animation<double> sizeCheckStripeAnimation;
  Animation<double> rotateCheckStripeAnimation;
  Animation<double> opacityStripeAnimation;
  Animation opacityCheckStripeAnimation;

  String _paymentMethod;

  // Completer<GoogleMapController> _controller = Completer();
  // Geolocator geoLocator = Geolocator()..forceAndroidLocationManager;
  // Position _position;
  // Widget _child;
  // String _completeAddress = 'Not added';
  //
  // BitmapDescriptor _bitmapDescriptor;


  //static const LatLng _center = const LatLng(45.521563, -122.677433);

  // void _onMapCreated(GoogleMapController controller) {
  //   _controller.complete(controller);
  // }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _child = SpinKitDoubleBounce(color: Colors.black,);
    // getProperBitmap();
    // getCurrentLocation();
    animationOnlinePaymentController = AnimationController(duration: Duration(milliseconds: 350), vsync: this);
    CurvedAnimation curveOnlinePayment = CurvedAnimation(parent: animationOnlinePaymentController, curve: Curves.easeOut);
    animationOnlinePayment = Tween(begin: 0.0, end: 25.0).animate(curveOnlinePayment)
      ..addListener(() {
        setState(() {});
      });
    opacityOnlinePaymentAnimation = Tween(begin: 0.0, end: 0.85).animate(curveOnlinePayment)
      ..addListener(() {
        setState(() {});
      });
    opacityCheckOnlinePaymentAnimation = Tween(begin: 0.0, end: 1.0).animate(curveOnlinePayment)
      ..addListener(() {
        setState(() {});
      });
    rotateCheckOnlinePaymentAnimation = Tween(begin: 2.0, end: 0.0).animate(curveOnlinePayment)
      ..addListener(() {
        setState(() {});
      });
    sizeCheckOnlinePaymentAnimation = Tween<double>(begin: 0, end: 24).animate(curveOnlinePayment)
      ..addListener(() {
        setState(() {});
      });

    animationStripeController = AnimationController(duration: Duration(milliseconds: 350), vsync: this);
    CurvedAnimation curveStripe = CurvedAnimation(parent: animationStripeController, curve: Curves.easeOut);
    animationStripe = Tween(begin: 0.0, end: 25.0).animate(curveStripe)
      ..addListener(() {
        setState(() {});
      });
    opacityStripeAnimation = Tween(begin: 0.0, end: 0.85).animate(curveStripe)
      ..addListener(() {
        setState(() {});
      });
    opacityCheckStripeAnimation = Tween(begin: 0.0, end: 1.0).animate(curveStripe)
      ..addListener(() {
        setState(() {});
      });
    rotateCheckStripeAnimation = Tween(begin: 2.0, end: 0.0).animate(curveStripe)
      ..addListener(() {
        setState(() {});
      });
    sizeCheckStripeAnimation = Tween<double>(begin: 0, end: 24).animate(curveStripe)
      ..addListener(() {
        setState(() {});
      });

    animationCashOnDeliveryController = AnimationController(duration: Duration(milliseconds: 350), vsync: this);
    CurvedAnimation curveCashOnDelivery = CurvedAnimation(parent: animationCashOnDeliveryController, curve: Curves.easeOut);
    animationCashOnDelivery = Tween(begin: 0.0, end: 25.0).animate(curveCashOnDelivery)
      ..addListener(() {
        setState(() {});
      });
    opacityCashOnDeliveryAnimation = Tween(begin: 0.0, end: 0.85).animate(curveCashOnDelivery)
      ..addListener(() {
        setState(() {});
      });
    opacityCheckCashOnDeliveryAnimation = Tween(begin: 0.0, end: 1.0).animate(curveCashOnDelivery)
      ..addListener(() {
        setState(() {});
      });
    rotateCheckCashOnDeliveryAnimation = Tween(begin: 2.0, end: 0.0).animate(curveCashOnDelivery)
      ..addListener(() {
        setState(() {});
      });
    sizeCheckCashOnDeliveryAnimation = Tween<double>(begin: 0, end: 24).animate(curveCashOnDelivery)
      ..addListener(() {
        setState(() {});
      });

    animationOnlinePaymentController.forward();
  }
  // void getProperBitmap() async {
  //   await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(128, 128)), 'assets/img/location.png')
  //       .then((value) => _bitmapDescriptor = value);
  // }
  // void setCurrentPosition(Position _currentPosition) async {
  //   try {
  //     List<Placemark> p =  await geoLocator.placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);
  //
  //     Placemark place = p[0];
  //
  //     appUser.address = place.name;
  //     appUser.city = place.administrativeArea;
  //     appUser.postalCode = place.postalCode;
  //     appUser.country = place.country;
  //     appUser.area = place.locality;
  //
  //
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // void getCurrentLocation() async{
  //   Position res = await Geolocator().getCurrentPosition();
  //
  //   setState(() {
  //     _position = res;
  //     Marker _marker = Marker
  //       (markerId: MarkerId('currentLocation'),
  //         draggable: true,
  //         icon: _bitmapDescriptor,
  //         position: LatLng(_position.latitude, _position.longitude),
  //         onDragEnd: (value) {
  //           print(value.latitude);
  //           print(value.longitude);
  //           setState(() {
  //             setCurrentPosition(Position(latitude: value.latitude, longitude: value.longitude));
  //           });
  //         },
  //         infoWindow: InfoWindow(title: S.of(context).home,)
  //     );
  //
  //     final Map<String, Marker> _markers = {};
  //     _markers['currentLocation'] = _marker;
  //
  //     _child = GoogleMap(
  //       onMapCreated: _onMapCreated,
  //       initialCameraPosition: CameraPosition(
  //           target:  LatLng(_position.latitude, _position.longitude),
  //           zoom: 12
  //       ),
  //       markers: _markers.values.toSet(),
  //     );
  //     setCurrentPosition(_position);
  //
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    print('Checkout_test');
    print(CommonUtils.cart_list.asMap());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: new IconButton(
          icon: new Icon(UiIcons.return_icon, color: Theme.of(context).hintColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          S.of(context).checkout,
          style: Theme.of(context).textTheme.display1,
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Theme.of(context).hintColor, labelColor: Theme.of(context).accentColor),
//          Container(
//              width: 30,
//              height: 30,
//              margin: EdgeInsets.only(top: 12.5, bottom: 12.5, right: 20),
//              child: InkWell(
//                borderRadius: BorderRadius.circular(300),
//                onTap: () {
//                  Navigator.of(context).pushNamed('/Tabs', arguments: 1);
//                },
//                child: CircleAvatar(
//                  backgroundImage: NetworkImage(appUser.avatar),
//                ),
//              )),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    leading: Icon(
                      UiIcons.credit_card,
                      color: Theme.of(context).hintColor,
                    ),
                    title: Text(
                      S.of(context).paymentMode,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.display1,
                    ),
                    subtitle: Text(
                      S.of(context).selectYourPreferedPaymentMode,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ),
//            SizedBox(height: 20),
//            CreditCardsWidget(),

                SizedBox(height: 20),
//            Text(
//              'Or Checkout With',
//              style: Theme.of(context).textTheme.caption,
//            ),
//            SizedBox(height: 40),
                SizedBox(
                  width: 320,
                  child: FlatButton(
                    onPressed: () {
                      //Navigator.of(context).pushNamed('/CheckoutDone');
                      animationOnlinePaymentController.forward();
                      animationCashOnDeliveryController.reverse();
                      _paymentMethod ='online';

                    },
                    padding: EdgeInsets.symmetric(vertical: 12),
                    color: Theme.of(context).focusColor.withOpacity(0.2),
                    shape: StadiumBorder(),
                    child: Stack(
                        children:<Widget>[
                          Align(
                              alignment: Alignment(0, 0),
                              child: Text(
                                S.of(context).payOnline,
                                textScaleFactor: 1.2,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )
                          ),
                          Align(
                            alignment: Alignment(.9, 0),
                            child: Container(
                              height: animationOnlinePayment.value,
                              width: animationOnlinePayment.value,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                color: Theme.of(context).accentColor.withOpacity(opacityOnlinePaymentAnimation.value),
                              ),
                              child: Transform.rotate(
                                angle: rotateCheckOnlinePaymentAnimation.value,
                                child: Icon(
                                  Icons.check,
                                  size: sizeCheckOnlinePaymentAnimation.value,
                                  color: Theme.of(context).primaryColor.withOpacity(opacityCheckOnlinePaymentAnimation.value),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 320,
                  child: FlatButton(
                    onPressed: () {
                      //Navigator.of(context).pushNamed('/CheckoutDone');
                      animationCashOnDeliveryController.forward();
                      animationOnlinePaymentController.reverse();
                      _paymentMethod = 'cash';

                    },
                    padding: EdgeInsets.symmetric(vertical: 12),
                    color: Theme.of(context).focusColor.withOpacity(0.2),
                    shape: StadiumBorder(),
                    child: Stack(
                        children:<Widget>[
                          Align(
                            alignment: Alignment(0, 0),
                            child: Text(
                              S.of(context).payOnDelivery,
                              textScaleFactor: 1.2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Align(
                            alignment: Alignment(.9, 0),
                            child: Container(
                              height: animationCashOnDelivery.value,
                              width: animationCashOnDelivery.value,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                                color: Theme.of(context).accentColor.withOpacity(opacityCashOnDeliveryAnimation.value),
                              ),
                              child: Transform.rotate(
                                angle: rotateCheckCashOnDeliveryAnimation.value,
                                child: Icon(
                                  Icons.check,
                                  size: sizeCheckCashOnDeliveryAnimation.value,
                                  color: Theme.of(context).primaryColor.withOpacity(opacityCheckCashOnDeliveryAnimation.value),
                                ),
                              ),
                            ),
                          ),
                        ]
                    ),
                  ),
                ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(color: Theme.of(context).hintColor.withOpacity(0.15), offset: Offset(0, 3), blurRadius: 10)
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                primary: false,
                children: <Widget>[
//                  ListTile(
//                    leading: Icon(UiIcons.placeholder),
//                    title: Text(
//                      'Shipping Adress',
//                      style: Theme.of(context).textTheme.body2,
//                    ),
//                    trailing: ButtonTheme(
//                      padding: EdgeInsets.all(0),
//                      minWidth: 50.0,
//                      height: 25.0,
//                      child: ShippingAddressDialog(
//                        user: appUser,
//                        onChanged: () {
//                          setState(() {});
//                        },
//                      ),
//                    ),
//                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).address,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    trailing: Text(
                      appUser.address,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).area,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    trailing: Text(
                      appUser.area,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      S.of(context).city,
                      style: Theme.of(context).textTheme.body1,
                    ),
                    trailing: Text(
                      appUser.country,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),

//                ListTile(
//                  onTap: () {},
//                  dense: true,
//                  title: Text(
//                    'Birth Date',
//                    style: Theme.of(context).textTheme.body1,
//                  ),
//                  trailing: Text(
//                    appUser.getDateOfBirth(),
//                    style: TextStyle(color: Theme.of(context).focusColor),
//                  ),
//                ),
                ],
              ),
            ),
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '${S.of(context).sar} ${(widget.orderPrice).toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.display1.merge(TextStyle()),
                  ),
                ),
                SizedBox(height: 5,),
                Stack(
                  fit: StackFit.loose,
                  alignment: AlignmentDirectional.centerEnd,
                  children: <Widget>[
                    SizedBox(
                      width: 320,
                      child: MaterialButton(
                        elevation: 8,
                        onPressed: () {

                          Map shippingInfo = {
                            'email': appUser.email,
                            'address': appUser.address,
                            'city': appUser.city,
                            'country': appUser.country
                          };

                          var carts = CommonUtils.payment_cart_list.map((e) => json.decode(e)).toList();

                          print('cartMapTest');
                          print(carts);

                          Map<String, dynamic> paymentCheckoutBody = {
                            'shipping_info': shippingInfo,
                            'payment_method': _paymentMethod,
                            'locale': 'en',
                            'cart': carts
                          };
                          PaymentCheckoutRepository.postPaymentCheckout(paymentCheckoutBody).then((value){
                            print('checkout_id');
                            print(value.paymentCheckout.results.checkoutId);
                            // SharedPrefProvider.clearKey(cart_list_key);
                            // CommonUtils.payment_cart_list.clear();
                            // CommonUtils.cart_list.clear();
                            if (_paymentMethod == 'cash') {
                              SharedPrefProvider.clearKey(cart_list_key);
                              CommonUtils.payment_cart_list.clear();
                              CommonUtils.cart_list.clear();
                              Navigator.of(context).pushNamed('/CheckoutDone');
                            } else {
                              List _arguments = [value.paymentCheckout.results.checkoutId, value.paymentCheckout.results.orderId];
                              lastOrderId = value.paymentCheckout.results.orderId;
                              Navigator.of(context).pushNamed('/PaymentView',
                                  arguments: RouteArgument(argumentsList: _arguments)).then((value) {
                                SharedPrefProvider.clearKey(cart_list_key);
                                CommonUtils.payment_cart_list.clear();
                                CommonUtils.cart_list.clear();
                                    clearCartOrNot(value);
                                Navigator.of(context).pushNamedAndRemoveUntil('/Tabs',  ModalRoute.withName('/'), arguments: 0);
                              });
                            }
                          });
                          //Navigator.of(context).pushNamed('/CheckoutDone');
                        },
                        padding: EdgeInsets.symmetric(vertical: 14),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            S.of(context).confirmPayment,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // SizedBox(height: 40,),
            // SizedBox(
            //   height: 200,
            //   child: _child,
            // )
          ],
        )
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationOnlinePaymentController.dispose();
    animationCashOnDeliveryController.dispose();
    animationStripeController.dispose();
  }

  void clearCartOrNot(PaymentCheckout value) async {
    print('Mahbub');
    Dio _dio = Dio();
    await _dio.post("$otp_base_url/checkout/status", data: {'order_id': lastOrderId}).then((value) {
      print('check status $value');
      OrderStatus orderStatus = OrderStatus.fromJson(value.data);
      if (orderStatus.results.success == true) {
        SharedPrefProvider.clearKey(cart_list_key);
        CommonUtils.payment_cart_list.clear();
        CommonUtils.cart_list.clear();
      }
    });
  }
}


int lastOrderId;