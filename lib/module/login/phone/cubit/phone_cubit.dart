import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:interview_app/module/login/phone/model/phone_number.dart';
import 'package:interview_app/repository/authentication_repository.dart';

part 'phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
  PhoneCubit(this._authenticationRepository) : super(const PhoneState());

  final AuthenticationRepository _authenticationRepository;

  void onPhoneNumberChanged(String? phoneNumner) {
    final phoneNumberInput = PhoneNumberInput.dirty(phoneNumner?.trim() ?? '');
    emit(state.copyWith(phoneNumberInput: phoneNumberInput, status: Formz.validate([phoneNumberInput])));
  }

  Future<void> onPhoneNumberSubmitted() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      // await _authenticationRepository.signInWithPhoneNumber(
      //   state.phoneNumberInput.value!,
      //   () => {debugPrint('call back..............')},
      // );
    } catch (e) {
      debugPrint(e.toString());
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
