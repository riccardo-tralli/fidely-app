import 'package:fidely_app/pages/card_page.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final bool roundedBorders;
  final bool showTitle;
  final bool showActions;

  const TopBar({
    super.key,
    this.backgroundColor,
    this.roundedBorders = false,
    this.showTitle = true,
    this.showActions = true,
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
    title: showTitle ? const Text("Fidely") : null,
    actions: showActions ? [addButton(context)] : null,
  );

  Widget addButton(BuildContext context) => IconButton(
    icon: Hicon(HugeIcons.strokeRoundedAddSquare),
    onPressed: () => Navigator.pushNamed(context, CardPage.route),
  );
}
