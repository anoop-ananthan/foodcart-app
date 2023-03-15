part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class _AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;
  _AuthenticationStatusChanged(this.status) {
    debugPrint('\n> status changed: $status');
  }
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged({required this.user});
  final User user;
}

class AuthenticationLoginFailed extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationGoogleLoginRequested extends AuthenticationEvent {}

class AuthenticationOtpVerificationRequested extends AuthenticationEvent {
  const AuthenticationOtpVerificationRequested({required this.verificationId, required this.otp});
  final String verificationId;
  final String otp;
}
