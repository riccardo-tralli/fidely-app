import 'package:fidely_app/pages/card_page.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor;
  final bool showTitle;
  final bool showActions;

  const TopBar({
    super.key,
    this.backgroundColor = Colors.transparent,
    this.showTitle = true,
    this.showActions = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) => AppBar(
    backgroundColor: backgroundColor,
    title: showTitle ? const Text("Fidely") : null,
    actions: showActions ? [addButton(context)] : null,
  );

  Widget addButton(BuildContext context) => IconButton(
    icon: const Icon(Icons.add),
    onPressed: () => Navigator.pushNamed(context, CardPage.route),
  );
}
