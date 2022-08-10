import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck_trucker/src/features/auth/bloc/states.dart';
import '../../../data/database/database.dart';
import '../../../data/models/user_model.dart';
import '../../../injection.dart' as di;
import '../../../data/network/auth.dart';
import '../../../utils/routing/named_routs.dart';
import '../../../utils/routing/routing_methods.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  AuthBase auth = di.serviceLocator.get<AuthBase>();
  static AuthCubit get(context) => BlocProvider.of(context);

  void submit({
    required BuildContext context,
    required String name,
    required String phone,
  }) async {
    emit(AuthLoading());
    User? user = auth.currentUser;
    await auth.signInAnonymously().then((User? user) {
      di.serviceLocator.get<Database>().setUser(
            user: user!,
            userModel: UserModel(
              name: name,
              id: user.uid,
              phone: phone,
            ),
          );

      RoutingMethods.replaceNamed(context: context, route: NamedRouts.home);
    }).catchError((error) {});

    emit(AuthSuccess());
  }
}
