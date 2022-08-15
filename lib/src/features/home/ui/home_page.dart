import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck_trucker/src/data/models/shipment_model.dart';
import 'package:truck_trucker/src/domain/repository/repository_controller.dart';
import 'package:truck_trucker/src/features/maps/bloc/home_cubit.dart';
import 'package:truck_trucker/src/injection.dart' as di;
import 'package:truck_trucker/src/utils/routing/named_routs.dart';
import 'package:truck_trucker/src/utils/routing/routing_methods.dart';
import '../../../global_widgets/global_loading.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  signOut() async =>
      await di.serviceLocator.get<RepositoryController>().signOut();

  @override
  Widget build(BuildContext context) => BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          // if (state is MapSuccess) {
          //   BlocProvider.of<HomeCubit>(context).add(state.data);
          // }
        },
        builder: (context, state) {
          final HomeCubit bloc = BlocProvider.of<HomeCubit>(context);
          return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                  onPressed: signOut,
                  child: const Text('Sign Out'),
                )
              ],
            ),
            body: StreamBuilder<List<ShipmentModel>>(
              stream: bloc.shipmentData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return _homeList(snapshot.data, bloc);
                }
                return const GlobalLoading();
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => RoutingMethods.pushNamed(
                  context: context, route: NamedRouts.shipmentFormPage),
              tooltip: 'Add Shipment',
              child: const Icon(Icons.add),
            ),
          );
        },
      );
  // Widget _error(Object error) => Text(error.toString());

  Widget _homeList(List<ShipmentModel> data, HomeCubit bloc) =>
      ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
              title: Text(data[index].id),
              subtitle: Text(data[index].createdAt!.toIso8601String()),
              onTap: () {
                // bloc.getLocationsList(data[index].id);
                RoutingMethods.pushNamed(
                  context: context,
                  route: NamedRouts.mapPage,
                  arguments: data[index].id.toString(),
                );
                // print(bloc.locationsData(data[index].id).listen((event) {print(event);}));
                // print(data.toString());
                // print(data[index].id);
              });
        },
      );
}

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
