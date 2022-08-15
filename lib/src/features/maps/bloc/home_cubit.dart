import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:permission_handler/permission_handler.dart';
import 'package:truck_trucker/src/data/models/shipment_model.dart';
import '../../../domain/repository/repository_controller.dart';
import '../../../injection.dart' as di;
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  StreamSubscription<loc.LocationData>? locationSubscription;
  final loc.Location location = loc.Location();

  GoogleMapController? mapController;

  final Map<String, Marker> markers = {};
  // final List<Polyline> polyline = [];
  List<LatLng> routeCoords = [];
  LatLng center = const LatLng(30.0444, 31.2357);

  Map<PolylineId, Polyline> mapPolylines = {};
  int polylineIdCounter = 1;
  void add(List<LocationModel> list) {
    final String polylineIdVal = 'polyline_id_$polylineIdCounter';
    polylineIdCounter++;
    final PolylineId polylineId = PolylineId(polylineIdVal);

    final Polyline polyline = Polyline(
      polylineId: polylineId,
      consumeTapEvents: true,
      color: Colors.deepPurple,
      width: 5,
      points: createPoints(list),
    );

    // setState(() {
    mapPolylines[polylineId] = polyline;
  }

  // );
  List<LatLng> createPoints(List<LocationModel>? list) {
    List<LatLng> points = [];
    routeCoords =[];
    mapPolylines = {};
    points = list!.map((e) => LatLng(e.latitude, e.longitude)).toList();
    emit(HomeSuccess());

    return points;
  }

  Future<void> onMapCreated(GoogleMapController controller) async {

    mapController = controller;

    polylineIdCounter = 1;
    markers.clear();


  }

  Future<void> changeMapView(
      {required double latitude, required double longitude}) async {
    return await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 50),
      ),
    );
  }

  Future pushShipmentData({
    required ShipmentModel shipmentModel,
    required String shipmentId,
    required LocationModel locationModel,
  }) async {
    await di.serviceLocator.get<RepositoryController>().pushShipmentData(
        data: shipmentModel,
        shipmentId: shipmentId,
        locationModel: locationModel);
  }

  LocationModel locationModel = LocationModel(
    createdAt: DateTime.now(),
    latitude: 0.0,
    longitude: 0.0,
  );
  Future startShipmentStream({
    required String shipmentId,
    required ShipmentModel shipmentModel,
  })  async{
    // location.
    // await location.changeSettings(
    //   interval: 1000,
    //   distanceFilter: 100.0,
    // );
    location.enableBackgroundMode();
    // locationSubscription! = location;

    locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      stopListening();
    }).listen((loc.LocationData currentLocation) {
      // Future.delayed(const Duration(seconds: 90));
      locationModel = LocationModel(
        createdAt: DateTime.now(),
        latitude: currentLocation.latitude!,
        longitude: currentLocation.longitude!,
      );
      pushShipmentData(
        shipmentId: shipmentId,
        locationModel: locationModel,
        shipmentModel: shipmentModel,
      );
    });
    locationSubscription!.resume();
  }

  stopListening() {
    locationSubscription?.cancel();
    locationSubscription = null;
  }

  Future requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('permission done');
    } else if (status.isDenied) {
      requestPermission();
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Stream<List<ShipmentModel>> shipmentData() {
    return collectionStream(
      path: 'shipments',
      builder: (data, id) {
        return ShipmentModel.fromJson(data);
      },
    );
  }

  Stream<ShipmentModel> singleShipmentData(String shipmentId) {
    return documentStream(
      path: 'shipments/$shipmentId',
      builder: (data, id) {
        return ShipmentModel.fromJson(data!);
      },
    );
  }

  Stream<List<LocationModel>?> locationsData(String shipmentId) {
    emit(MapLoading());
    Stream<List<LocationModel>> stream = collectionStream<LocationModel>(
      path: 'shipments/$shipmentId/locations',
      builder: (data, id) {
        return LocationModel.fromJson(data);
      },
    ).handleError((error) {
      emit(MapError());
    });
    // add(stream);
    // data(stream);

    return stream;
  }

  List<LocationModel>? routListData = [];
  Future<List<LocationModel>?> getLocationsList(String shipmentId) async {
    routListData!.clear();
    emit(MapLoading());
    return await FirebaseFirestore.instance
        .collection('shipments')
        .doc(shipmentId)
        .collection('locations')
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      routListData =
          value.docs.map((e) => LocationModel.fromJson(e.data())).toList();

      add(routListData!);
      emit(MapSuccess(
          data: value.docs
              .map((e) => LocationModel.fromJson(e.data()))
              .toList()));
      add(routListData!);
    }).catchError((e) {
      print(e);
      emit(MapError());
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
}
