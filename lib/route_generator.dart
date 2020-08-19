import 'package:provider/provider.dart';
import 'package:smartcommercebd/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/CategoryProvider/CategoryProvider.dart';
import 'package:smartcommercebd/src/FlutterProvider/FlashProvider/FlashProvider.dart';
import 'package:smartcommercebd/src/models/route_argument.dart';
import 'package:smartcommercebd/src/screens/brand.dart';
import 'package:smartcommercebd/src/screens/brands.dart';
import 'package:smartcommercebd/src/screens/cart.dart';
import 'package:smartcommercebd/src/screens/category.dart';
import 'package:smartcommercebd/src/screens/ShippingAddress.dart';
import 'package:smartcommercebd/src/screens/checkout.dart';
import 'package:smartcommercebd/src/screens/delivery_selection.dart';
import 'package:smartcommercebd/src/screens/forgot_password.dart';
import 'package:smartcommercebd/src/screens/help.dart';
import 'package:smartcommercebd/src/screens/languages.dart';
import 'package:smartcommercebd/src/screens/on_boarding.dart';
import 'package:smartcommercebd/src/screens/orders.dart';
import 'package:smartcommercebd/src/screens/product.dart';
import 'package:smartcommercebd/src/screens/signin.dart';
import 'package:smartcommercebd/src/screens/signup.dart';
import 'package:smartcommercebd/src/screens/splash.dart';
import 'package:smartcommercebd/src/screens/tabs.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
       return MaterialPageRoute(builder: (_) => SplashScreen());
     // return MaterialPageRoute(builder: (_) => DeliverySelect());
      case '/Onboard':
        return MaterialPageRoute(builder: (_) => OnBoardingWidget());
      case '/DeliverySelection':
        return MaterialPageRoute(builder: (_) => DeliverySelect());
      case '/ForgotPassword':
        return MaterialPageRoute(builder: (_) => ForgotPasswordWidget());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => SignInWidget());
      /*case '/Categories':
        return MaterialPageRoute(
            builder: (_) =>
                CategoriesWidget(routeArgument: args as RouteArgument));*/
      case '/Orders':
        return MaterialPageRoute(builder: (_) => OrdersWidget());
      case '/Brands':
        return MaterialPageRoute(builder: (context) => BrandsWidget());

      case '/Brand':
        return MaterialPageRoute(
            builder: (_) => BrandWidget(routeArgument: args as RouteArgument));
//      case '/MobileVerification':
//        return MaterialPageRoute(builder: (_) => MobileVerification());
//      case '/MobileVerification2':
//        return MaterialPageRoute(builder: (_) => MobileVerification2());
      case '/Tabs':
        return MaterialPageRoute(
            builder: (_) => TabsWidget(
                  currentTab: args,
                ));
      case '/Category':
        return MaterialPageRoute(
            builder: (_) =>
                CategoryWidget(routeArgument: args as RouteArgument));

      case '/Checkout':
        return MaterialPageRoute(builder: (_) => CheckoutWidget(routeArgument: args as RouteArgument,));


    //    case '/Product':
      //   return MaterialPageRoute(
      // builder: (_) =>
      //    ProductWidget(routeArgument: args as RouteArgument));
//      case '/Food':
//        return MaterialPageRoute(
//            builder: (_) => FoodWidget(
//              routeArgument: args as RouteArgument,
//            ));
      case '/Cart':
        return MaterialPageRoute(builder: (_) => CartWidget());
      /*  case '/Checkout':
        return MaterialPageRoute(builder: (_) => CheckoutWidget());*/
//      case '/CheckoutDone':
//        return MaterialPageRoute(builder: (_) => CheckoutDoneWidget());
      case '/Help':
        return MaterialPageRoute(builder: (_) => HelpWidget());
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
//      case '/second':
//      // Validation of correct data type
//        if (args is String) {
//          return MaterialPageRoute(
//            builder: (_) => SecondPage(
//              data: args,
//            ),
//          );
//        }
//        // If args is not of the correct type, return an error page.
//        // You can also throw an exception while in development.
//        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
