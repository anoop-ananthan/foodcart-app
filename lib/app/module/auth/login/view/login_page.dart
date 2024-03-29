import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../auth.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    final authenticationRepo = RepositoryProvider.of<AuthenticationRepository>(context);
    final authenticationBloc = context.read<AuthenticationBloc>();
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) => LoginCubit(authenticationRepo, authenticationBloc),
          child: const LoginView(),
        ),
      ),
    );
  }
}
