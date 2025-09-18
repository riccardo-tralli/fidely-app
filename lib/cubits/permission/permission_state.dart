part of "permission_cubit.dart";

sealed class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object> get props => [];
}

class PermissionInitialState extends PermissionState {}

class PermissionLoadingState extends PermissionState {}

class PermissionGrantedState extends PermissionState {
  final Permission permission;

  const PermissionGrantedState(this.permission);

  @override
  List<Object> get props => [permission];
}

class PermissionDeniedState extends PermissionState {
  final String message;

  const PermissionDeniedState(this.message);

  @override
  List<Object> get props => [message];
}
