import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:interview_app/module/login/phone/view/otp_page.dart';

import '../cubit/phone_cubit.dart';

class PhoneView extends StatelessWidget {
  const PhoneView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: BlocBuilder<PhoneCubit, PhoneState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter your phone number ",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "You will get a verification code",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 30),
                  const _PhoneNumberInput(),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: const StadiumBorder(),
                      fixedSize: const Size(200, 60),
                    ),
                    onPressed: state.status.isInvalid
                        ? null
                        : () {
                            context.read<PhoneCubit>().onPhoneNumberSubmitted();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const OtpPage(verificationId: '')),
                            );
                          },
                    child: const Text('Login'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PhoneNumberInput extends StatelessWidget {
  const _PhoneNumberInput();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<PhoneCubit>().state;
    return TextField(
      keyboardType: TextInputType.phone,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
      ),
      onChanged: (value) {
        context.read<PhoneCubit>().onPhoneNumberChanged(value);
      },
      decoration: InputDecoration(
        hintText: "Enter phone number",
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.black12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.green.shade100),
        ),
        prefix: const Text('+91 '),
        suffixIcon: AnimatedOpacity(
          opacity: state.status.isValidated ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
            child: const Icon(
              Icons.done,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
