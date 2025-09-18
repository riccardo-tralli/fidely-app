import 'package:fidely_app/services/permission_service.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRepository {
  final PermissionService service;

  PermissionRepository(this.service);

  Future<bool> camera() async {
    try {
      PermissionStatus status = await service.check(Permission.camera);
      if (status != PermissionStatus.granted) {
        status = await service.request(Permission.camera);
      }
      if (status != PermissionStatus.granted) {
        return false;
      }
      return true;
    } catch (_) {
      rethrow;
    }
  }

  Future<bool> gallery() async {
    try {
      PermissionStatus status = await service.check(Permission.photos);
      if (status != PermissionStatus.granted) {
        status = await service.request(Permission.photos);
      }
      if (status != PermissionStatus.granted) {
        return false;
      }
      return true;
    } catch (_) {
      rethrow;
    }
  }
}
