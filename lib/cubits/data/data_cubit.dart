import 'package:equatable/equatable.dart';
import 'package:fidely_app/models/data.dart';
import 'package:fidely_app/models/settings/sort_mode.dart';
import 'package:fidely_app/repositories/data_repository.dart';
import 'package:fidely_app/repositories/loyalty_card_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part "data_cubit_state.dart";

class DataCubit extends Cubit<DataCubitState> {
  final LoyaltyCardRepository cardRepository;
  final DataRepository dataRepository;

  DataCubit({required this.cardRepository, required this.dataRepository})
    : super(const DataCubitInitialState());

  void export(bool includePhotos) async {
    emit(DataCubitLoadingState(DataOperation.export));
    try {
      List<Map<String, dynamic>>? data = await cardRepository.get(
        SortMode(option: SortOption.alphabetical),
        true,
      );
      if (data != null) {
        String? path = await FilePicker.platform.getDirectoryPath();
        if (path != null) {
          await dataRepository.export(path, Data(cards: data), includePhotos);
          emit(DataCubitExportSuccessState());
        } else {
          reset();
        }
      } else {
        emit(const DataCubitErrorState("no_data", DataOperation.export));
      }
    } catch (e) {
      emit(DataCubitErrorState(e.toString(), DataOperation.export));
    }
  }

  void reset() => emit(const DataCubitInitialState());
}
