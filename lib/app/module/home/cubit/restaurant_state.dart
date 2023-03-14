part of 'restaurant_cubit.dart';

enum RestaurantStatus {
  initial,
  loading,
  success,
  error,
}

class RestaurantState extends Equatable {
  const RestaurantState({
    this.restaurants = const <Restaurant>[],
    this.status = RestaurantStatus.initial,
  });

  final List<Restaurant> restaurants;
  final RestaurantStatus status;

  @override
  List<Object> get props => [
        restaurants,
        status
      ];

  RestaurantState copyWith({
    List<Restaurant>? restaurants,
    RestaurantStatus? status,
  }) {
    return RestaurantState(
      restaurants: restaurants ?? this.restaurants,
      status: status ?? this.status,
    );
  }
}
