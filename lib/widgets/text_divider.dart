import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:flutter/material.dart';

class TextDivider extends StatelessWidget {
  final String title;
  final double size;
  final Color? color;
  final Alignment? align;

  const TextDivider({
    super.key,
    required this.title,
    this.size = 1,
    this.color,
    this.align,
  });

  @override
  Widget build(BuildContext context) => Stack(
    alignment: AlignmentGeometry.center,
    children: [
      Container(
        width: double.infinity,
        height: size,
        color: color ?? Theme.of(context).colorScheme.onSurface.withAlpha(100),
      ),
      Align(
        alignment: align ?? Alignment.center,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Spaces.small),
          color: Theme.of(context).colorScheme.surface,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color:
                  color ??
                  Theme.of(context).colorScheme.onSurface.withAlpha(100),
            ),
          ),
        ),
      ),
    ],
  );
}
