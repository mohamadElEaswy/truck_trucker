import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck_trucker/src/data/models/shipment_model.dart';
import 'package:truck_trucker/src/domain/repository/repository_controller.dart';
import 'package:truck_trucker/src/features/maps/bloc/home_cubit.dart';
import 'package:truck_trucker/src/injection.dart' as di;
import 'package:truck_trucker/src/utils/routing/named_routs.dart';
import 'package:truck_trucker/src/utils/routing/routing_methods.dart';
import '../../../data/models/user_model.dart';
import '../../../global_widgets/global_loading.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  signOut() async =>
      await di.serviceLocator.get<RepositoryController>().signOut();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
              onPressed: signOut,
              child: const Text('Sign Out'),
            )
          ],
        ),
        body: streamBuilder(),
        // FutureBuilder<UserModel?>(
        //   future: di.serviceLocator.get<RepositoryController>().getUserData(),
        //   builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        //     if (snapshot.hasData) {
        //       return streamBuilder();
        //     } else if (snapshot.hasError) {
        //       return _error(snapshot.error.toString());
        //     }
        //     return const GlobalLoading();
        //   },
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => RoutingMethods.pushNamed(
              context: context, route: NamedRouts.shipmentFormPage),
          tooltip: 'Add Shipment',
          child: const Icon(Icons.add),
        ),
      );
  Widget _error(Object error) => Text(error.toString());

  Widget _homeList(List<ShipmentModel> data) => ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(data[index].id),
            subtitle:
                const Text('start date 2020-01-01, arriving at 2029-01-01'),
            onTap: () {
              RoutingMethods.pushNamed(
                  context: context, route: NamedRouts.mapPage);
            },
          );
        },
      );

  Widget streamBuilder() {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        final HomeCubit bloc = BlocProvider.of<HomeCubit>(context);
        return StreamBuilder(
          stream: bloc.shipmentData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return _homeList(snapshot.data);
            }
            return const Text('Loading');
          },
        );
      },
    );
  }
}
