import 'package:flutter/material.dart';
import 'package:smartcommercebd/config/ui_icons.dart';
import 'package:smartcommercebd/src/models/route_argument.dart';
import 'package:smartcommercebd/src/screens/splash.dart';
import 'package:smartcommercebd/src/widgets/ShoppingCartButtonWidget.dart';


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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
  }
  @override
  Widget build(BuildContext context) {

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
          'Checkout',
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
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
                  'Payment Mode',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.display1,
                ),
                subtitle: Text(
                  'Select your prefered payment mode',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
//            SizedBox(height: 20),
//            CreditCardsWidget(),

            SizedBox(height: 40),
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

                },
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Theme.of(context).focusColor.withOpacity(0.2),
                shape: StadiumBorder(),
                child: Stack(
                    children:<Widget>[
                      Align(
                        alignment: Alignment(0, 0),
                        child: Image.asset(
                          'assets/img/pay_online.png',
                          height: 28,
                        ),
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

                },
                padding: EdgeInsets.symmetric(vertical: 12),
                color: Theme.of(context).focusColor.withOpacity(0.2),
                shape: StadiumBorder(),
                child: Stack(
                    children:<Widget>[
                      Align(
                        alignment: Alignment(0, 0),
                        child: Image.asset(
                          'assets/img/cash_on_delivery.png',
                          height: 28,
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
            SizedBox(height: 40),
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
                      'Address',
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
                      'City',
                      style: Theme.of(context).textTheme.body1,
                    ),
                    trailing: Text(
                      appUser.city,
                      style: TextStyle(color: Theme.of(context).focusColor),
                    ),
                  ),
                  ListTile(
                    onTap: () {},
                    dense: true,
                    title: Text(
                      'Country',
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
            Stack(
              fit: StackFit.loose,
              alignment: AlignmentDirectional.centerEnd,
              children: <Widget>[
                SizedBox(
                  width: 320,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/CheckoutDone');
                    },
                    padding: EdgeInsets.symmetric(vertical: 14),
                    color: Theme.of(context).accentColor,
                    shape: StadiumBorder(),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'Confirm Payment',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '\$${widget.orderPrice}',
                    style: Theme.of(context).textTheme.display1.merge(TextStyle(color: Theme.of(context).primaryColor)),
                  ),
                )
              ],
            ),
          ],
        ),
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
}
