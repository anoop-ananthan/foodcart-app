import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../auth.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  final String verificationId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OtpPage'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            const Text(
              "Enter the OTP send to your phone number",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black38,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Pinput(
                autofocus: true,
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                  width: 60,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onCompleted: (value) {
                  context.read<AuthenticationBloc>().add(
                        AuthenticationOtpVerificationRequested(
                          verificationId: verificationId,
                          otp: value,
                        ),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
