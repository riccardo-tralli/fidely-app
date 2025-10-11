import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class DarkModeCubit extends HydratedCubit<ThemeMode> {
  DarkModeCubit() : super(ThemeMode.system);

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) => ThemeMode.values.firstWhere(
    (e) => e.name == json["themeMode"],
    orElse: () => ThemeMode.system,
  );

  @override
  Map<String, dynamic>? toJson(ThemeMode state) => {"themeMode": state.name};

  void set(ThemeMode mode) => emit(mode);
}
