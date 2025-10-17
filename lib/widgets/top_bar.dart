import 'package:fidely_app/l10n/l10n.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final bool roundedBorders;
  final bool showTitle;
  final Widget? leading;
  final List<Widget>? trailing;

  const TopBar({
    super.key,
    this.backgroundColor,
    this.roundedBorders = false,
    this.showTitle = true,
    this.leading,
    this.trailing,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.secondary,
    surfaceTintColor:
        backgroundColor ?? Theme.of(context).colorScheme.secondary,
    shape: RoundedRectangleBorder(
      borderRadius: roundedBorders
          ? BorderRadius.vertical(bottom: Radius.circular(16))
          : BorderRadius.zero,
    ),
    title: showTitle ? Text(L10n.of(context)?.app_title ?? "Fidely") : null,
    centerTitle: true,
    leading: leading,
    actions: trailing,
  );
}
