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
  final Barcode type;
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
}
