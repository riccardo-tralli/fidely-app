import 'package:fidely_app/pages/card_page.dart';
import 'package:fidely_app/pages/home_page.dart';
import 'package:fidely_app/pages/settings_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: "Fidely",
    initialRoute: HomePage.route,
    routes: {
      HomePage.route: (_) => const HomePage(),
      CardPage.route: (_) => const CardPage(),
      SettingsPage.route: (_) => const SettingsPage(),
    },
  );
}
