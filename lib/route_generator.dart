import 'package:flutter/material.dart';

import 'models/route_argument.dart';
// import 'pages/cart.dart';
// import 'pages/category.dart';
// import 'pages/checkout.dart';
// import 'pages/debug.dart';
// import 'pages/delivery_addresses.dart';
// import 'pages/delivery_pickup.dart';
// import 'pages/details.dart';
// import 'pages/forget_password.dart';
// import 'pages/help.dart';
// import 'pages/languages.dart';
// import 'pages/login.dart';
// import 'pages/menu_list.dart';
// import 'pages/order_success.dart';
// import 'pages/pages.dart';
// import 'pages/payment_methods.dart';
// import 'pages/paypal_payment.dart';
// import 'pages/product.dart';
// import 'pages/profile.dart';
// import 'pages/reviews.dart';
// import 'pages/settings.dart';
// import 'pages/signup.dart';
import 'pages/splash_screen.dart';
// import 'pages/tracking.dart';
// import 'pages/walkthrough.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    switch (settings.name) {
      // case '/Debug':
      //   return MaterialPageRoute(
      //       builder: (_) => DebugWidget(routeArgument: args as RouteArgument));
      // case '/Walkthrough':
      //   return MaterialPageRoute(builder: (_) => Walkthrough());
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      // case '/SignUp':
      //   return MaterialPageRoute(builder: (_) => SignUpWidget());
      // case '/MobileVerification':
      //   return MaterialPageRoute(builder: (_) => SignUpWidget());
      // case '/MobileVerification2':
      //   return MaterialPageRoute(builder: (_) => SignUpWidget());
      // case '/Login':
      //   return MaterialPageRoute(builder: (_) => LoginWidget());
      // case '/Profile':
      //   return MaterialPageRoute(builder: (_) => ProfileWidget());
      // case '/ForgetPassword':
      //   return MaterialPageRoute(builder: (_) => ForgetPasswordWidget());
      // case '/Pages':
      //   return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: args));
      // case '/Details':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           DetailsWidget(routeArgument: args as RouteArgument));
      // case '/Menu':
      //   return MaterialPageRoute(
      //       builder: (_) => MenuWidget(routeArgument: args as RouteArgument));
      // case '/Product':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           ProductWidget(routeArgument: args as RouteArgument));
      // case '/Category':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           CategoryWidget(routeArgument: args as RouteArgument));
      // case '/Cart':
      //   return MaterialPageRoute(
      //       builder: (_) => CartWidget(routeArgument: args as RouteArgument));
      // case '/Tracking':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           TrackingWidget(routeArgument: args as RouteArgument));
      // case '/Reviews':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           ReviewsWidget(routeArgument: args as RouteArgument));
      // case '/PaymentMethod':
      //   return MaterialPageRoute(builder: (_) => PaymentMethodsWidget());
      // case '/DeliveryAddresses':
      //   return MaterialPageRoute(builder: (_) => DeliveryAddressesWidget());
      // case '/DeliveryPickup':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           DeliveryPickupWidget(routeArgument: args as RouteArgument));
      // case '/Checkout':
      //   return MaterialPageRoute(builder: (_) => CheckoutWidget());
      // case '/CashOnDelivery':
      //   return MaterialPageRoute(
      //       builder: (_) => OrderSuccessWidget(
      //           routeArgument: RouteArgument(param: 'Cash on Delivery')));
      // case '/PayOnPickup':
      //   return MaterialPageRoute(
      //       builder: (_) => OrderSuccessWidget(
      //           routeArgument: RouteArgument(param: 'Pay on Pickup')));
      // case '/PayPal':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           PayPalPaymentWidget(routeArgument: args as RouteArgument));
      // case '/OrderSuccess':
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           OrderSuccessWidget(routeArgument: args as RouteArgument));
      // case '/Languages':
      //   return MaterialPageRoute(builder: (_) => LanguagesWidget());
      // case '/Help':
      //   return MaterialPageRoute(builder: (_) => HelpWidget());
      // case '/Settings':
      //   return MaterialPageRoute(builder: (_) => SettingsWidget());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return null;
      // return MaterialPageRoute(builder: (_) => PagesWidget(currentTab: 2));
    }
  }
}
