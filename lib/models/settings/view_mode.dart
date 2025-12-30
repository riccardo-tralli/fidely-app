class ViewMode {
  final int? columns;
  final bool? usePhoto;

  const ViewMode({this.columns, this.usePhoto});

  Map<String, dynamic> toMap() => {"columns": columns, "usePhoto": usePhoto};

  factory ViewMode.fromMap(Map<String, dynamic> map) => ViewMode(
    columns: map["columns"] ?? 1,
    usePhoto: map["usePhoto"] ?? false,
  );

  ViewMode copyWith({int? columns, bool? usePhoto}) => ViewMode(
    columns: columns ?? this.columns,
    usePhoto: usePhoto ?? this.usePhoto,
  );
}
