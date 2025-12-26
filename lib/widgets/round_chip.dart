import 'package:fidely_app/misc/themes/rradius.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:flutter/material.dart';

class RoundChip extends StatelessWidget {
  final List<List<dynamic>>? icon;
  final String label;

  const RoundChip({super.key, this.icon, required this.label});

  @override
  Widget build(BuildContext context) => UnconstrainedBox(
    alignment: Alignment.topLeft,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: Spaces.small),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary.withAlpha(25),
        borderRadius: BorderRadius.circular(RRadius.large),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: Spaces.small,
        children: [
          if (icon != null)
            Hicon(
              icon!,
              color: Theme.of(context).colorScheme.primary,
              size: Spaces.medium,
            ),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    ),
  );
}
