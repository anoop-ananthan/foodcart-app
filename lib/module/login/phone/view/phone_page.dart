import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/module/login/phone/view/phone_view.dart';
import 'package:interview_app/repository/authentication_repository.dart';

import '../cubit/phone_cubit.dart';

class PhonePage extends StatelessWidget {
  const PhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneCubit(RepositoryProvider.of<AuthenticationRepository>(context)),
      child: const PhoneView(),
    );
  }
}
