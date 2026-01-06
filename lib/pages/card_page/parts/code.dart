part of "../card_page.dart";

Widget code({
  required BuildContext context,
  required TextEditingController controller,
  required Function onChanged,
  required bool showScanner,
}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Padding(
      padding: EdgeInsets.only(left: Spaces.small),
      child: Text(
        L10n.of(context)!.card_page_input_code_title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    ),
    TextFormField(
      controller: controller,
      onChanged: (value) => onChanged(),
      validator: (value) => value == null || value.isEmpty
          ? L10n.of(context)!.card_page_input_error_required
          : null,
      decoration: showScanner
          ? null
          : InputDecoration(
              suffixIcon: TextButton.icon(
                label: Text(L10n.of(context)!.card_page_input_code_button),
                icon: Hicon(HugeIcons.strokeRoundedBarCode02),
                iconAlignment: IconAlignment.end,
                onPressed: () => onPickUpCode(context),
              ),
            ),
    ),
  ],
);

void onPickUpCode(BuildContext context) => showModalBottomSheet(
  context: context,
  builder: (context) => SafeArea(
    child: Padding(
      padding: EdgeInsets.all(Spaces.medium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Spaces.medium,
        children: [
          Text(
            L10n.of(context)!.card_page_code_pick_title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Row(
            spacing: Spaces.medium,
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    context.read<PermissionCubit>().requestCameraPermission();
                    Navigator.of(context).pop();
                  },
                  icon: Hicon(HugeIcons.strokeRoundedCamera01),
                  label: Text(
                    L10n.of(context)!.card_page_code_pick_buttons_camera,
                  ),
                ),
              ),
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {
                    context.read<PermissionCubit>().requestGalleryPermission();
                    Navigator.of(context).pop();
                  },
                  icon: Hicon(HugeIcons.strokeRoundedAlbum02),
                  label: Text(
                    L10n.of(context)!.card_page_code_pick_buttons_gallery,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  ),
);
