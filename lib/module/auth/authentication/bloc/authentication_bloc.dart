import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:interview_app/data/model/user.dart';
import 'package:interview_app/repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<AuthenticationStatus> _streamSubscription;

  AuthenticationBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);
    on<AuthenticationGoogleLoginRequested>(_onAuthenticationGoogleLoginRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
  }

  void _onAuthenticationUserChanged(
    AuthenticationUserChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    // TODO: implement event handler
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    // TODO: implement event handler
  }

  void _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    // TODO: implement event handler
  }

  void _onAuthenticationGoogleLoginRequested(
    AuthenticationGoogleLoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final user = await _authenticationRepository.googleSignIn();
      if (user != null) {
        emit(AuthenticationState.authenticated(user));
      }
      debugPrint(user.toString());
    } catch (e) {
      debugPrint(e.toString());
      emit(const AuthenticationState.unauthenticated());
    }
  }
}
