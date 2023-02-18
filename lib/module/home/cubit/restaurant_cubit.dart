import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:interview_app/data/model/restaurant.dart';
import 'package:interview_app/repository/restaurant_repository.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantCubit(RestaurantRepository restaurantRepository)
      : _restaurantRepository = restaurantRepository,
        super(const RestaurantState());

  final RestaurantRepository _restaurantRepository;

  List<String>? get menuCategories => state.restaurants[0].tableMenuList.map((e) => e.menuCategory).toList();

  Future<void> onRestaurantsFetched() async {
    emit(state.copyWith(status: RestaurantStatus.loading));
    try {
      final restaurants = await _restaurantRepository.getRestaurantData();
      emit(state.copyWith(status: RestaurantStatus.success, restaurants: restaurants));
    } catch (e) {
      debugPrint('\n[onRestaurantsFetched]\n${e.toString()}\n');
      emit(state.copyWith(status: RestaurantStatus.error));
    }
  }
}
