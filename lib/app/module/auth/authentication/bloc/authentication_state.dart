// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;
  final User user;

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status.name,
      'user': user.toMap(),
    };
  }

  factory AuthenticationState.fromMap(Map<String, dynamic> map) {
    return AuthenticationState._(
      status: AuthenticationStatus.values.byName(map['status']),
      user: User.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationState.fromJson(String source) =>
      AuthenticationState.fromMap(json.decode(source) as Map<String, dynamic>);
}
