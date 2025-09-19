import 'package:change_case/change_case.dart';
import 'package:fidely_app/app.dart';
import 'package:fidely_app/services/loyalty_card_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LoyaltyCardService.instance.init();

  // Configure ChangeCase to handle special characters (accents)
  ChangeCaseConfig.setUp(
    stripPatterns: [RegExp("[^A-Z0-9À-ÿ]+", caseSensitive: false)],
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const App());
}
