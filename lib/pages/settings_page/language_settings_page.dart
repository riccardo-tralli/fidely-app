import 'package:fidely_app/cubits/settings/language_cubit.dart';
import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/spaces.dart';
import 'package:fidely_app/widgets/hicon.dart';
import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';

class LanguageSettingsPage extends StatelessWidget {
  static const String route = "/settings/language";

  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String?>> languageCodes = [
      {
        "code": null,
        "label": L10n.of(context)!.settings_page_language_option_system,
      },
      {
        "code": "en",
        "label": L10n.of(context)!.settings_page_language_option_english,
      },
      {
        "code": "es",
        "label": L10n.of(context)!.settings_page_language_option_spanish,
      },
      {
        "code": "fr",
        "label": L10n.of(context)!.settings_page_language_option_french,
      },
      {
        "code": "it",
        "label": L10n.of(context)!.settings_page_language_option_italian,
      },
    ];

    return Scaffold(
      appBar: TopBar(title: L10n.of(context)!.language_settings_page_title),
      body: Padding(
        padding: EdgeInsets.all(Spaces.medium),
        child: SingleChildScrollView(
          child: Card(
            child: BlocBuilder<LanguageCubit, String?>(
              builder: (context, state) =>
                  Column(children: languages(context, languageCodes, state)),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> languages(
    BuildContext context,
    List<Map<String, String?>> codes,
    String? selected,
  ) => List.generate(
    codes.length,
    (index) => Column(
      children: [
        ListTile(
          // leading: Hicon(HugeIcons.strokeRoundedFlag02),
          title: Text(codes[index]["label"]!),
          trailing: selected == codes[index]["code"]
              ? Hicon(HugeIcons.strokeRoundedTick01)
              : null,
          selected: selected == codes[index]["code"],
          onTap: () => context.read<LanguageCubit>().set(codes[index]["code"]),
        ),
        if (index < codes.length - 1)
          Divider(color: Theme.of(context).colorScheme.surface, height: 0),
      ],
    ),
  );
}
