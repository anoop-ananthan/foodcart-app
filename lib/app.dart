import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/module/auth/auth.dart';
import 'app/module/cart/cart.dart';
import 'app/module/home/home.dart';
import 'app/module/splash/splash_page.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
        ),
        RepositoryProvider.value(
          value: RestaurantRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: _authenticationBloc,
          ),
          BlocProvider(
            create: (context) => CartCubit(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              elevation: 1,
              iconTheme: IconThemeData(color: Colors.grey.shade600),
              toolbarTextStyle: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          navigatorKey: _navigatorKey,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      HomePage.route(),
                      (route) => false,
                    );
                    break;
                  case AuthenticationStatus.unknown:
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
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
