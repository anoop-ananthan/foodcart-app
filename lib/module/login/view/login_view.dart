import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:interview_app/module/login/phone/view/phone_page.dart';

import '../cubit/google_login_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<GoogleLoginCubit, GoogleLoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..clearSnackBars()
              ..showSnackBar(const SnackBar(content: Text('Login failed')));
          }
        },
        builder: (context, state) => Center(
          child: state.status.isSubmissionInProgress || state.status.isSubmissionSuccess
              ? const CircularProgressIndicator.adaptive()
              : Column(
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
        ),
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
        context.read<GoogleLoginCubit>().onGoogleLoginRequested();
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
          MaterialPageRoute(builder: (context) => const PhonePage()),
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
