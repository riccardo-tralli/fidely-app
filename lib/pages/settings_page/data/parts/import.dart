part of "../export_import_settings_page.dart";

Widget import({required BuildContext context}) => Padding(
  padding: EdgeInsets.all(Spaces.medium),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    spacing: Spaces.small,
    children: [
      importTitle(context),
      importDescription(context),
      SizedBox(width: double.infinity, child: importButton(context)),
    ],
  ),
);

Widget importTitle(BuildContext context) => Row(
  spacing: Spaces.small,
  children: [
    Hicon(
      HugeIcons.strokeRoundedUpload03,
      color: Theme.of(context).colorScheme.primary,
    ),
    Text(
      L10n.of(context)!.export_import_settings_page_import_title,
      style: Theme.of(context).textTheme.headlineSmall,
    ),
  ],
);

Widget importDescription(BuildContext context) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  spacing: Spaces.small,
  children: [
    Text(L10n.of(context)!.export_import_settings_page_import_description),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Spaces.small,
      children: [
        Hicon(
          HugeIcons.strokeRoundedAlert02,
          color: Theme.of(context).colorScheme.error,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                L10n.of(
                  context,
                )!.export_import_settings_page_import_alert_title,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                L10n.of(
                  context,
                )!.export_import_settings_page_import_alert_description,
              ),
            ],
          ),
        ),
      ],
    ),
  ],
);

Widget importButton(BuildContext context) => FilledButton.icon(
  onPressed: () => (),
  label: Text(L10n.of(context)!.export_import_settings_page_import_button),
);
