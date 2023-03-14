import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interview_app/app/module/auth/auth.dart';

import '../../phone_login/cubit/phone_login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginFailed) {
          ScaffoldMessenger.of(context)
            ..clearSnackBars()
            ..showSnackBar(const SnackBar(content: Text('Login failed')));
        }
      },
      builder: (context, state) {
        if (state is LoginInitial || state is LoginFailed) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/firebase.svg',
                height: 125,
                width: 125,
              ),
              const SizedBox(height: 120),
              const _GoogleButton(),
              const SizedBox(height: 25),
              const _PhoneButton(),
            ],
          );
        } else {
          return const CircularProgressIndicator.adaptive();
        }
      },
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width - 60, 60),
        shape: const StadiumBorder(),
      ),
      onPressed: () {
        context.read<LoginCubit>().onGoogleLoginRequested();
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 14,
            child: SvgPicture.asset(
              'assets/images/google_logo.svg',
              height: 16,
            ),
          ),
          Expanded(
            child: Text(
              "Google",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhoneButton extends StatelessWidget {
  const _PhoneButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width - 60, 60),
        backgroundColor: Colors.green.shade400,
        shape: const StadiumBorder(),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (context) => PhoneLoginCubit(
                        authenticationRepository:
                            RepositoryProvider.of<AuthenticationRepository>(context)),
                    child: const PhoneLoginPage(),
                  )),
        );
      },
      child: Row(
        children: [
          const Icon(Icons.phone),
          Expanded(
            child: Text(
              "Phone",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
