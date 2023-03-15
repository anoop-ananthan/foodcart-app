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
  List<Object> get props => [restaurants, status];

  RestaurantState copyWith({
    List<Restaurant>? restaurants,
    RestaurantStatus? status,
  }) {
    return RestaurantState(
      restaurants: restaurants ?? this.restaurants,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'restaurants': restaurants.map((x) => x.toJson()).toList(),
      'status': status.name,
    };
  }

  factory RestaurantState.fromMap(Map<String, dynamic> map) {
    return RestaurantState(
      restaurants: List<Restaurant>.from(
        (map['restaurants']).map<Restaurant>(
          (x) => Restaurant.fromJson(x as Map<String, dynamic>),
        ),
      ),
      status: RestaurantStatus.values.byName(map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RestaurantState.fromJson(String source) =>
      RestaurantState.fromMap(json.decode(source) as Map<String, dynamic>);
}
