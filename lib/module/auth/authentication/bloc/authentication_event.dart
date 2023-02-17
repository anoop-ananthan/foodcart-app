part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {
  const AuthenticationEvent();
}

class _AuthenticationStatusChanged extends AuthenticationEvent {
  final AuthenticationStatus status;
  const _AuthenticationStatusChanged(this.status);
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final User user;

  List<Object> get props => [
        user
      ];
}

class AuthenticationLoginFailed extends AuthenticationEvent {}

class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationGoogleLoginRequested extends AuthenticationEvent {}
