import 'package:fidely_app/models/settings/sort_mode.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class SortCubit extends HydratedCubit<SortMode> {
  SortCubit() : super(SortMode(option: SortOption.creationDate));

  @override
  SortMode fromJson(Map<String, dynamic> json) => SortMode.fromMap(json);

  @override
  Map<String, dynamic> toJson(SortMode state) => state.toMap();

  void setOption(SortOption option) => emit(state.copyWith(option: option));
  void toggleReverse() => emit(state.copyWith(reverse: !state.reverse));
}
