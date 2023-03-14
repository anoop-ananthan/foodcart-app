import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/phone_login_cubit.dart';

class PhoneLoginPage extends StatelessWidget {
  const PhoneLoginPage({Key? key}) : super(key: key);

  static final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(
        offset: phoneController.text.length,
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Add your phone number. You will get a verification code",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              BlocBuilder<PhoneLoginCubit, PhoneLoginState>(
                builder: (context, state) {
                  return TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: phoneController,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      context.read<PhoneLoginCubit>().onPhoneNumberChanged(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black12),
                      ),
                      prefix: const Text('+91'),
                      suffixIcon: AnimatedOpacity(
                        duration: const Duration(milliseconds: 300),
                        opacity: state.phoneNumber.isValid ? 1 : 0,
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
                },
              ),
              const SizedBox(height: 40),
              BlocConsumer<PhoneLoginCubit, PhoneLoginState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: const StadiumBorder(),
                      fixedSize: const Size(200, 60),
                    ),
                    onPressed: state.isNotValid
                        ? null
                        : () {
                            context.read<PhoneLoginCubit>().signInWithPhoneNumber(context);
                          },
                    child: const Text('Login'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
