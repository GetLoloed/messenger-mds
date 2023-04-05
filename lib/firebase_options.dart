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
    apiKey: 'AIzaSyCgrByb1prYNU96E9WDhVeAXSDxraRQkNo',
    appId: '1:949745489850:web:0dadd1848c757dd1822f83',
    messagingSenderId: '949745489850',
    projectId: 'messenger-mds',
    authDomain: 'messenger-mds.firebaseapp.com',
    storageBucket: 'messenger-mds.appspot.com',
    measurementId: 'G-DFZ7XMSB5X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDCZDwzx_UoJNPCCfoI42Kat1srKAtBVAI',
    appId: '1:949745489850:android:d06c5e2fd4b25ed7822f83',
    messagingSenderId: '949745489850',
    projectId: 'messenger-mds',
    storageBucket: 'messenger-mds.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA37h3au5i9zssP80Ql4k2Xc2cpbKojnwc',
    appId: '1:949745489850:ios:778a3e76fa6d839e822f83',
    messagingSenderId: '949745489850',
    projectId: 'messenger-mds',
    storageBucket: 'messenger-mds.appspot.com',
    iosClientId: '949745489850-3seeop6a6jg4mm1365gp05uirjahpaak.apps.googleusercontent.com',
    iosBundleId: 'com.example.messenger',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA37h3au5i9zssP80Ql4k2Xc2cpbKojnwc',
    appId: '1:949745489850:ios:778a3e76fa6d839e822f83',
    messagingSenderId: '949745489850',
    projectId: 'messenger-mds',
    storageBucket: 'messenger-mds.appspot.com',
    iosClientId: '949745489850-3seeop6a6jg4mm1365gp05uirjahpaak.apps.googleusercontent.com',
    iosBundleId: 'com.example.messenger',
  );
}
