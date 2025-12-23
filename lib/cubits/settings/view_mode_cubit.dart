import 'package:fidely_app/models/settings/view_mode.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ViewModeCubit extends HydratedCubit<ViewMode> {
  ViewModeCubit() : super(ViewMode());

  @override
  ViewMode fromJson(Map<String, dynamic> json) => ViewMode.fromMap(json);

  @override
  Map<String, dynamic>? toJson(ViewMode state) => state.toMap();

  void setColumns(int columns) => emit(state.copyWith(columns: columns));
  void setUsePhoto(bool usePhoto) => emit(state.copyWith(usePhoto: usePhoto));
}
