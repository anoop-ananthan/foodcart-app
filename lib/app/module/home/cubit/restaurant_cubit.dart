import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:interview_app/app/data/model/restaurant.dart';
import 'package:interview_app/app/module/home/repository/restaurant_repository.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends HydratedCubit<RestaurantState> {
  RestaurantCubit(RestaurantRepository restaurantRepository)
      : _restaurantRepository = restaurantRepository,
        super(const RestaurantState());

  final RestaurantRepository _restaurantRepository;

  List<String>? get menuCategories =>
      state.restaurants[0].tableMenuList.map((e) => e.menuCategory).toList();

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

  @override
  RestaurantState? fromJson(Map<String, dynamic> json) {
    return RestaurantState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(RestaurantState state) {
    if (state.status == RestaurantStatus.success) {
      return state.toMap();
    }
    return null;
  }
}
