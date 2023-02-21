import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/repository/authentication_repository.dart';

import '../cubit/login_cubit.dart';
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
        child: BlocProvider(
          create: (context) => LoginCubit(RepositoryProvider.of<AuthenticationRepository>(context)),
          child: const LoginView(),
        ),
      ),
    );
  }
}
