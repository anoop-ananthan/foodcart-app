import 'package:formz/formz.dart';

enum PhoneNumberError { empty, invalid, notTenDigits }

class PhoneNumber extends FormzInput<String, PhoneNumberError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final _phoneNumberRegex = RegExp(r'^[789]\d{9}$');

  @override
  PhoneNumberError? validator(String value) {
    if (value.trim().isEmpty) {
      return PhoneNumberError.empty;
    }
    if (value.trim().length != 10) {
      return PhoneNumberError.notTenDigits;
    }
    if (!_phoneNumberRegex.hasMatch(value.trim())) {
      return PhoneNumberError.invalid;
    }
    return null;
  }
}
