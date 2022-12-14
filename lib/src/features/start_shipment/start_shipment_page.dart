import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truck_trucker/src/data/models/shipment_model.dart';
import 'package:truck_trucker/src/features/maps/bloc/home_cubit.dart';
import 'package:truck_trucker/src/global_widgets/global_sized_box.dart';
import 'package:truck_trucker/src/global_widgets/global_text_form_field.dart';
import 'package:truck_trucker/src/utils/routing/routing_methods.dart';

import '../../utils/routing/named_routs.dart';

class StartShipmentPage extends StatefulWidget {
  const StartShipmentPage({Key? key}) : super(key: key);

  @override
  State<StartShipmentPage> createState() => _StartShipmentPageState();
}

class _StartShipmentPageState extends State<StartShipmentPage> {
  final TextEditingController _shipmentController = TextEditingController();

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
       await BlocProvider.of<HomeCubit>(context).startShipmentStream(
        shipmentId: _shipmentController.text,
        shipmentModel: ShipmentModel(
          id: _shipmentController.text,
          createdAt: DateTime.now(),
          name: 'name',
        ),
      );

      globalToast('Shipment started, and location tracking started');
      RoutingMethods.replaceNamed(context: context, route: NamedRouts.home);
    } else {
      globalToast('error');
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GlobalTextFormField(
                      labelText: 'Shipment ID',
                      controller: _shipmentController,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (String shipmentId) {},
                      validator: (String? shipmentId) {
                        if (shipmentId == null || shipmentId.isEmpty) {
                          return 'Shipment ID is required';
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),
                    const GlobalSizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: submit,
                        child: const Text('Start Shipment'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

globalToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
