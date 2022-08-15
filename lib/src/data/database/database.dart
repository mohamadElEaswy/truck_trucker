import 'package:firebase_auth/firebase_auth.dart';
import 'package:truck_trucker/src/data/models/user_model.dart';
import '../models/shipment_model.dart';
import 'firestore_services.dart';

abstract class Database {
  Future<void> setUser({required UserModel userModel, required User user});
  Future<UserModel?> getUserData(String id);
  Future<void> pushShipmentData({
    required String shipmentId,
    required ShipmentModel data,
    required LocationModel locationModel,
  });
  Future getData(
      {required String path});
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
  Future pushShipmentData({
    required String shipmentId,
    required ShipmentModel data,
    required LocationModel locationModel,
  }) async {
    return await _service.startShipment(
      shipmentId: shipmentId,
      data: data,
      locationModel: locationModel,
    );
  }

  Future pushLocation({
    required String shipmentId,
    required LocationModel locationModel,
  }) async {
    return await _service.pushLocation(
        shipmentId: shipmentId, data: locationModel);
  }

  @override
  Future getData(
      {required String path}) async {
    return await _service.getData(path: path);
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
