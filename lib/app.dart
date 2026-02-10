import 'package:fidely_app/cubits/settings/dark_mode_cubit.dart';
import 'package:fidely_app/cubits/settings/language_cubit.dart';
import 'package:fidely_app/di.dart';
import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/dark.dart';
import 'package:fidely_app/misc/themes/light.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/pages/card_page/card_page.dart';
import 'package:fidely_app/pages/home_page/home_page.dart';
import 'package:fidely_app/pages/info_page.dart';
import 'package:fidely_app/pages/settings_page/export_import_settings_page.dart';
import 'package:fidely_app/pages/settings_page/language_settings_page.dart';
import 'package:fidely_app/pages/settings_page/settings_page.dart';
import 'package:fidely_app/pages/settings_page/ui/ui_settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => DependencyInjector(
    child: BlocBuilder<DarkModeCubit, ThemeMode>(
      builder: (context, themeState) => BlocBuilder<LanguageCubit, String?>(
        builder: (context, languageState) => MaterialApp(
          debugShowCheckedModeBanner:
              false, // Remove debug banner for screenshots
          theme: LightTheme.make(),
          darkTheme: DarkTheme.make(),
          themeMode: themeState,
          localizationsDelegates: L10n.localizationsDelegates,
          supportedLocales: L10n.supportedLocales,
          locale: languageState != null ? Locale(languageState) : null,
          title: L10n.of(context)?.app_title ?? "Fidely",
          initialRoute: HomePage.route,
          routes: {
            HomePage.route: (_) => const HomePage(),
            SettingsPage.route: (_) => const SettingsPage(),
            UiSettingsPage.route: (_) => const UiSettingsPage(),
            LanguageSettingsPage.route: (_) => const LanguageSettingsPage(),
            ExportImportSettingsPage.route: (_) =>
                const ExportImportSettingsPage(),
            InfoPage.route: (_) => const InfoPage(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == CardPage.route) {
              final LoyaltyCard? card = settings.arguments as LoyaltyCard?;
              return MaterialPageRoute(
                builder: (_) => CardPage(card: card),
                settings: settings,
              );
            }
            return null;
          },
        ),
      ),
    ),
  );
}
