import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:truck_trucker/src/data/network/auth.dart';

import 'data/database/database.dart';

GetIt serviceLocator = GetIt.instance;

void setUp() {
  serviceLocator.registerSingleton<GetItAppModel>(GetItAppModelImplementation(),
      signalsReady: true);
  serviceLocator.registerSingleton<AuthBase>(Auth(), signalsReady: true);
  serviceLocator.registerSingleton<Database>(FireStoreDatabase(),
      signalsReady: true);
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
