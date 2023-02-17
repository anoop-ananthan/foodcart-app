import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/module/auth/authentication/bloc/authentication_bloc.dart';

import '../cubit/restaurant_cubit.dart';

part './widgets/navigation_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final state = context.read<RestaurantCubit>().state.restaurants[0];
    return DefaultTabController(
      length: state.tableMenuList.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          bottom: TabBar(
            indicatorColor: Colors.red,
            isScrollable: true,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey.shade600,
            tabs: [
              ...state.tableMenuList.map((e) => Tab(text: e.menuCategory))
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ...state.tableMenuList.map((e) => DishesFromMenuCateory(menuCategory: e.menuCategory))
          ],
        ),
        drawer: const _NavigationDrawer(),
      ),
    );
  }
}

class DishesFromMenuCateory extends StatelessWidget {
  const DishesFromMenuCateory({super.key, required this.menuCategory});

  final String menuCategory;

  @override
  Widget build(BuildContext context) {
    final state = context.read<RestaurantCubit>().state.restaurants[0];
    final dishes = state.tableMenuList.firstWhere((e) => e.menuCategory == menuCategory).categoryDishes;
    return Column(
      children: [
        ...dishes.map((e) => Text(e.dishName))
      ],
    );
  }
}
