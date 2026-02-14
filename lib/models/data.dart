import 'package:intl/intl.dart';

// TODO: Add settings

class Data {
  final String? date;
  final List<Map<String, dynamic>> cards;
  // final String? settings;

  const Data({
    this.date,
    required this.cards,
    // this.settings
  });

  factory Data.fromMap(Map<String, dynamic> map) => Data(
    date: map["date"],
    cards: map["cards"],
    // settings: map["settings"]
  );

  Map<String, dynamic> toMap() => {
    "date": DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
    "cards": cards,
    // "settings": settings,
  };
}
