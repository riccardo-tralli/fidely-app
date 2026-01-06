part of "../card_page.dart";

Widget save({
  required BuildContext context,
  required Function(BuildContext) onTap,
}) => Align(
  alignment: Alignment.bottomCenter,
  child: Container(
    padding: EdgeInsets.all(Spaces.large),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      border: Border(
        top: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
    ),
    child: SizedBox(
      width: double.infinity,
      child: FilledButton(
        // TODO: disable button when loading/saving
        onPressed: () => onTap(context),
        style: Theme.of(context).filledButtonTheme.style?.copyWith(
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: Text(
          L10n.of(context)!.card_page_save_button_title,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: Colors.white),
        ),
      ),
    ),
  ),
);
