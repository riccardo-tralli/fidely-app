enum Category {
  market("market"),
  food("food"),
  fuel("fuel"),
  entertainment("entertainment"),
  fashion("fashion"),
  electronics("electronics"),
  health("health"),
  travel("travel"),
  sport("sport"),
  other("other");

  final String name;
  const Category(this.name);

  factory Category.fromName(String name) =>
      Category.values.firstWhere((e) => e.name == name);
}
