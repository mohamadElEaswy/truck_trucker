import 'package:flutter/material.dart';
import '../../features/auth/ui/anonymous_sign_in.dart';
import '../../features/auth/ui/check_current_user.dart';
import '../../features/home/ui/home_page.dart';
import '../../features/maps/ui/map_page.dart';
import '../../features/start_shipment/start_shipment_page.dart';
import '../../global_widgets/internet_checker/network_error.dart';

Map<String, Widget Function(BuildContext)> routs = {
  NamedRouts.checkInternetConnection: (context) =>
  const InternetCheck(online: CheckCurrentUser()),
  NamedRouts.authPage: (context) => const AuthPage(),
  NamedRouts.home: (context) => const HomePage(),
  NamedRouts.mapPage: (context) => const MapPage(),
  NamedRouts.shipmentFormPage: (context) => const StartShipmentPage(),

  // NamedRouts.singleProductPage: (context) => const SingleProductsPage(),
  // NamedRouts.secondPage: (context) => const SecondPage(),
  // NamedRouts.productsGridPage: (context) => const ProductGridPage(),
};

class NamedRouts {
  static const String checkInternetConnection = '/';
  static const String authPage = '/auth_page';
  static const String home = '/home';
  static const String mapPage = '/mapPage';
  static const String shipmentFormPage = '/shipmentFormPage';
  // static const String checkInternetConnection = '/check_internet_connection';
}
