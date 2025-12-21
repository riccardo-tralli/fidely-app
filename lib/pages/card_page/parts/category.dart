part of "../card_page.dart";

Widget category({
  required BuildContext context,
  required String? initialValue,
  required Function(String?) onChanged,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.only(left: Spaces.small),
      child: Text(L10n.of(context)!.card_page_input_category_title),
    ),
    DropdownButtonFormField<String?>(
      initialValue: initialValue,
      items: _categories(context),
      onChanged: (value) => onChanged(value),
      style: Theme.of(context).textTheme.bodyLarge,
    ),
  ],
);

List<DropdownMenuItem<String?>> _categories(BuildContext context) =>
    Categories(context).list
        .map(
          (e) => DropdownMenuItem<String?>(
            value: e.name,
            child: Row(
              spacing: Spaces.small,
              children: [
                if (e.icon != null) Hicon(e.icon!),
                Text(e.label, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
        )
        .toList();
