import 'package:fidely_app/misc/themes/rradius.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:flutter/material.dart';

class Option extends StatelessWidget {
  final BuildContext context;
  final List<List<dynamic>> icon;
  final String label;
  final Function onTap;
  final bool active;

  const Option({
    super.key,
    required this.context,
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color? textColor = active
        ? Theme.brightnessOf(context) == Brightness.light
              ? Colors.white
              : Theme.of(context).colorScheme.surface
        : null;

    return InkWell(
      borderRadius: BorderRadius.circular(RRadius.medium),
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(Spaces.medium),
        decoration: BoxDecoration(
          color: active
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).inputDecorationTheme.fillColor,
          border: Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: BorderRadius.circular(RRadius.medium),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Spaces.small,
          children: [
            Hicon(icon, color: textColor),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: textColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
