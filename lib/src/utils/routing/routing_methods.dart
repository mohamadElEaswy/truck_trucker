import 'package:flutter/widgets.dart';

class RoutingMethods {
  static Future<void> pushNamed({
    required BuildContext context,
    required String route,
    Object? arguments,
  }) =>
      Navigator.pushNamed(
        context,
        route,
        arguments: arguments,
      );
  static void replaceNamed({
    required BuildContext context,
    required String route,
    Object? arguments,
  }) =>
      Navigator.pushReplacementNamed(
        context,
        route,
        arguments: arguments,
      );

  static void popNamed({required BuildContext context}) =>
      Navigator.pop(context);
}
