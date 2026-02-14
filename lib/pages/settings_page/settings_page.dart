import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/pages/info_page.dart';
import 'package:fidely_app/pages/settings_page/data/export_import_settings_page.dart';
import 'package:fidely_app/pages/settings_page/language_settings_page.dart';
import 'package:fidely_app/pages/settings_page/ui/ui_settings_page.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SettingsPage extends StatefulWidget {
  static const String route = "/settings";

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(),
    body: Padding(
      padding: EdgeInsets.all(Spaces.medium),
      child: settings(context),
    ),
  );

  Widget settings(BuildContext context) => Column(
    spacing: Spaces.medium,
    children: [
      Card(child: Column(children: interface(context))),
      Card(child: Column(children: data(context))),
      Card(child: Column(children: other(context))),
    ],
  );

  List<Widget> interface(BuildContext context) => [
    ListTile(
      leading: Hicon(HugeIcons.strokeRoundedPaintBrush02),
      title: Text(L10n.of(context)!.ui_settings_page_title),
      trailing: Hicon(HugeIcons.strokeRoundedArrowRight01),
      onTap: () => Navigator.pushNamed(context, UiSettingsPage.route),
    ),
    Divider(color: Theme.of(context).colorScheme.surface, height: 0),
    ListTile(
      leading: Hicon(HugeIcons.strokeRoundedLanguageSkill),
      title: Text(L10n.of(context)!.language_settings_page_title),
      trailing: Hicon(HugeIcons.strokeRoundedArrowRight01),
      onTap: () => Navigator.pushNamed(context, LanguageSettingsPage.route),
    ),
  ];

  List<Widget> data(BuildContext context) => [
    // ListTile(
    //   leading: Hicon(HugeIcons.strokeRoundedCloudServer),
    //   title: Text(L10n.of(context)!.backup_settings_page_title),
    //   trailing: Hicon(HugeIcons.strokeRoundedArrowRight01),
    //   onTap: () => Navigator.pushNamed(context, UiSettingsPage.route),
    // ),
    Divider(color: Theme.of(context).colorScheme.surface, height: 0),
    ListTile(
      leading: Hicon(HugeIcons.strokeRoundedDownload03),
      title: Text(L10n.of(context)!.export_import_settings_page_title),
      trailing: Hicon(HugeIcons.strokeRoundedArrowRight01),
      onTap: () => Navigator.pushNamed(context, ExportImportSettingsPage.route),
    ),
  ];

  List<Widget> other(BuildContext context) => [
    ListTile(
      leading: Hicon(HugeIcons.strokeRoundedInformationSquare),
      title: Text(L10n.of(context)!.info_page_title),
      trailing: Hicon(HugeIcons.strokeRoundedArrowRight01),
      onTap: () => Navigator.pushNamed(context, InfoPage.route),
    ),
  ];
}
