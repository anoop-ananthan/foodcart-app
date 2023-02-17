import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/module/home/view/home_intermediate.dart';
import 'package:interview_app/repository/restaurant_repository.dart';

import '../cubit/restaurant_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RestaurantCubit(
        RepositoryProvider.of<RestaurantRepository>(context),
      )..onRestaurantsFetched(),
      child: const HomeIntermediate(),
    );
  }
}
