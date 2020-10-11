import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sunbulahome/generated/l10n.dart';
import 'package:sunbulahome/src/configs/strings.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:sunbulahome/src/providers/shared_pref_provider.dart';
import 'package:sunbulahome/src/screens/splash.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentPage extends StatefulWidget {
  String checkoutID;
  int orderId;
  RouteArgument routeArgument;
  PaymentPage({this.routeArgument}) {
    checkoutID = routeArgument.argumentsList[0] as String;
    orderId = routeArgument.argumentsList[1] as int;

  }

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  WebViewController _webViewController;
  String token;
  bool _showLoader = true;

  @override
  void initState() {
    //Future.delayed(Duration(seconds: 3), stopLoader);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).onlinePayment),),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _webViewController = webViewController;
                loadPaymentHtml();
              },
              onPageFinished: (_) {
                setState(() {
                  _showLoader = false;
                });
              },
            ),
          ),
          _showLoader ? Center(child: SpinKitCubeGrid(color: Theme.of(context).accentColor,)): Container(),
        ],
      )
    );
  }

  loadPaymentHtml() {
    String html = '<!DOCTYPE html> <html lang="en"> <head> <meta charset="UTF-8"> <meta name="viewport" content="width=device-width, initial-scale=1.0"> <title>Payment</title> </head> <body> <section class="py-3 gry-bg"> <div class="container"> <div class="col-lg-8> <div class="card"> <div class="card-body"> <form method="POST" action="http://157.175.91.49/api/checkout/" class="paymentWidgets" data-brands="VISA MASTER AMEX"><input type="hidden" name="order_id" value="${widget.orderId}"><input type="hidden" name="email" value="${appUser.email}"><input type="hidden" name="checkout_id" value="${widget.checkoutID}"></form> </div> </div> </div> </div> </section> <!-- Script --> <script src="https://oppwa.com/v1/paymentWidgets.js?checkoutId=${widget.checkoutID}"></script> <!-- <script type="text/javascript"> function use_wallet(){ \$(\'input[name=payment_option]\').val(\'wallet\'); \$(\'#checkout-form\').submit(); } </script> --> </body> </html>';
    print(html);
    _webViewController.loadUrl(Uri.dataFromString(html, mimeType: 'text/html').toString());
  }

  stopLoader() {
    setState(() {
      _showLoader = false;
    });
  }


}
