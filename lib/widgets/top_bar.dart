import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final String? title;
  final bool showTitle;
  final List<Widget>? actions;

  const TopBar({
    super.key,
    this.backgroundColor,
    this.title,
    this.showTitle = true,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;

    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      surfaceTintColor: backgroundColor ?? Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
        statusBarBrightness: brightness,
      ),
      title: showTitle
          ? Text(
              title ?? L10n.of(context)?.app_title ?? "Fidely",
              style: title != null
                  ? Theme.of(context).textTheme.headlineSmall
                  : Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
            )
          : null,
      centerTitle: false,
      actions: actions,
      actionsPadding: EdgeInsets.only(top: Spaces.small, right: Spaces.small),
    );
  }
}
