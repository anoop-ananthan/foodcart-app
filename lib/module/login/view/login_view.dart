import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:interview_app/module/auth/authentication/bloc/authentication_bloc.dart';
import 'package:interview_app/repository/authentication_repository.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, current) => current.status == AuthenticationStatus.unauthenticated,
      listener: (context, state) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(const SnackBar(content: Text('Login faied')));
      },
      child: Column(
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
      ),
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
        // AuthenticationRepository().googleSignIn();
        context.read<AuthenticationBloc>().add(AuthenticationGoogleLoginRequested());
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
      onPressed: () {},
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
