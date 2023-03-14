import 'dart:convert';

import 'category_dish.dart';

class TableMenu {
  TableMenu({
    required this.menuCategory,
    required this.menuCategoryId,
    required this.menuCategoryImage,
    required this.nexturl,
    required this.categoryDishes,
  });

  String menuCategory;
  String menuCategoryId;
  String menuCategoryImage;
  String nexturl;
  List<CategoryDish> categoryDishes;

  factory TableMenu.fromRawJson(String str) => TableMenu.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TableMenu.fromJson(Map<String, dynamic> json) => TableMenu(
        menuCategory: json["menu_category"],
        menuCategoryId: json["menu_category_id"],
        menuCategoryImage: json["menu_category_image"],
        nexturl: json["nexturl"],
        categoryDishes: List<CategoryDish>.from(json["category_dishes"].map((x) => CategoryDish.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "menu_category": menuCategory,
        "menu_category_id": menuCategoryId,
        "menu_category_image": menuCategoryImage,
        "nexturl": nexturl,
        "category_dishes": List<dynamic>.from(categoryDishes.map((x) => x.toJson())),
      };
}
