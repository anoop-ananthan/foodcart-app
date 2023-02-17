import 'dart:convert';

import 'addon_cat.dart';

class CategoryDish {
  CategoryDish({
    required this.dishId,
    required this.dishName,
    required this.dishPrice,
    required this.dishImage,
    required this.dishCurrency,
    required this.dishCalories,
    required this.dishDescription,
    required this.dishAvailability,
    required this.dishType,
    this.nexturl,
    this.addonCat,
  });

  String dishId;
  String dishName;
  double dishPrice;
  String dishImage;
  String dishCurrency;
  double dishCalories;
  String dishDescription;
  bool dishAvailability;
  int dishType;
  String? nexturl;
  List<AddonCat>? addonCat;

  factory CategoryDish.fromRawJson(String str) => CategoryDish.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryDish.fromJson(Map<String, dynamic> json) => CategoryDish(
        dishId: json["dish_id"],
        dishName: json["dish_name"],
        dishPrice: json["dish_price"]?.toDouble(),
        dishImage: json["dish_image"],
        dishCurrency: '',
        dishCalories: json["dish_calories"]?.toDouble() ?? 0,
        dishDescription: json["dish_description"],
        dishAvailability: json["dish_Availability"],
        dishType: json["dish_Type"],
        nexturl: json["nexturl"],
        addonCat: json["addonCat"] == null ? [] : List<AddonCat>.from(json["addonCat"]!.map((x) => AddonCat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "dish_id": dishId,
        "dish_name": dishName,
        "dish_price": dishPrice,
        "dish_image": dishImage,
        "dish_currency": '',
        "dish_calories": dishCalories,
        "dish_description": dishDescription,
        "dish_Availability": dishAvailability,
        "dish_Type": dishType,
        "nexturl": nexturl,
        "addonCat": addonCat == null ? [] : List<dynamic>.from(addonCat!.map((x) => x.toJson())),
      };
}
