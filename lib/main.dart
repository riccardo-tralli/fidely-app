import 'package:change_case/change_case.dart';
import 'package:fidely_app/app.dart';
import 'package:fidely_app/services/loyalty_card_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LoyaltyCardService.instance.init();

  // Configure ChangeCase to handle special characters (accents)
  ChangeCaseConfig.setUp(
    stripPatterns: [RegExp("[^A-Z0-9À-ÿ]+", caseSensitive: false)],
  );

  runApp(const App());
}
