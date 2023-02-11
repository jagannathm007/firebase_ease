import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8u3G7gdo_Dor4W7TD-qNpf7T2ulNBgD4',
    appId: '1:683658750251:android:a43756f72747b28cd83d6e',
    messagingSenderId: '683658750251',
    projectId: 'fir-ease',
    storageBucket: 'fir-ease.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCyNUjTD6-uhqBgyf0pohQWVqB_083uE38',
    appId: '1:683658750251:ios:a3ed477d238aff77d83d6e',
    messagingSenderId: '683658750251',
    projectId: 'fir-ease',
    storageBucket: 'fir-ease.appspot.com',
    iosClientId: '683658750251-u92bdkh820lq629e5u45cehfc3piavp4.apps.googleusercontent.com',
    iosBundleId: 'com.jagannathm007.firebaseEase',
  );
}
