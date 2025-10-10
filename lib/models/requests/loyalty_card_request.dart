import 'dart:ui';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:fidely_app/models/category.dart';

class LoyaltyCardInsertRequest {
  final String title;
  final String code;
  final BarcodeType type;
  final String? owner;
  final Color color;
  final String? note;
  final Category? category;

  const LoyaltyCardInsertRequest({
    required this.title,
    required this.code,
    required this.type,
    this.owner,
    required this.color,
    this.note,
    this.category,
  });

  Map<String, dynamic> toMap() => {
    "title": title,
    "code": code,
    "type": type.name,
    "owner": owner,
    "color": "${color.a},${color.r},${color.g},${color.b}",
    "note": note,
    "category": category?.name,
  };
}
