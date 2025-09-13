import 'package:fidely_app/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  static const route = "/settings";

  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: TopBar(),
    body: const Center(child: Text("Settings Page")),
  );
}
