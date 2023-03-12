import 'package:formz/formz.dart';

enum PhoneInputError { invalid, empty }

class PhoneNumberInput extends FormzInput<String?, PhoneInputError> {
  const PhoneNumberInput.pure() : super.pure('');
  const PhoneNumberInput.dirty([String? value = '']) : super.dirty(value);

  static final _phoneNumberRegex = RegExp(r'^[789]\d{9}$');

  @override
  PhoneInputError? validator(String? value) {
    if (value == null) {
      return PhoneInputError.empty;
    }
    if (value.trim().isEmpty) {
      return PhoneInputError.empty;
    }
    if (value.trim().length != 10) {
      return PhoneInputError.invalid;
    }
    if (!_phoneNumberRegex.hasMatch(value.trim())) {
      return PhoneInputError.invalid;
    }
    return null;
  }
}
