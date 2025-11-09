import 'package:fidely_app/misc/themes/rradius.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class Hicon extends StatelessWidget {
  final List<List<dynamic>> icon;
  final Color? color;
  final Color? backgroundColor;
  final double? size;

  const Hicon(
    this.icon, {
    super.key,
    this.color,
    this.backgroundColor,
    this.size,
  });

  @override
  Widget build(BuildContext context) => Container(
    padding: backgroundColor != null ? EdgeInsets.all(Spaces.extraSmall) : null,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: backgroundColor != null
          ? BorderRadius.circular(RRadius.small)
          : null,
    ),
    child: HugeIcon(icon: icon, color: color, size: size ?? 24),
  );
}
