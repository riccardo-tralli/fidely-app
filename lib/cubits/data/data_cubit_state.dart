part of "data_cubit.dart";

sealed class DataCubitState extends Equatable {
  const DataCubitState();

  @override
  List<Object> get props => [];
}

final class DataCubitInitialState extends DataCubitState {
  const DataCubitInitialState();
}

final class DataCubitLoadingState extends DataCubitState {
  final DataOperation operation;

  const DataCubitLoadingState(this.operation);

  @override
  List<Object> get props => [operation];
}

final class DataCubitExportSuccessState extends DataCubitState {
  const DataCubitExportSuccessState();
}

final class DataCubitImportSuccessState extends DataCubitState {
  const DataCubitImportSuccessState();
}

final class DataCubitErrorState extends DataCubitState {
  final String message;
  final DataOperation operation;

  const DataCubitErrorState(this.message, this.operation);

  @override
  List<Object> get props => [message, operation];
}

enum DataOperation { export, import }
