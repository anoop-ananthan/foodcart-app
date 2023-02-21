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
        addonCat:
            json["addonCat"] == null ? [] : List<AddonCat>.from(json["addonCat"]!.map((x) => AddonCat.fromJson(x))),
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

  CategoryDish copyWith({
    String? dishId,
    String? dishName,
    double? dishPrice,
    String? dishImage,
    String? dishCurrency,
    double? dishCalories,
    String? dishDescription,
    bool? dishAvailability,
    int? dishType,
    String? nexturl,
    List<AddonCat>? addonCat,
  }) {
    return CategoryDish(
      dishId: dishId ?? this.dishId,
      dishName: dishName ?? this.dishName,
      dishPrice: dishPrice ?? this.dishPrice,
      dishImage: dishImage ?? this.dishImage,
      dishCurrency: dishCurrency ?? this.dishCurrency,
      dishCalories: dishCalories ?? this.dishCalories,
      dishDescription: dishDescription ?? this.dishDescription,
      dishAvailability: dishAvailability ?? this.dishAvailability,
      dishType: dishType ?? this.dishType,
      nexturl: nexturl ?? this.nexturl,
      addonCat: addonCat ?? this.addonCat,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryDish &&
        other.dishId == dishId &&
        other.dishName == dishName &&
        other.dishPrice == dishPrice &&
        other.dishImage == dishImage &&
        other.dishCurrency == dishCurrency &&
        other.dishCalories == dishCalories &&
        other.dishDescription == dishDescription &&
        other.dishAvailability == dishAvailability &&
        other.dishType == dishType &&
        other.nexturl == nexturl;
  }

  @override
  int get hashCode {
    return dishId.hashCode ^
        dishName.hashCode ^
        dishPrice.hashCode ^
        dishImage.hashCode ^
        dishCurrency.hashCode ^
        dishCalories.hashCode ^
        dishDescription.hashCode ^
        dishAvailability.hashCode ^
        dishType.hashCode ^
        nexturl.hashCode ^
        addonCat.hashCode;
  }

  @override
  String toString() {
    return dishName;
  }
}
