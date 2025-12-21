part of "../card_page.dart";

Widget note({
  required BuildContext context,
  required TextEditingController controller,
  required Function onChanged,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.only(left: Spaces.small),
      child: Text(L10n.of(context)!.card_page_input_notes_title),
    ),
    TextFormField(
      controller: controller,
      onChanged: (value) => onChanged(),
      maxLines: 3,
    ),
  ],
);
