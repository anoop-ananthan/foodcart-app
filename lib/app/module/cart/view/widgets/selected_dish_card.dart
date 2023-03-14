import 'package:flutter/material.dart';
import 'package:interview_app/app/core/formatters/ruppee.dart';
import 'package:interview_app/app/data/model/category_dish.dart';
import 'package:interview_app/app/widgets/counter.dart';
import 'package:interview_app/app/widgets/food_type_indicator.dart';

class SelectedDishCard extends StatelessWidget {
  const SelectedDishCard({
    super.key,
    required this.dish,
    required this.quantity,
  });

  final CategoryDish dish;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 20;
    return SizedBox(
      width: width,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VegOrNonIndicator(isVeg: dish.dishType == 2),
              Flexible(
                fit: FlexFit.tight,
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dish.dishName,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      formatAsIndianCurrency(dish.dishPrice),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      '${dish.dishCalories.toInt()} calories',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Counter(dish: dish),
                ),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    formatAsIndianCurrency(dish.dishPrice * quantity),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Divider(
            endIndent: 10,
            indent: 10,
            thickness: 1,
            height: 24,
          ),
        ],
      ),
    );
  }
}
