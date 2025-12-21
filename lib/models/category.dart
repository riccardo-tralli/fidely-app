import 'package:fidely_app/l10n/l10n.dart';
import 'package:flutter/widgets.dart';
import 'package:hugeicons/hugeicons.dart';

class Category {
  final String? name;
  final String label;
  final List<List<dynamic>>? icon;

  const Category({required this.name, required this.label, this.icon});
}

class Categories {
  final BuildContext context;

  const Categories(this.context);

  Category fromName(String name) => list.firstWhere((e) => e.name == name);

  List<Category> get list => [
    Category(
      name: null,
      label: L10n.of(context)!.card_page_input_category_option_none,
    ),
    Category(
      name: "market",
      label: L10n.of(context)!.card_page_input_category_option_grocery,
      icon: HugeIcons.strokeRoundedShoppingCart02,
    ),
    Category(
      name: "food",
      label: L10n.of(context)!.card_page_input_category_option_food,
      icon: HugeIcons.strokeRoundedPizza02,
    ),
    Category(
      name: "pet",
      label: L10n.of(context)!.card_page_input_category_option_pets,
      icon: HugeIcons.strokeRoundedFishFood,
    ),
    Category(
      name: "fuel",
      label: L10n.of(context)!.card_page_input_category_option_fuel,
      icon: HugeIcons.strokeRoundedFuel,
    ),
    Category(
      name: "entertainment",
      label: L10n.of(context)!.card_page_input_category_option_entertainment,
      icon: HugeIcons.strokeRoundedFlimSlate,
    ),
    Category(
      name: "fashion",
      label: L10n.of(context)!.card_page_input_category_option_fashion,
      icon: HugeIcons.strokeRoundedDress03,
    ),
    Category(
      name: "electronics",
      label: L10n.of(context)!.card_page_input_category_option_electronics,
      icon: HugeIcons.strokeRoundedElectricPlugs,
    ),
    Category(
      name: "health",
      label: L10n.of(context)!.card_page_input_category_option_health,
      icon: HugeIcons.strokeRoundedMedicineSyrup,
    ),
    Category(
      name: "travel",
      label: L10n.of(context)!.card_page_input_category_option_travel,
      icon: HugeIcons.strokeRoundedAirplane02,
    ),
    Category(
      name: "sport",
      label: L10n.of(context)!.card_page_input_category_option_sport,
      icon: HugeIcons.strokeRoundedFootball,
    ),
    Category(
      name: "other",
      label: L10n.of(context)!.card_page_input_category_option_other,
    ),
  ];
}
