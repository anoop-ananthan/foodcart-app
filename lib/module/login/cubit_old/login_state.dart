part of 'login_cubit.dart';

class LoginState extends Equatable {
  final FormzStatus status;

  const LoginState({
    this.status = FormzStatus.pure,
  });

  LoginState copyWith({FormzStatus? status, PhoneNumberInput? phoneNumberInput}) {
    return LoginState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

class LoginInitial extends LoginState {}
