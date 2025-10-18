import 'package:hydrated_bloc/hydrated_bloc.dart';

class LanguageCubit extends HydratedCubit<String?> {
  LanguageCubit() : super(null);

  @override
  String? fromJson(Map<String, dynamic> json) => json["language"] as String?;

  @override
  Map<String, dynamic> toJson(String? state) => {"language": state};

  void set(String? languageCode) => emit(languageCode);
}
