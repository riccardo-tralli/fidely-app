class SortMode {
  final SortOption option;
  final bool reverse;

  SortMode({required this.option, this.reverse = false});

  Map<String, dynamic> toMap() => {"option": option.name, "reverse": reverse};

  factory SortMode.fromMap(Map<String, dynamic> map) => SortMode(
    option: SortOption.values.firstWhere(
      (e) => e.name == map["option"],
      orElse: () => SortOption.creationDate,
    ),
    reverse: map["reverse"] ?? false,
  );

  SortMode copyWith({SortOption? option, bool? reverse}) =>
      SortMode(option: option ?? this.option, reverse: reverse ?? this.reverse);
}

enum SortOption { creationDate, alphabetical, category }
