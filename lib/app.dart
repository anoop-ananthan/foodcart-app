import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/module/auth/authentication/bloc/authentication_bloc.dart';
import 'package:interview_app/module/home/dummy.dart';
import 'package:interview_app/repository/authentication_repository.dart';

import 'module/login/view/login_page.dart';
import 'module/splash/splash_page.dart';

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final AuthenticationRepository _authenticationRepository;
  late final AuthenticationBloc _authenticationBloc;
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _authenticationBloc = AuthenticationBloc(authenticationRepository: _authenticationRepository);
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider.value(
        value: _authenticationBloc,
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listenWhen: (previous, current) {
                debugPrint('\n[previous]\n${previous.toString()}');
                debugPrint('\n[current]\n${current.toString()}');
                return true;
              },
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      DummyPage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unknown:
                    _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                    break;
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (_) => SplashPage.route(),
        ),
      ),
    );
  }
}
