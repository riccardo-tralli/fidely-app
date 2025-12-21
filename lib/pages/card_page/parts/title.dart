part of "../card_page.dart";

Widget title({
  required BuildContext context,
  required TextEditingController controller,
  required Function onChanged,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.only(left: Spaces.small),
      child: Text(
        L10n.of(context)!.card_page_input_store_name_title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
    TextFormField(
      controller: controller,
      onChanged: (value) => onChanged(),
      validator: (value) => value == null || value.isEmpty
          ? L10n.of(context)!.card_page_input_error_required
          : null,
    ),
  ],
);
