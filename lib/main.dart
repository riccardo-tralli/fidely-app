import 'package:fidely_app/app.dart';
import 'package:fidely_app/services/loyalty_card_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LoyaltyCardService.instance.init();

  runApp(const App());
}
