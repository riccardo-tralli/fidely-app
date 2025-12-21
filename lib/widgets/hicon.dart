import 'dart:ui';

import 'package:fidely_app/misc/themes/rradius.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class Hicon extends StatelessWidget {
  final List<List<dynamic>> icon;
  final Color? color;
  final Color? backgroundColor;
  final double? size;
  final bool shadow;

  const Hicon(
    this.icon, {
    super.key,
    this.color,
    this.backgroundColor,
    this.size,
    this.shadow = false,
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
    child: Stack(
      alignment: Alignment.center,
      children: [if (shadow) shadowLayer(context), iconLayer],
    ),
  );

  Widget shadowLayer(BuildContext context) => Transform.translate(
    offset: const Offset(0, 2),
    child: ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: HugeIcon(
        icon: icon,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(77),
        size: size ?? 24,
      ),
    ),
  );

  Widget get iconLayer => HugeIcon(icon: icon, color: color, size: size ?? 24);
}
