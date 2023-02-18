import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/module/home/view/home_view.dart';

import '../cubit/restaurant_cubit.dart';

class HomeIntermediate extends StatelessWidget {
  const HomeIntermediate({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<RestaurantCubit, RestaurantState>(
        builder: (context, state) {
          switch (state.status) {
            case RestaurantStatus.error:
              return const Center(
                child: Text('An error occured!'),
              );

            case RestaurantStatus.loading:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );

            case RestaurantStatus.success:
              return const HomeView();

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
