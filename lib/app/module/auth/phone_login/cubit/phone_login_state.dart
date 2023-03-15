// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'phone_login_cubit.dart';

class PhoneLoginState extends Equatable with FormzMixin {
  const PhoneLoginState({
    this.phoneNumber = const PhoneNumber.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.exception,
  });

  final PhoneNumber phoneNumber;
  final FormzSubmissionStatus status;
  final Exception? exception;

  @override
  List<Object> get props => [phoneNumber, status];

  @override
  List<FormzInput> get inputs => [phoneNumber];

  PhoneLoginState copyWith({
    PhoneNumber? phoneNumber,
    FormzSubmissionStatus? status,
    Exception? exception,
  }) {
    return PhoneLoginState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      status: status ?? this.status,
      exception: exception ?? this.exception,
    );
  }
}
