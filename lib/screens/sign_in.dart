import 'package:firebase_ease/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (_, authProvider, child) {
        return Scaffold(
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: [
                TextFormField(
                  controller: authProvider.txtEmail,
                  decoration: const InputDecoration(labelText: "Email ID"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: authProvider.txtPassword,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                const SizedBox(height: 10),
                MaterialButton(
                  onPressed: () => authProvider.login(context),
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
