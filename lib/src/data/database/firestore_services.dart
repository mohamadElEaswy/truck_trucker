import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:truck_trucker/src/data/models/shipment_model.dart';

class FireStoreService {
  FireStoreService._();
  static final instance = FireStoreService._();
  //global method to send data to Cloud FireStore DataBases
  Future<void> setData(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // print('$path : $data');
    await reference.set(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getData(
      {required String path}) async {
    final DocumentReference<Map<String, dynamic>> reference =
        FirebaseFirestore.instance.doc(path);
    return await reference.get();
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    // print('delete $path');
    await reference.delete();
  }
  //1 create
  //2 push locations stream

  DocumentReference<Map<String, dynamic>> ref(String shipmentId) =>
      FirebaseFirestore.instance.doc('shipments/$shipmentId');

  Future shipmentData({required ShipmentModel data}) async {
    return await ref('shipmentId').get();
  }

  // launch or create main shipment
  Future startShipment(
      {required String shipmentId, required ShipmentModel data, required LocationModel locationModel,}) async {
    bool exists = await ref(shipmentId).get().then((value) => value.exists);
    if (!exists) {
      await ref(shipmentId).set(data.toJson());
      //  await pushLocation(shipmentId: shipmentId, data: data);
    }
    return await pushLocation(shipmentId: shipmentId, data: locationModel);
  }

  Future<DocumentReference<Map<String, dynamic>>> pushLocation(
          {required String shipmentId, required LocationModel data}) async =>
      await ref(shipmentId).collection('locations').add(data.toJson());

//Global method to get data from Cloud FireStore databases as a live stream
  Stream<List<T>> collectionStream<T>({
    required String? path,
    required T Function(dynamic data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = FirebaseFirestore.instance.collection(path!);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => builder(snapshot.data()!, snapshot.id));
  }
}
