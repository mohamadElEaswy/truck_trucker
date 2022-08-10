import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truck_trucker/src/features/home/ui/home_page.dart';
import '../../../injection.dart' as di;
import '../../../data/network/auth.dart';
import '../../../utils/routing/named_routs.dart';
import '../../../utils/routing/routing_methods.dart';
import 'anonymous_sign_in.dart';

class CheckCurrentUser extends StatelessWidget {
  const CheckCurrentUser({Key? key}) : super(key: key);

  // void initState() {
  //   super.initState();
  //   if (auth.currentUser != null) {
  //     RoutingMethods.replaceNamed(context: context, route: NamedRouts.home);
  //   } else {
  //     RoutingMethods.replaceNamed(context: context, route: NamedRouts.authPage);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    AuthBase auth = di.serviceLocator.get<AuthBase>();
    return StreamBuilder<User?>(
        stream: auth.authUserState(),
        builder: (context, snapshot) {
          final User? user = snapshot.data;
          if (user != null) {
            return const HomePage();
            // RoutingMethods.replaceNamed(
            //     context: context, route: NamedRouts.home);
          } else {
            return const AuthPage();
            // RoutingMethods.replaceNamed(
            //     context: context, route: NamedRouts.authPage);
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
