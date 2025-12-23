import 'package:fidely_app/cubits/settings/dark_mode_cubit.dart';
import 'package:fidely_app/cubits/settings/language_cubit.dart';
import 'package:fidely_app/di.dart';
import 'package:fidely_app/l10n/l10n.dart';
import 'package:fidely_app/misc/themes/dark.dart';
import 'package:fidely_app/misc/themes/light.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/pages/card_page/card_page.dart';
import 'package:fidely_app/pages/card_page/home_page.dart/home_page.dart';
import 'package:fidely_app/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => DependencyInjector(
    child: BlocBuilder<DarkModeCubit, ThemeMode>(
      builder: (context, themeState) => BlocBuilder<LanguageCubit, String?>(
        builder: (context, languageState) => MaterialApp(
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
