import 'package:dio/dio.dart';
import 'package:interview_app/app/data/model/restaurant.dart';

class RestaurantRepository {
  final dio = Dio();

  List<Restaurant>? restaurants;

  Future<List<Restaurant>?> getRestaurantData() async {
    if (restaurants != null) {
      return restaurants;
    }
    final response = await dio.get('https://www.mocky.io/v2/5dfccffc310000efc8d2c1ad');
    restaurants = (response.data as List).map((e) => Restaurant.fromJson(e)).toList();
    return restaurants;
  }
}
