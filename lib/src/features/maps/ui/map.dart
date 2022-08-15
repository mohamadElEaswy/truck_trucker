import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:truck_trucker/src/global_widgets/global_loading.dart';

import '../bloc/home_cubit.dart';

class HomeMap extends StatefulWidget {
  const HomeMap({Key? key, required this.bloc, required this.shipmentId})
      : super(key: key);
  final HomeCubit bloc;
  final String shipmentId;

  @override
  State<HomeMap> createState() => _HomeMapState();
}

class _HomeMapState extends State<HomeMap> {
  @override
  void initState() {
    super.initState();
    widget.bloc.getLocationsList(widget.shipmentId);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bloc.routListData != null) {
      return Container(
        color: Colors.cyan[100],
        child: Center(
          child: GoogleMap(
            // polylines: Set<Polyline>.of(bloc.polyLines.values),
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            zoomGesturesEnabled: true,
            // myLocationButtonEnabled: true,
            onMapCreated: widget.bloc.onMapCreated,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: widget.bloc.center,
              zoom: 3.0,
            ),
            cameraTargetBounds: CameraTargetBounds.unbounded,
            markers: widget.bloc.markers.values.toSet(),
            polylines:
                Set<Polyline>.of(widget.bloc.mapPolylines.values.toSet()),

            // myLocationButtonEnabled: true,
            myLocationEnabled: false,
            compassEnabled: true,
            mapToolbarEnabled: false,
          ),
        ),
      );
    }
    // } else if (snapshot.hasError) {
    //   return Center(child: Text('Error: ${snapshot.error}'));
    // }
    else {
      return const GlobalLoading();
    }
  }
}
