import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:interview_app/app/data/model/user.dart';

import '../repository/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends HydratedBloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  late final StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  AuthenticationBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    on<AuthenticationGoogleLoginRequested>(_onAuthenticationGoogleLoginRequested);
    on<AuthenticationOtpVerificationRequested>(_onAuthenticationOtpVerificationRequested);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationUserChanged>(_authenticationUserChanged);

    // Relaoding the state from hydrated-bloc
    add((_AuthenticationStatusChanged(state.status)));
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
        return emit(AuthenticationState.authenticated(state.user));
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

  void _onAuthenticationOtpVerificationRequested(
    AuthenticationOtpVerificationRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      final user = await _authenticationRepository.verifyOtp(event.otp, event.verificationId);
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

  void _authenticationUserChanged(
    AuthenticationUserChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    emit(AuthenticationState.authenticated(event.user));
  }

  @override
  AuthenticationState? fromJson(Map<String, dynamic> json) {
    return AuthenticationState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthenticationState state) {
    return state.toMap();
  }
}
