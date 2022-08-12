import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:truck_trucker/src/bloc_observe.dart';
import 'package:truck_trucker/src/features/auth/bloc/cubit.dart';
import 'package:truck_trucker/src/features/maps/bloc/home_cubit.dart';
import 'package:truck_trucker/src/utils/routing/named_routs.dart';
import 'firebase_options.dart';
import 'src/injection.dart' as di;
import 'src/utils/theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //the following line is to stop screen rotation on android
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Firebase.app();
  //the following line is to init the injection using get_it package
  await di.setUp();

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, this.currentUser}) : super(key: key);
  final User? currentUser;
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
          BlocProvider<HomeCubit>(
              create: (context) => HomeCubit()..requestPermission()),
        ],
        child: MaterialApp(
          title: 'Truck Trucker App',
          theme: AppThemeData.defaultTheme,
          initialRoute: NamedRouts.checkInternetConnection,
          routes: routs,
        ),
      );
}
