import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());



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

}

