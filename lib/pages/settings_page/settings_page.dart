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

part "parts/theme_mode.dart";
part "parts/view_mode.dart";
part "parts/sort_mode.dart";
part "parts/language.dart";

class SettingsPage extends StatefulWidget {
  static const route = "/settings";

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
      child: SingleChildScrollView(
        child: Column(
          spacing: Spaces.medium,
          children: [
            themeMode(context: context),
            viewMode(context: context),
            sortMode(context: context),
            language(context: context),
          ],
        ),
      ),
    ),
  );
}
