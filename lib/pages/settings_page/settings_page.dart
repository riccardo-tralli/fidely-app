import 'package:fidely_app/cubits/settings/dark_mode_cubit.dart';
import 'package:fidely_app/cubits/settings/language_cubit.dart';
import 'package:fidely_app/cubits/settings/sort_cubit.dart';
import 'package:fidely_app/cubits/settings/view_mode_cubit.dart';
import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/models/settings/sort_mode.dart';
import 'package:fidely_app/models/settings/view_mode.dart';
import 'package:fidely_app/widgets/option.dart';
import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

part "parts/view_mode.dart";
part "parts/sort_mode.dart";

class SettingsPage extends StatefulWidget {
  static const route = "/settings";

  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ThemeMode _themeMode;
  late String? _languageCode;

  void onLanguageChange(String? languageCode) {
    setState(() {
      _languageCode = languageCode;
    });
    context.read<LanguageCubit>().set(languageCode);
  }

  @override
  void initState() {
    super.initState();
    _themeMode = context.read<DarkModeCubit>().state;
    _languageCode = context.read<LanguageCubit>().state;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(),
    body: Padding(
      padding: EdgeInsets.all(Spaces.medium),
      child: SingleChildScrollView(
        child: Column(
          spacing: Spaces.medium,
          children: [
            themeModeOption(context),
            viewMode(context: context),
            sortMode(context: context),
            languageOption(context),
          ],
        ),
      ),
    ),
  );

  Widget themeModeOption(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        L10n.of(context)!.settings_page_theme_title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      Text(L10n.of(context)!.settings_page_theme_description),
      SizedBox(height: Spaces.small),
      IntrinsicHeight(
        child: Row(
          spacing: Spaces.medium,
          children: [
            Expanded(
              child: Option(
                context: context,
                icon: HugeIcons.strokeRoundedSun02,
                label: L10n.of(context)!.settings_page_theme_mode_light,
                onTap: () {
                  setState(() {
                    _themeMode = ThemeMode.light;
                  });
                  context.read<DarkModeCubit>().set(ThemeMode.light);
                },
                active: _themeMode == ThemeMode.light,
              ),
            ),
            Expanded(
              child: Option(
                context: context,
                icon: HugeIcons.strokeRoundedMoon01,
                label: L10n.of(context)!.settings_page_theme_mode_dark,
                onTap: () {
                  setState(() {
                    _themeMode = ThemeMode.dark;
                  });
                  context.read<DarkModeCubit>().set(ThemeMode.dark);
                },
                active: _themeMode == ThemeMode.dark,
              ),
            ),
            Expanded(
              child: Option(
                context: context,
                icon: HugeIcons.strokeRoundedSmartPhone02,
                label: L10n.of(context)!.settings_page_theme_mode_system,
                onTap: () {
                  setState(() {
                    _themeMode = ThemeMode.system;
                  });
                  context.read<DarkModeCubit>().set(ThemeMode.system);
                },
                active: _themeMode == ThemeMode.system,
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget languageOption(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        L10n.of(context)!.settings_page_language_title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      Text(L10n.of(context)!.settings_page_language_description),
      SizedBox(height: Spaces.small),
      DropdownButtonFormField(
        initialValue: _languageCode,
        items: [
          DropdownMenuItem(
            value: null,
            child: Text(L10n.of(context)!.settings_page_language_option_system),
          ),
          DropdownMenuItem(
            value: "en",
            child: Text(
              L10n.of(context)!.settings_page_language_option_english,
            ),
          ),
          DropdownMenuItem(
            value: "fr",
            child: Text(L10n.of(context)!.settings_page_language_option_french),
          ),
          DropdownMenuItem(
            value: "es",
            child: Text(
              L10n.of(context)!.settings_page_language_option_spanish,
            ),
          ),
          DropdownMenuItem(
            value: "it",
            child: Text(
              L10n.of(context)!.settings_page_language_option_italian,
            ),
          ),
        ],
        onChanged: (value) => onLanguageChange(value),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    ],
  );
}
