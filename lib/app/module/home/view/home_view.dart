import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/app/data/model/category_dish.dart';
import 'package:interview_app/app/data/model/table_menu.dart';

import '../../auth/auth.dart';
import '../../cart/cart.dart';
import '../home.dart';
import 'widgets/dish_card.dart';

part 'partial/navigation_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final state = context.read<RestaurantCubit>().state.restaurants[0];
    return DefaultTabController(
      length: state.tableMenuList.length,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartPage()),
                );
              },
              icon: BlocBuilder<CartCubit, Map<CategoryDish, int>>(
                builder: (context, state) {
                  return Badge(
                    isLabelVisible: state.isNotEmpty,
                    label: Text(state.length.toString()),
                    child: const Icon(Icons.shopping_cart),
                  );
                },
              ),
            ),
            const SizedBox(width: 14),
          ],
          bottom: TabBar(
            indicatorColor: Colors.red,
            isScrollable: true,
            labelColor: Colors.red,
            unselectedLabelColor: Colors.grey.shade600,
            tabs: [...state.tableMenuList.map((e) => Tab(text: e.menuCategory))],
          ),
        ),
        body: TabBarView(
          children: [...state.tableMenuList.map((e) => DishesFromMenuCateory(menuCategory: e))],
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
    return ListView.separated(
      itemCount: dishes.length + 1,
      itemBuilder: (context, i) {
        if (i >= dishes.length) {
          return const SizedBox();
        } else {
          return DishCard(dish: dishes[i]);
        }
      },
      separatorBuilder: (context, i) => const Divider(
        thickness: 1.5,
        height: 10,
      ),
    );
  }
}
