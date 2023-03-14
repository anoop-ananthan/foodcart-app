import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:interview_app/app/module/auth/auth.dart';
import 'package:interview_app/app/module/auth/phone_login/model/phone_number.dart';

part 'phone_login_state.dart';

class PhoneLoginCubit extends Cubit<PhoneLoginState> {
  PhoneLoginCubit({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const PhoneLoginState());

  final AuthenticationRepository _authenticationRepository;

  void onPhoneNumberChanged(String? phoneNumber) {
    emit(state.copyWith(phoneNumber: PhoneNumber.dirty(phoneNumber?.trim() ?? '')));
  }

  Future<void> signInWithPhoneNumber(BuildContext context) async {
    try {
      final phoneNumber = '+91${state.phoneNumber.value}';
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      await _authenticationRepository.signInWithPhoneNumber(context, phoneNumber);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
