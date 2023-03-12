import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interview_app/data/model/user.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final _controller = StreamController<AuthenticationStatus>();
  final _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  User? user;

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  AuthenticationRepository();

  Future<User?> googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    try {
      final googleAccount = await googleSignIn.signIn();
      if (googleAccount == null) {
        return null;
      } else {
        user = User(
          id: googleAccount.id,
          email: googleAccount.email,
          username: googleAccount.displayName,
          photoUrl: googleAccount.photoUrl,
        );
        final googleAuth = await googleAccount.authentication;
        final credential = await _firebaseAuth.signInWithCredential(
          firebase_auth.GoogleAuthProvider.credential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );
        debugPrint('[credential]');
        debugPrint(credential.toString());
        _controller.add(AuthenticationStatus.authenticated);
      }
    } on FirebaseException catch (e) {
      String errorMsg = getMessageFromErrorCode(e.code);
      throw Exception(errorMsg);
    } catch (e) {
      debugPrint('[googleSignIn]');
      debugPrint(e.toString());
      throw ('Unable to login due to error!');
    }
    return user;
  }

  Future<void> signInWithPhoneNumber(String phoneNumber, Function callback) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: '+91$phoneNumber',
        verificationCompleted: (firebase_auth.PhoneAuthCredential phoneAuthCredential) async {
          final credential = await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          if (credential.user != null) {
            user = User(
              id: credential.user?.uid ?? 'not set',
              email: credential.user?.email,
              username: credential.user?.displayName,
              photoUrl: credential.user?.photoURL,
            );
            debugPrint('[credential]');
            debugPrint(credential.toString());
            _controller.add(AuthenticationStatus.authenticated);
          }
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (String verificationId, int? forceResendingToken) {
          debugPrint('\n> code sent: $verificationId\n');
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  Future<bool> verifyOtp(String otp, String verificaitonId) async {
    final credential = await _firebaseAuth.signInWithCredential(
      firebase_auth.PhoneAuthProvider.credential(
        verificationId: verificaitonId,
        smsCode: otp,
      ),
    );
    if (credential.user != null) {
      user = User(
        id: credential.user?.uid ?? 'not set',
        email: credential.user?.email,
        username: credential.user?.displayName,
        photoUrl: credential.user?.photoURL,
      );
      debugPrint('[credential]');
      debugPrint(credential.toString());
      _controller.add(AuthenticationStatus.authenticated);
      return true;
    }
    return false;
  }

  void dispose() => _controller.close();
}

String getMessageFromErrorCode(String errorCode) {
  switch (errorCode) {
    case "ERROR_EMAIL_ALREADY_IN_USE":
    case "account-exists-with-different-credential":
    case "email-already-in-use":
      return "Email already used. Go to login page.";
    case "ERROR_WRONG_PASSWORD":
    case "wrong-password":
      return "Wrong email/password combination.";
    case "ERROR_USER_NOT_FOUND":
    case "user-not-found":
      return "No user found with this email.";
    case "ERROR_USER_DISABLED":
    case "user-disabled":
      return "User disabled.";
    case "ERROR_TOO_MANY_REQUESTS":
    case "operation-not-allowed":
      return "Too many requests to log into this account.";
    case "ERROR_OPERATION_NOT_ALLOWED":
      return "Server error, please try again later.";
    case "ERROR_INVALID_EMAIL":
    case "invalid-email":
      return "Email address is invalid.";
    default:
      return "Login failed. Please try again.";
  }
}
