import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'app.dart';

void main() {
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
