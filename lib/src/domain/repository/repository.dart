import 'package:flutter/foundation.dart';
import 'package:truck_trucker/src/data/models/shipment_model.dart';

import '../../data/database/database.dart';
import '../../data/models/user_model.dart';
import '../../data/network/auth.dart';
import '../../injection.dart' as di;

abstract class MainRepository {
  Future<UserModel?> getUserData();
  UserModel? userModel;
  Future<void> signOut();
  Future pushShipmentData(
      {required String shipmentId,
      required ShipmentModel data,
      required LocationModel locationModel});
}

class Repository implements MainRepository {
  AuthBase auth = di.serviceLocator.get<AuthBase>();
  Database database = di.serviceLocator.get<Database>();
  @override
  UserModel? userModel;
  @override
  Future<UserModel?> getUserData() async {
    return await database
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

  @override
  Future pushShipmentData(
      {required String shipmentId,
      required ShipmentModel data,
      required LocationModel locationModel}) async {
    return await database.pushShipmentData(
      shipmentId: shipmentId,
      data: data,
      locationModel: locationModel,
    );
  }
}
