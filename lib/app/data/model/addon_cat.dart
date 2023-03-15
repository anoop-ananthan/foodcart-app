import 'dart:convert';

import 'category_dish.dart';

class AddonCat {
  AddonCat({
    required this.addonCategory,
    required this.addonCategoryId,
    required this.addonSelection,
    required this.nexturl,
    required this.addons,
  });

  String addonCategory;
  String addonCategoryId;
  int addonSelection;
  String nexturl;
  List<CategoryDish> addons;

  factory AddonCat.fromRawJson(String str) => AddonCat.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AddonCat.fromJson(Map<String, dynamic> json) => AddonCat(
        addonCategory: json["addon_category"],
        addonCategoryId: json["addon_category_id"],
        addonSelection: json["addon_selection"],
        nexturl: json["nexturl"],
        addons: List<CategoryDish>.from(json["addons"].map((x) => CategoryDish.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "addon_category": addonCategory,
        "addon_category_id": addonCategoryId,
        "addon_selection": addonSelection,
        "nexturl": nexturl,
        "addons": List<dynamic>.from(addons.map((x) => x.toJson())),
      };
}
