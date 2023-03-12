import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:interview_app/firebase_options.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SimpleObserver();
  runApp(const AppView());
}

class SimpleObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint('\n> ${bloc.runtimeType}: \n$change\n');
  }
}

// TODO
// 1. Refactor to bloc that is needed
// 2. Make login proper, with UI showing busy when authenticating
// 3. Animation with Bloc 
// 3a. Login buttons
// 3b. Shopping items
// 3c. Counter number flip floping like in swiggy
// 4. Making sure firebase authentication creates same users or verify if you need to create a seperate collection of users