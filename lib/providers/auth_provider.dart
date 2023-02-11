import 'dart:developer';
import 'package:firebase_ease/services/firebase_auth_service.dart';
import 'package:firebase_ease/utilities/snackbar_util.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ease/locator.dart';

class AuthProvider extends ChangeNotifier{

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  Future login(BuildContext context) async {
    final firebaseAuth = getIt.get<FirebaseAuthService>();
    firebaseAuth.loginWithEmailIdPassword(txtEmail.text, txtPassword.text).then((response){
      if(response.data!=null){
        //USER DATA
        log(response.data.toString());
      }else{
        showSnackBar(context, response.message);
      }
    });
  }
  
}