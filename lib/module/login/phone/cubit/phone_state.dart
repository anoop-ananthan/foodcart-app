part of 'phone_cubit.dart';

class PhoneState extends Equatable {
  const PhoneState({
    this.phoneNumberInput = const PhoneNumberInput.pure(),
    this.status = FormzStatus.pure,
  });

  final PhoneNumberInput phoneNumberInput;
  final FormzStatus status;

  @override
  List<Object> get props => [phoneNumberInput, status];

  PhoneState copyWith({
    PhoneNumberInput? phoneNumberInput,
    FormzStatus? status,
  }) {
    return PhoneState(
      phoneNumberInput: phoneNumberInput ?? this.phoneNumberInput,
      status: status ?? this.status,
    );
  }
}
