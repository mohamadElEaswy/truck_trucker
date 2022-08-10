import 'package:flutter/material.dart';
import 'package:truck_trucker/src/domain/repository/repository_controller.dart';
import 'package:truck_trucker/src/injection.dart' as di;
import 'package:truck_trucker/src/utils/routing/named_routs.dart';
import 'package:truck_trucker/src/utils/routing/routing_methods.dart';
import '../../../data/models/user_model.dart';
import '../../../global_widgets/global_loading.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  signOut() async {
    await di.serviceLocator.get<RepositoryController>().signOut();
  }

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
        body: FutureBuilder<UserModel?>(
          future: di.serviceLocator.get<RepositoryController>().getUserData(),
          builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
            if (snapshot.hasData) {
              return _homeBody(snapshot.data!);
            } else if (snapshot.hasError) {
              return _error(snapshot.error.toString());
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
  Widget _error(Object error) {
    return Text(error.toString());
  }

  Widget _homeBody(UserModel user) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return const ListTile(
          title: Text('location'),
          subtitle: Text('start date 2020-01-01, arriving at 2029-01-01'),
        );
      },
    );
  }
}
