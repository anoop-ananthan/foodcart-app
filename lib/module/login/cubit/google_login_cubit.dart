import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:interview_app/data/model/user.dart';
import 'package:interview_app/repository/authentication_repository.dart';

part 'google_login_state.dart';

class GoogleLoginCubit extends Cubit<GoogleLoginState> {
  GoogleLoginCubit(this._authenticationRepository) : super(GoogleLoginInitial());

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
}
