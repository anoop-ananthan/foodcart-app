import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/module/auth/authentication/bloc/authentication_bloc.dart';
import 'package:interview_app/repository/authentication_repository.dart';
import 'login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RepositoryProvider.value(
          value: AuthenticationRepository(),
          child: BlocProvider(
            create: (context) => AuthenticationBloc(
              authenticationRepository: RepositoryProvider.of<AuthenticationRepository>(context),
            ),
            child: const LoginView(),
          ),
        ),
      ),
    );
  }
}
