import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truck_trucker/src/utils/routing/named_routs.dart';
import 'firebase_options.dart';
import 'src/injection.dart' as di;
import 'src/utils/theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //the following line is to stop screen rotation on android
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //the following line is to init the injection using get_it package
  await di.setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Truck Trucker App',
        theme: AppThemeData.defaultTheme,
        initialRoute: NamedRouts.init,
        routes: routs,
      );
}
