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

  // Future locationPermission() async {
  //   final permission = await location.hasPermission();
  //   location.requestPermission();
  //   if (permission != loc.PermissionStatus.granted) {
  //     return location.requestPermission();
  //   } else {
  //     return location.requestPermission();
  //   }
  // }

  GoogleMapController? mapController;

  final Map<String, Marker> markers = {};
  LatLng center = const LatLng(30.0444, 31.2357);

  // List<Cars> data = [];

  Future<void> onMapCreated(GoogleMapController controller) async {
    // emit(LoadingMapsState());
    // data.clear();
    // await database.getLocationsList().then(
    //       (List<Cars> value) {
    //     data.addAll(value);
    //   },
    // );

    // final carsList = await locations.getGoogleOffices();

    mapController = controller;

    // data = googleOffices.offices;

    markers.clear();
    // await calculateDistance();
    // for (final car in data) {
    //   final icon = await BitmapDescriptor.fromAssetImage(
    //     const ImageConfiguration(size: Size(30, 30), devicePixelRatio: 2.5),
    //     AppAssets.carIcon,
    //   );
    //   final marker = Marker(
    //     visible: true,
    //     markerId: MarkerId(car.name),
    //     position: LatLng(car.lat, car.lng),
    //     infoWindow: InfoWindow(
    //       title: car.name,
    //       snippet: car.address,
    //     ),
    //     icon: icon,
    //   );
    //   markers[car.name] = marker;
    // }
    // emit(SuccessMapsState());
  }

//this method is to change the map view in the home
  Future<void> changeMapView(
      {required double latitude, required double longitude}) async {
    return await mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(latitude, longitude), zoom: 17),
      ),
    );
  }

  _getLocation() async {
    try {
      final loc.LocationData locationResult = await location.getLocation();
      print(locationResult);
      // await FirebaseFirestore.instance.collection('location').doc('user1').set({
      //   'latitude': _locationResult.latitude,
      //   'longitude': _locationResult.longitude,
      //   'name': 'john'
      // },
      //     SetOptions(merge: true));
    } catch (e) {
      print(e);
    }
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
  Future<void> startShipmentStream({
    required String shipmentId,
    required ShipmentModel shipmentModel,
  }) async {
    location.changeSettings(interval: 3000, distanceFilter: 10.0);
    locationSubscription = location.onLocationChanged.handleError((onError) {
      print(onError);
      stopListening();
    }).listen((loc.LocationData currentLocation) {
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
    })
        // listen(
        //   (loc.LocationData currentLocation) async {
        //
        //     // di.serviceLocator.get<RepositoryController>().pushShipmentData(shipmentId: shipmentId, data: data.t);
        //     // await FirebaseFirestore.instance
        //     //     .collection('shipments')
        //     //     .doc('shipment_id').collection('data')
        //     //     .add(
        //     //   {
        //     //     'latitude': currentLocation.latitude,
        //     //     'longitude': currentLocation.longitude,
        //     //     'shipment_id': 'shipment_id',
        //     //     'createdAt': DateTime.now()
        //     //   },
        //     //   // SetOptions(merge: true)
        //     // );
        //   },
        // )
        ;
  }

  stopListening() {
    locationSubscription?.cancel();
    // setState(() {
    locationSubscription = null;
    // });
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

  // Stream<List<ShipmentModel>>
  shipmentData() async* {
    await FirebaseFirestore.instance
        .collection('shipments')
        .snapshots()
        .listen((event) {
          event.docs.forEach((element) {
            print(element.data());
            // ShipmentModel.fromJson( element.data(), 'documentId');
          });

    });
    // collectionStream<ShipmentModel>(
    //   path: 'shipments',
    //   builder: (data, documentID) => ShipmentModel.fromJson(data, documentID),
    // );
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
    print('sssssssssssss');
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
