import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class ExportImportSettingsPage extends StatefulWidget {
  static const String route = "/settings/export_import";

  const ExportImportSettingsPage({super.key});

  @override
  State<ExportImportSettingsPage> createState() =>
      _ExportImportSettingsPageState();
}

class _ExportImportSettingsPageState extends State<ExportImportSettingsPage> {
  bool _includeImages = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(showTitle: false),
      body: Padding(
        padding: EdgeInsets.all(Spaces.medium),
        child: content(context),
      ),
    );
  }

  Widget content(BuildContext context) => SingleChildScrollView(
    child: Column(
      spacing: Spaces.extraLarge,
      children: [
        Card(elevation: 1, child: export(context)),
        Card(elevation: 1, child: import(context)),
      ],
    ),
  );

  Widget export(BuildContext context) => Padding(
    padding: EdgeInsets.all(Spaces.medium),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: Spaces.small,
      children: [
        exportTitle(context),
        exportDescription(context),
        exportImagesOption(context),
        SizedBox(width: double.infinity, child: exportButton(context)),
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

  Widget exportImagesOption(BuildContext context) => SwitchListTile(
    value: _includeImages,
    onChanged: (value) => setState(() => _includeImages = value),
    contentPadding: EdgeInsets.zero,
    title: Text(
      L10n.of(context)!.export_import_settings_page_export_images_options_title,
      style: Theme.of(context).textTheme.bodyMedium,
    ),
    subtitle: Text(
      _includeImages
          ? L10n.of(
              context,
            )!.export_import_settings_page_export_images_options_include
          : L10n.of(
              context,
            )!.export_import_settings_page_export_images_options_exclude,
      style: Theme.of(context).textTheme.bodySmall,
    ),
  );

  Widget exportButton(BuildContext context) => FilledButton.icon(
    onPressed: () => (),
    label: Text(L10n.of(context)!.export_import_settings_page_export_button),
  );

  Widget import(BuildContext context) => Padding(
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
}
