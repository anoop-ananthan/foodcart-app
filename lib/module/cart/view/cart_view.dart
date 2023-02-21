import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/core/formatters/ruppee.dart';
import 'package:interview_app/data/model/category_dish.dart';
import 'package:interview_app/module/cart/view/widgets/selected_dish_card.dart';

import '../cubit/cart_cubit.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: const EdgeInsets.only(top: 12.0, left: 12, right: 12, bottom: 100),
        elevation: 4,
        child: BlocBuilder<CartCubit, Map<CategoryDish, int>>(
          builder: (_, state) {
            if (state.isEmpty) {
              return const _Header(text: 'Please select any items');
            }
            return Column(
              children: [
                _Header(text: '${state.length} Dishes - ${getTotalQuantity(state)} Items'),
                const SizedBox(height: 24),
                ...state.entries.map((e) => SelectedDishCard(
                      dish: e.key,
                      quantity: e.value,
                    )),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 18, bottom: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Amount',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        formatAsIndianCurrency(getTotalAmount(state)),
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  int getTotalQuantity(Map<CategoryDish, int> cart) {
    int qty = 0;
    for (var dish in cart.entries) {
      qty += dish.value;
    }
    return qty;
  }

  double getTotalAmount(Map<CategoryDish, int> cart) {
    double amount = 0;
    for (var item in cart.entries) {
      amount += (item.key.dishPrice * item.value).toDouble();
    }
    return amount;
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width - (17 * 2),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 12, 56, 16),
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
      child: Center(
        child: Text(
          text,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
