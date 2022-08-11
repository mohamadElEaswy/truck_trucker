import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck_trucker/src/features/maps/bloc/home_cubit.dart';

class StartShipmentPage extends StatefulWidget {
  const StartShipmentPage({Key? key}) : super(key: key);

  @override
  State<StartShipmentPage> createState() => _StartShipmentPageState();
}

class _StartShipmentPageState extends State<StartShipmentPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: const Center(
            child: Text('StartShipmentPage'),
          ),
        );
      },
    );
  }
}
