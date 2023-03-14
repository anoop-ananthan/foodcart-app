import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/app/data/model/category_dish.dart';

import '../module/cart/cart.dart';

class Counter extends StatelessWidget {
  const Counter({
    super.key,
    required this.dish,
  });

  final CategoryDish dish;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            context.read<CartCubit>().removeDishFromCart(dish);
          },
          child: Container(
            width: 40,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
            child: const Icon(Icons.remove, color: Colors.white),
          ),
        ),
        BlocBuilder<CartCubit, Map<CategoryDish, int>>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return Container(
              width: 40,
              height: 30,
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Center(
                child: Text(
                  (state[dish] ?? '0').toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () {
            context.read<CartCubit>().addDishToCart(dish);
          },
          child: Container(
            width: 40,
            height: 30,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
