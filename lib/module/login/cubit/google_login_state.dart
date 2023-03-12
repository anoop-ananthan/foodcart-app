part of 'google_login_cubit.dart';

class GoogleLoginInitial extends GoogleLoginState {}

class GoogleLoginState extends Equatable {
  final FormzStatus status;

  const GoogleLoginState({
    this.status = FormzStatus.pure,
  });

  GoogleLoginState copyWith({FormzStatus? status}) {
    return GoogleLoginState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}

class LoginInitial extends GoogleLoginState {}
