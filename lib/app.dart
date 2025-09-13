import 'package:fidely_app/di.dart';
import 'package:fidely_app/misc/themes/light.dart';
import 'package:fidely_app/models/loyalty_card.dart';
import 'package:fidely_app/pages/card_page.dart';
import 'package:fidely_app/pages/home_page.dart';
import 'package:fidely_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => DependencyInjector(
    child: MaterialApp(
      theme: LightTheme.make(),
      title: "Fidely",
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
  );
}
