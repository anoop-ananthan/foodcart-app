import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:interview_app/data/model/user.dart';
import 'package:interview_app/repository/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authenticationRepository) : super(LoginInitial());

  final AuthenticationRepository _authenticationRepository;

  Future<User?> onGoogleLoginRequested() async {
    emit(LoginInProgress());
    try {
      final user = await _authenticationRepository.googleSignIn();
      if (user != null) {
        emit(LoginSuccess(user));
      } else {
        emit(LoginFailed());
      }
      return user;
    } catch (e) {
      debugPrint('\n[onGoogleLoginRequested]\n${e.toString()}');
      emit(LoginFailed());
    }
    return null;
  }
}
