import 'package:flutter/material.dart';
import 'package:interview_app/core/formatters/ruppee.dart';
import 'package:interview_app/data/model/category_dish.dart';

class DishCard extends StatelessWidget {
  const DishCard({
    super.key,
    required this.dish,
  });

  final CategoryDish dish;

  @override
  Widget build(BuildContext context) {
    const horizontalPadding = 10.0;
    const imageHeight = 100.0;
    final maxWidthForText = MediaQuery.of(context).size.width - imageHeight - 5 - horizontalPadding * 4;
    return Container(
      padding: const EdgeInsets.all(horizontalPadding),
      width: MediaQuery.of(context).size.width - horizontalPadding,
      color: Colors.amber.shade50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VegOrNonIndicator(isVeg: (dish.dishType == 2)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: maxWidthForText,
                child: Text(
                  dish.dishName,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: maxWidthForText,
                child: Row(
                  children: [
                    Text(
                      formatAsIndianCurrency(dish.dishPrice),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      '${dish.dishCalories.toString()} calories',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.6),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: maxWidthForText,
                child: Text(
                  dish.dishDescription,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  Container(
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
                  Container(
                    width: 40,
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                  ),
                  Container(
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
                ],
              )
            ],
          ),
          Container(
            height: imageHeight,
            width: imageHeight,
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class VegOrNonIndicator extends StatelessWidget {
  const VegOrNonIndicator({
    super.key,
    required this.isVeg,
  });

  final bool isVeg;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(2.0),
      width: 15,
      height: 15,
      decoration: BoxDecoration(
        border: Border.all(color: isVeg ? Colors.green.shade800 : Colors.red.shade900),
        borderRadius: const BorderRadius.all(Radius.circular(3)),
      ),
      child: CircleAvatar(
        backgroundColor: isVeg ? Colors.green.shade800 : Colors.red.shade900,
      ),
    );
  }
}
