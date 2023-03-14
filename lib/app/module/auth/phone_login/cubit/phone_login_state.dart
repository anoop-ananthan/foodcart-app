part of 'phone_login_cubit.dart';

class PhoneLoginState extends Equatable with FormzMixin {
  const PhoneLoginState({
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzSubmissionStatus.initial,
  });

  final PhoneNumber phoneNumber;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [phoneNumber, status];

  PhoneLoginState copyWith({
    PhoneNumber? phoneNumber,
    FormzSubmissionStatus? status,
  }) {
    return PhoneLoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
    );
  }

  @override
  List<FormzInput> get inputs => [phoneNumber];
}
