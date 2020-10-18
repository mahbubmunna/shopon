import 'package:provider/provider.dart';
import 'package:sunbulahome/src/FlutterProvider/BrandProvider/BrandsProvider.dart';
import 'package:sunbulahome/src/FlutterProvider/CategoryProvider/CategoryProvider.dart';
import 'package:sunbulahome/src/FlutterProvider/FlashProvider/FlashProvider.dart';
import 'package:sunbulahome/src/models/route_argument.dart';
import 'package:sunbulahome/src/screens/brand.dart';
import 'package:sunbulahome/src/screens/brands.dart';
import 'package:sunbulahome/src/screens/cart.dart';
import 'package:sunbulahome/src/screens/category.dart';
import 'package:sunbulahome/src/screens/ShippingAddress.dart';
import 'package:sunbulahome/src/screens/checkout.dart';
import 'package:sunbulahome/src/screens/checkout_done.dart';
import 'package:sunbulahome/src/screens/delivery_map.dart';
import 'package:sunbulahome/src/screens/delivery_selection.dart';
import 'package:sunbulahome/src/screens/forgot_password.dart';
import 'package:sunbulahome/src/screens/help.dart';
import 'package:sunbulahome/src/screens/languages.dart';
import 'package:sunbulahome/src/screens/on_boarding.dart';
import 'package:sunbulahome/src/screens/orders.dart';
import 'package:sunbulahome/src/screens/payement_page.dart';
import 'package:sunbulahome/src/screens/product.dart';
import 'package:sunbulahome/src/screens/signin.dart';
import 'package:sunbulahome/src/screens/signup.dart';
import 'package:sunbulahome/src/screens/splash.dart';
import 'package:sunbulahome/src/screens/tabs.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
       return MaterialPageRoute(builder: (_) => SplashScreen());
      //return MaterialPageRoute(builder: (_) => DeliverySelect());
      case '/Onboard':
       return MaterialPageRoute(builder: (_) => OnBoardingWidget());
        //return MaterialPageRoute(builder: (_) => DeliverySelect());
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
      case '/CheckoutDone':
        return MaterialPageRoute(builder: (context) => CheckoutDoneWidget());
      case '/PaymentView':
        return MaterialPageRoute(builder: (context) => PaymentPage(routeArgument: args as RouteArgument,));

      case '/DeliveryMap':
        return MaterialPageRoute(builder: (_) => DeliveryMap());

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
