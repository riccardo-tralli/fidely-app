import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<PermissionStatus> check(Permission permission) async =>
      await permission.status;

  Future<PermissionStatus> request(Permission permission) async =>
      await permission.request();
}
