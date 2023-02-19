import 'package:flutter/material.dart';

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
