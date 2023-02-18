import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/data/model/table_menu.dart';
import 'package:interview_app/module/auth/authentication/bloc/authentication_bloc.dart';
import 'package:interview_app/module/home/view/widgets/dish_card.dart';

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
            ...state.tableMenuList.map((e) => DishesFromMenuCateory(menuCategory: e))
          ],
        ),
        drawer: const _NavigationDrawer(),
      ),
    );
  }
}

class DishesFromMenuCateory extends StatelessWidget {
  const DishesFromMenuCateory({super.key, required this.menuCategory});

  final TableMenu menuCategory;

  @override
  Widget build(BuildContext context) {
    final dishes = menuCategory.categoryDishes;
    return ListView(
      children: [
        ...dishes.map((e) => DishCard(dish: e))
      ],
    );
  }
}
