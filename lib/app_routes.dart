import 'package:firebase_ease/screens/sign_in.dart';
import 'package:firebase_ease/screens/sign_up.dart';
import 'package:firebase_ease/screens/splash.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const splash = "/";
  static const signIn = "/signIn";
  static const signUp = "/signUp";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('Invalid Route')
              ),
            );
          },
        );
    }
  }


}
