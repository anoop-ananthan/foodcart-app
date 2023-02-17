import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interview_app/data/model/user.dart';

enum AuthenticationStatus {
  unknown,
  authenticated,
  unauthenticated
}

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
      }
    } catch (e) {
      debugPrint('[googleSignIn]');
      debugPrint(e.toString());
    }
    return user;
  }

  void dispose() => _controller.close();
}
