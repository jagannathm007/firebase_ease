import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ease/app_routes.dart';
import 'package:firebase_ease/firebase_options.dart';
import 'package:firebase_ease/locator.dart';
import 'package:firebase_ease/providers/app_provider.dart';
import 'package:firebase_ease/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider(), lazy: true),
        ChangeNotifierProvider(create: (_) => AuthProvider(), lazy: true),
      ],
      child: MaterialApp(
        title: 'Firebase Ease',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.splash,
      ),
    );
  }
}
