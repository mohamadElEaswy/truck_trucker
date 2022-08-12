import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:truck_trucker/src/data/models/user_model.dart';
import '../models/shipment_model.dart';
import 'firestore_services.dart';

abstract class Database {
  Future<void> setUser({required UserModel userModel, required User user});
  Future<UserModel?> getUserData(String id);
  Future<void> pushShipmentData({required String shipmentId, required ShipmentModel data});
  // Stream<Object> streamCurrentLocation(
  //     {required String id, required String shipmentId});
}

// String currentDate() => DateTime.now().toIso8601String();

class FireStoreDatabase implements Database {
  // FireStoreDatabase._();
  // static final instance = FireStoreDatabase._();
  final FireStoreService _service = FireStoreService.instance;
  UserModel? userModel;
  @override
  Future<void> setUser(
      {required UserModel userModel, required User user}) async {
    await _service.setData(
      path: 'users/${user.uid}',
      data: userModel.toJson(),
    );
  }

  @override
  Future<UserModel?> getUserData(String id) async {
    return _service.getData(path: 'users/$id').then((value) {
      return UserModel.fromJson(value.data()!);
    });
  }
  @override
  Future pushShipmentData({required String shipmentId, required ShipmentModel data}) async {
    return await _service.startShipment(
      shipmentId: shipmentId,
      data: data,
    );
  }

  // @override
  // Stream<Object> streamCurrentLocation(
  //     {required String id, required String shipmentId}) {
  //   return _service.collectionStream(
  //     path: 'shipment_id/$id',
  //     builder: (dynamic data, String shipmentId) {},
  //   );
  // }
}
