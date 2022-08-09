import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../features/auth/ui/anonymous_sign_in.dart';
import '../../features/home/ui/home_page.dart';

Map<String, Widget Function(BuildContext)> routs = {
  NamedRouts.init: (context) => const AuthPage(),
  NamedRouts.home: (context) => const HomePage(),
  // NamedRouts.home: (context) => const BottomTabNavigator(),
  // NamedRouts.singleProductPage: (context) => const SingleProductsPage(),
  // NamedRouts.secondPage: (context) => const SecondPage(),
  // NamedRouts.productsGridPage: (context) => const ProductGridPage(),
};

class NamedRouts {
  static const String init = '/';
  static const String home = '/home';
}
