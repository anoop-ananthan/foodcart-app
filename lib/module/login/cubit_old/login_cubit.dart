import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:interview_app/data/model/user.dart';
import 'package:interview_app/module/login/phone/model/phone_number.dart';
import 'package:interview_app/repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginInitial());

  final AuthenticationRepository _authenticationRepository;

  Future<User?> onGoogleLoginRequested() async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final user = await _authenticationRepository.googleSignIn();
      if (user != null) {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } else {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
      return user;
    } catch (e) {
      debugPrint('\n[onGoogleLoginRequested]\n${e.toString()}');
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
    return null;
  }

  // Future<void> loginUsingPhoneNumber(VoidCallback callback) async {
  //   emit(state.copyWith(status: FormzStatus.submissionInProgress));
  //   try {
  //     await _authenticationRepository.signInWithPhoneNumber(state.phoneNumber.value!, callback);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     emit(state.copyWith(status: FormzStatus.submissionFailure));
  //   }
  // }

  // void phoneNumberChanged(String? value) {
  //   final phoneNumber = PhoneNumberInput.dirty(value?.replaceAll(RegExp(r'[^\w\s]+'), '') ?? '');
  //   emit(state.copyWith(phoneNumberInput: phoneNumber));
  // }
}
