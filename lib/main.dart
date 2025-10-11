import 'package:change_case/change_case.dart';
import 'package:fidely_app/app.dart';
import 'package:fidely_app/services/loyalty_card_service.dart';
import 'package:fidely_app/services/photo_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LoyaltyCardService.instance.init();
  await PhotoService.instance.init();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      await getApplicationDocumentsDirectory().then((e) => e.path),
    ),
  );

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
