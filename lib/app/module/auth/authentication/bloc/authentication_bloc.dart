import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:interview_app/app/data/model/user.dart';

import '../repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  AuthenticationBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationGoogleLoginRequested>(_onAuthenticationGoogleLoginRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);

    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(const AuthenticationState.unauthenticated());
  }

  void _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        return emit(AuthenticationState.authenticated(_authenticationRepository.user!));
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationGoogleLoginRequested(
    AuthenticationGoogleLoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final user = await _authenticationRepository.googleSignIn();
      if (user != null) {
        emit(AuthenticationState.authenticated(user));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
      debugPrint(user.toString());
    } catch (e) {
      debugPrint(e.toString());
      emit(const AuthenticationState.unauthenticated());
    }
  }
}
