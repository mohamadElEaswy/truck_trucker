import 'package:truck_trucker/src/data/models/user_model.dart';
import 'package:truck_trucker/src/domain/repository/repository.dart';

import '../../data/models/shipment_model.dart';

class RepositoryController {
  final MainRepository _repository = Repository();

  Future<UserModel?> getUserData() async {
    return await _repository.getUserData();
  }

  Future<void> signOut() async {
    return await _repository.signOut();
  }

  Future pushShipmentData(
      {required String shipmentId,
      required ShipmentModel data,
      required LocationModel locationModel}) async {
    return await _repository.pushShipmentData(
      shipmentId: shipmentId,
      data: data,
      locationModel: locationModel,
    );
  }
}
