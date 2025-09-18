import 'package:equatable/equatable.dart';
import 'package:fidely_app/repositories/permission_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

part "permission_state.dart";

class PermissionCubit extends Cubit<PermissionState> {
  final PermissionRepository repository;

  PermissionCubit({required this.repository}) : super(PermissionInitialState());

  Future<void> requestCameraPermission() async {
    emit(PermissionLoadingState());
    try {
      final bool granted = await repository.camera();
      if (granted) {
        emit(PermissionGrantedState(Permission.camera));
      } else {
        emit(PermissionDeniedState("Camera permission denied"));
      }
    } catch (e) {
      emit(PermissionDeniedState(e.toString()));
    }
  }

  Future<void> requestGalleryPermission() async {
    emit(PermissionLoadingState());
    try {
      final bool granted = await repository.gallery();
      if (granted) {
        emit(PermissionGrantedState(Permission.photos));
      } else {
        emit(PermissionDeniedState("Gallery permission denied"));
      }
    } catch (e) {
      emit(PermissionDeniedState(e.toString()));
    }
  }
}
