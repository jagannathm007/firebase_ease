import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ease/services/firebase_auth_service.dart';
import 'package:firebase_ease/services/firestorage_service.dart';
import 'package:firebase_ease/services/firestore_service.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

setupGetIt() {
  getIt.registerFactory<FirebaseAuthService>(() => FirebaseAuthService(FirebaseAuth.instance));
  getIt.registerFactory<FireStoreService>(() => FireStoreService());
  getIt.registerFactory<FireStorageService>(() => FireStorageService());
}
