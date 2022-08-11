import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:truck_trucker/src/features/home/ui/home_page.dart';
import '../../../injection.dart' as di;
import '../../../data/network/auth.dart';

import 'anonymous_sign_in.dart';

class CheckCurrentUser extends StatelessWidget {
  const CheckCurrentUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthBase auth = di.serviceLocator.get<AuthBase>();
    return StreamBuilder<User?>(
      stream: auth.authUserState(),
      builder: (context, snapshot) {
        final User? user = snapshot.data;
        if (user != null) {
          return const HomePage();
        } else if (user == null) {
          return const AuthPage();
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
