// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDsNan15Zwgemwee36ySiuXRSTnvSZXtik',
    appId: '1:562783490657:web:9d550b5028ddf123421020',
    messagingSenderId: '562783490657',
    projectId: 'truck-trucker',
    authDomain: 'truck-trucker.firebaseapp.com',
    storageBucket: 'truck-trucker.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAfe8ZlxgAI7jT7kW13WwJ_0RAhAs70Xc',
    appId: '1:562783490657:android:9a9fe5befa2e29dc421020',
    messagingSenderId: '562783490657',
    projectId: 'truck-trucker',
    storageBucket: 'truck-trucker.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD6Usqpw1d8EQswzePU7zHyfH0iYY3U05k',
    appId: '1:562783490657:ios:88bdb0820c8c208a421020',
    messagingSenderId: '562783490657',
    projectId: 'truck-trucker',
    storageBucket: 'truck-trucker.appspot.com',
    iosClientId: '562783490657-afleh4apdf6noj3b0dqnushqlo1aj404.apps.googleusercontent.com',
    iosBundleId: 'com.example.truckTrucker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD6Usqpw1d8EQswzePU7zHyfH0iYY3U05k',
    appId: '1:562783490657:ios:88bdb0820c8c208a421020',
    messagingSenderId: '562783490657',
    projectId: 'truck-trucker',
    storageBucket: 'truck-trucker.appspot.com',
    iosClientId: '562783490657-afleh4apdf6noj3b0dqnushqlo1aj404.apps.googleusercontent.com',
    iosBundleId: 'com.example.truckTrucker',
  );
}