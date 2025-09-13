import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';

/*
  ? Add icon
  ? Add category
*/

class LoyaltyCard {
  final int id;
  final String title;
  final String code;
  final BarcodeType type;
  final String? owner;
  final Color color;
  final String? note;

  LoyaltyCard({
    required this.id,
    required this.title,
    required this.code,
    required this.type,
    this.owner,
    required this.color,
    this.note,
  });

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "code": code,
    "type": type.name,
    "owner": owner,
    "color": "${color.a},${color.r},${color.g},${color.b}",
    "note": note,
  };

  factory LoyaltyCard.fromMap(Map<String, dynamic> map) => LoyaltyCard(
    id: map["id"],
    title: map["title"],
    code: map["code"],
    type: BarcodeType.values.firstWhere((e) => e.name == map["type"]),
    owner: map["owner"],
    color: Color.fromARGB(
      (double.parse(map["color"].split(",")[0]) * 255).toInt(),
      (double.parse(map["color"].split(",")[1]) * 255).toInt(),
      (double.parse(map["color"].split(",")[2]) * 255).toInt(),
      (double.parse(map["color"].split(",")[3]) * 255).toInt(),
    ),
    note: map["note"],
  );

  LoyaltyCard copyWith({
    String? title,
    String? code,
    BarcodeType? type,
    String? owner,
    Color? color,
    String? note,
  }) => LoyaltyCard(
    id: id,
    title: title ?? this.title,
    code: code ?? this.code,
    type: type ?? this.type,
    owner: owner ?? this.owner,
    color: color ?? this.color,
    note: note ?? this.note,
  );
}
