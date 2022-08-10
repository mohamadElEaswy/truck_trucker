import 'package:flutter/foundation.dart';

import '../../data/database/database.dart';
import '../../data/models/user_model.dart';
import '../../data/network/auth.dart';
import '../../injection.dart' as di;

abstract class MainRepository {
  Future<UserModel?> getUserData();
  UserModel? userModel;
  Future<void> signOut();
}

class Repository implements MainRepository {
  AuthBase auth = di.serviceLocator.get<AuthBase>();
  @override
  UserModel? userModel;
  @override
  Future<UserModel?> getUserData() async {
    return await di.serviceLocator
        .get<Database>()
        .getUserData(auth.currentUser!.uid)
        .then((value) => userModel = value)
        .catchError((Object? error) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
  @override
  Future<void> signOut() async {
    await auth.signOut();
  }
}
