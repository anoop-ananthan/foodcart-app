import 'package:bloc/bloc.dart';
import 'package:interview_app/data/model/category_dish.dart';

class CartCubit extends Cubit<Map<CategoryDish, int>> {
  CartCubit() : super({});

  void addDishToCart(CategoryDish dish) {
    final updatedCart = Map<CategoryDish, int>.from(state);
    updatedCart[dish] = (updatedCart[dish] ?? 0) + 1;
    emit(updatedCart);
  }

  void removeDishFromCart(CategoryDish dish) {
    final updatedCart = Map<CategoryDish, int>.from(state);
    final isDishPresentInCart = updatedCart.containsKey(dish);
    final quantity = updatedCart[dish] ?? 0;
    if (isDishPresentInCart) {
      if (quantity <= 1) {
        updatedCart.remove(dish);
      } else {
        updatedCart[dish] = quantity - 1;
      }
      emit(updatedCart);
    }
  }

  int get quantity {
    return 7;
  }
}
