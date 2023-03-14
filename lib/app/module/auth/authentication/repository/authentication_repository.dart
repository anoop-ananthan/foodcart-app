import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interview_app/app/data/model/user.dart';

import '../../auth.dart';

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
    } catch (e) {
      debugPrint('[googleSignIn]');
      debugPrint(e.toString());
    }
    return user;
  }

  Future<void> signInWithPhoneNumber(BuildContext context, String phoneNumber) async {
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
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
        codeSent: (String verificatioId, int? forceResendingToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpPage(verificationId: verificatioId),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  Future<bool> verifyOtp(String otp, String verificationId) async {
    final credential = await _firebaseAuth.signInWithCredential(
      firebase_auth.PhoneAuthProvider.credential(
        verificationId: verificationId,
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
