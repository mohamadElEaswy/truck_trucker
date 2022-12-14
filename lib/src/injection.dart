import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:truck_trucker/src/data/network/auth.dart';
import 'data/database/database.dart';
import 'domain/repository/repository_controller.dart';

final GetIt serviceLocator = GetIt.instance;

Future<void> setUp() async {
  serviceLocator.registerSingleton<GetItAppModel>(
    GetItAppModelImplementation(),
    signalsReady: true,
  );
  serviceLocator.registerLazySingleton<AuthBase>(() => Auth());
  serviceLocator.registerSingleton<Database>(
    FireStoreDatabase(),
    signalsReady: true,
  );

  serviceLocator.registerSingleton<RepositoryController>(RepositoryController());
}

abstract class GetItAppModel extends ChangeNotifier {
  void increment();
  int get counter;
}

// the following code is just for testing purpose
class GetItAppModelImplementation extends GetItAppModel {
  GetItAppModelImplementation() {
    // Future.delayed(const Duration(seconds: 3))
    //     .then((_) => getIt.signalReady(this));
    //  getIt.signalReady(this);
  }
  int _counter = 0;
  @override
  int get counter => _counter;

  @override
  void increment() {
    _counter++;
    if (kDebugMode) {
      print(_counter);
    }
    notifyListeners();
  }
}
