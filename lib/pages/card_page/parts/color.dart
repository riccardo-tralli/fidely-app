part of "../card_page.dart";

Widget color({
  required BuildContext context,
  required Color colorValue,
  required void Function(Color) onColorChange,
}) => InkWell(
  onTap: () => _onTap(context, colorValue, onColorChange),
  child: Container(
    padding: EdgeInsets.symmetric(
      horizontal: Spaces.medium,
      vertical: Spaces.medium,
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).inputDecorationTheme.fillColor,
      border: Border.all(
        color: Theme.of(context).inputDecorationTheme.border!.borderSide.color,
      ),
      borderRadius: BorderRadius.circular(RRadius.medium),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12, // Looks better than 8 or 16
      children: [
        Hicon(HugeIcons.strokeRoundedPaintBoard, color: colorValue),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                L10n.of(context)!.card_page_color_title,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                L10n.of(context)!.card_page_color_description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);

void _onTap(
  BuildContext context,
  Color colorValue,
  Function(Color) onColorChange,
) {
  Color tempColor = colorValue;

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(L10n.of(context)!.card_page_color_pick_title),
      content: ColorDialog(
        initialColor: colorValue,
        onColorChange: (color) => tempColor = color,
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actionsOverflowButtonSpacing: Spaces.small,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(L10n.of(context)!.card_page_color_pick_buttons_cancel),
        ),
        FilledButton.icon(
          onPressed: () {
            onColorChange(tempColor);
            Navigator.of(context).pop();
          },
          icon: Hicon(HugeIcons.strokeRoundedCheckmarkSquare03),
          label: Text(L10n.of(context)!.card_page_color_pick_buttons_confirm),
        ),
      ],
    ),
  );
}
