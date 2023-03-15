import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview_app/app/data/model/category_dish.dart';

import '../../home/view/home_page.dart';
import '../cubit/cart_cubit.dart';
import 'cart_view.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Order Summary',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        body: Stack(
          children: [
            const CartView(),
            Align(
              alignment: Alignment.bottomCenter,
              child: BlocBuilder<CartCubit, Map<CategoryDish, int>>(
                builder: (context, state) {
                  return state.isEmpty ? const SizedBox() : const _PlaceOrderButton();
                },
              ),
            ),
          ],
        ));
  }
}

class _PlaceOrderButton extends StatefulWidget {
  const _PlaceOrderButton();

  @override
  State<_PlaceOrderButton> createState() => _PlaceOrderButtonState();
}

class _PlaceOrderButtonState extends State<_PlaceOrderButton> {
  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
      child: isBusy
          ? const CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 12, 56, 16)),
            )
          : ElevatedButton(
              onPressed: () {
                setState(() {
                  isBusy = true;
                });
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    isBusy = false;
                  });

                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text(
                        'Thank you!',
                        textAlign: TextAlign.center,
                      ),
                      content: Text(
                        'Order successfully placed.',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            context.read<CartCubit>().clearCart();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                              (route) => false,
                            );
                          },
                          child: Text(
                            'Ok',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                  color: const Color.fromARGB(255, 12, 56, 16),
                                ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 12, 56, 16),
                shape: const StadiumBorder(),
                fixedSize: Size(MediaQuery.of(context).size.width, 45),
              ),
              child: const Text(
                "Place Order",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
    );
  }
}
