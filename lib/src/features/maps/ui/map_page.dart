import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_cubit.dart';
import 'map.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key, required this.shipmentId}) : super(key: key);
  final String shipmentId;

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: HomeMap(
              bloc: BlocProvider.of<HomeCubit>(context),
              shipmentId: shipmentId.toString()),
        );
      },
    );
  }
}
