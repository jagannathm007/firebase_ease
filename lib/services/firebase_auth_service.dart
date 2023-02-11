import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ease/services/function_response.dart';
import 'package:firebase_ease/widgets/otp_bottomsheet.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  FirebaseAuthService(this._auth);
  final FirebaseAuth _auth;

  //LOGIN WITH EMAILID AND PASSWORD
  Future<FunctionResponse> loginWithEmailIdPassword(String emailId, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailId,
        password: password,
      );
      if (_auth.currentUser!.emailVerified) {
        return _sendEmailVerification();
      } else {
        return FunctionResponse(data: _auth.currentUser, message: "LoggedIn successfully!");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return FunctionResponse(data: null, message: "You are not registered with us!");
      } else if (e.code == 'wrong-password') {
        return FunctionResponse(data: null, message: "Invalid credentials!");
      } else {
        log("::ERROR:: ${e.message!.toString()}");
        return FunctionResponse(data: null, message: e.message!);
      }
    }
  }

  //SIGNUP WITH EMAILID AND PASSWORD
  Future<FunctionResponse> registerWithEmailIdPassword(String emailId, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailId,
        password: password,
      );
      return _sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return FunctionResponse(data: null, message: "The password provided is too week!.");
      } else if (e.code == 'email-already-in-use') {
        return FunctionResponse(data: null, message: "The account already exists for that email!.");
      } else {
        log("::ERROR:: ${e.message!.toString()}");
        return FunctionResponse(data: null, message: e.message!);
      }
    }
  }

  //SEND VERIFICATION EMAIL
  Future<FunctionResponse> _sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      return FunctionResponse(message: "Email verification sent!", data: null);
    } on FirebaseAuthException catch (e) {
      return FunctionResponse(message: e.message!, data: null);
    }
  }

  //PHONE AUTH
  //Add SHA1 and SHA256 Fingerprint to your firebase project
  Future<FunctionResponse?> phoneSignIn(String phoneNumber, BuildContext context) async {
    FunctionResponse functionResponse = FunctionResponse(data: null, message: '');
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      codeSent: (String? verificationId, int? forceResendingToken) async {
        TextEditingController otpController = TextEditingController();
        showBottomSheet(
          context: context,
          enableDrag: false,
          backgroundColor: Colors.white,
          builder: (_) {
            return OTPBottomSheetWidget(
              otpController: otpController,
              onBackPressed: () async {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId!,
                  smsCode: otpController.text.trim(),
                );
                await _auth.signInWithCredential(credential);
                functionResponse.data = _auth.currentUser;
                functionResponse.message = "LoggedIn successfully!";
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
            );
          },
        );
      },
      verificationFailed: (e) {
        functionResponse.data = null;
        functionResponse.message = e.message!;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return functionResponse;
  }

  //SIGN OUT FROM FIREBASE AUTH
  Future<FunctionResponse> signOut() async {
    try {
      await _auth.signOut();
      return FunctionResponse(data: 1, message: "Sign out successfully!");
    } on FirebaseAuthException catch (e) {
      log("::ERROR:: ${e.message!.toString()}");
      return FunctionResponse(data: null, message: e.message!.toString());
    }
  }
}
