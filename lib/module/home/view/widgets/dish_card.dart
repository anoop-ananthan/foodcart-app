import 'package:cached_network_image/cached_network_image.dart';
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
    const imageWidth = 80.0;
    final maxWidthForText = MediaQuery.of(context).size.width - imageWidth - 5 - horizontalPadding * 4;
    return Container(
      padding: const EdgeInsets.all(horizontalPadding),
      width: MediaQuery.of(context).size.width - horizontalPadding,
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
                      '${dish.dishCalories.toInt().toString()} calories',
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
              ),
              const SizedBox(height: 12),
              dish.addonCat?.isNotEmpty ?? false
                  ? const Text(
                      'Customization Avaliable',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          CachedNetworkImage(
            height: imageWidth,
            width: imageWidth,
            imageUrl: dish.dishImage,
            progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset(
              'assets/images/food.jpg',
              fit: BoxFit.cover,
            ),
            errorWidget: (context, url, error) => Image.asset(
              'assets/images/food.jpg',
              fit: BoxFit.cover,
            ),
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
