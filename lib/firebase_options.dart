// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDE-1OJr77DDeEKbgd7tgAAW0uhoAlG7jQ',
    appId: '1:814957090307:android:78a968ec37c6182efa6036',
    messagingSenderId: '814957090307',
    projectId: 'rdl-e-cm',
    storageBucket: 'rdl-e-cm.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAYj3mspk2pYyz2KrfPS_fJwc1tIzlaZbg',
    appId: '1:814957090307:ios:8a7c071cbe085e0dfa6036',
    messagingSenderId: '814957090307',
    projectId: 'rdl-e-cm',
    storageBucket: 'rdl-e-cm.appspot.com',
    iosClientId: '814957090307-cik02318tupbshum2sq0k9tsu0f5pg9l.apps.googleusercontent.com',
    iosBundleId: 'com.rdl.ecm',
  );
}