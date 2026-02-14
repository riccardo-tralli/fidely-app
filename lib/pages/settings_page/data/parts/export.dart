part of "../export_import_settings_page.dart";

Widget export({
  required BuildContext context,
  required bool includePhotos,
  required Function(bool) onIncludePhotosChanged,
}) => Padding(
  padding: EdgeInsets.all(Spaces.medium),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: Spaces.small,
    children: [
      exportTitle(context),
      exportDescription(context),
      exportImagesOption(context, includePhotos, onIncludePhotosChanged),
      SizedBox(
        width: double.infinity,
        child: exportButton(context, includePhotos),
      ),
    ],
  ),
);

Widget exportTitle(BuildContext context) => Row(
  spacing: Spaces.small,
  children: [
    Hicon(
      HugeIcons.strokeRoundedDownload03,
      color: Theme.of(context).colorScheme.primary,
    ),
    Text(
      L10n.of(context)!.export_import_settings_page_export_title,
      style: Theme.of(context).textTheme.headlineSmall,
    ),
  ],
);

Widget exportDescription(BuildContext context) =>
    Text(L10n.of(context)!.export_import_settings_page_export_description);

Widget exportImagesOption(
  BuildContext context,
  bool includePhotos,
  Function(bool) onIncludePhotosChanged,
) => SwitchListTile(
  value: includePhotos,
  onChanged: (value) => onIncludePhotosChanged(value),
  contentPadding: EdgeInsets.zero,
  title: Text(
    L10n.of(context)!.export_import_settings_page_export_images_options_title,
    style: Theme.of(context).textTheme.bodyMedium,
  ),
  subtitle: Text(
    includePhotos
        ? L10n.of(
            context,
          )!.export_import_settings_page_export_images_options_include
        : L10n.of(
            context,
          )!.export_import_settings_page_export_images_options_exclude,
    style: Theme.of(context).textTheme.bodySmall,
  ),
);

Widget exportButton(BuildContext context, bool includePhotos) =>
    FilledButton.icon(
      onPressed: () => context.read<DataCubit>().export(includePhotos),
      label: Text(L10n.of(context)!.export_import_settings_page_export_button),
    );
