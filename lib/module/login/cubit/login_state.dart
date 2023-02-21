part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginFailed extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  const LoginSuccess(this.user);
}
