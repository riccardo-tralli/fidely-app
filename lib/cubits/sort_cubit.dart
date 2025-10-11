import 'package:fidely_app/models/sort_mode.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SortCubit extends HydratedCubit<SortMode> {
  SortCubit() : super(SortMode(option: SortOption.creationDate));

  @override
  SortMode fromJson(Map<String, dynamic> json) => SortMode.fromMap(json);

  @override
  Map<String, dynamic> toJson(SortMode state) => state.toMap();

  void set(SortMode mode) => emit(mode);
}
