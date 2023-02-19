import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/repository/authentication_repository.dart';

class PhoneNumberEntryPage extends StatefulWidget {
  const PhoneNumberEntryPage({Key? key}) : super(key: key);

  @override
  State<PhoneNumberEntryPage> createState() => _PhoneNumberEntryPageState();
}

class _PhoneNumberEntryPageState extends State<PhoneNumberEntryPage> {
  final TextEditingController phoneController = TextEditingController();
  bool isBusy = false;

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
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phoneController,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  setState(() {
                    phoneController.text = value;
                  });
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
                  suffixIcon: phoneController.text.length == 10
                      ? Container(
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
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 40),
              isBusy
                  ? const CircularProgressIndicator.adaptive()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: const StadiumBorder(),
                        fixedSize: const Size(200, 60),
                      ),
                      onPressed: phoneController.text.trim().length == 10
                          ? () async {
                              try {
                                setState(() {
                                  isBusy = true;
                                });
                                final phoneNumber =
                                    phoneController.text.isEmpty ? '+919846242355' : '+91${phoneController.text}';
                                RepositoryProvider.of<AuthenticationRepository>(context)
                                    .signInWithPhoneNumber(context, phoneNumber);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                              } finally {
                                setState(() {
                                  isBusy = false;
                                });
                              }
                            }
                          : null,
                      child: const Text('Login'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
