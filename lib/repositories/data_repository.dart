import 'dart:io';

import 'package:fidely_app/models/data.dart';
import 'package:fidely_app/services/data_service.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DataRepository {
  final DataService service;

  const DataRepository(this.service);

  Future<void> export(String path, Data data, bool includePhotos) async {
    try {
      if (includePhotos) {
        String photosPath = join(
          (await getApplicationDocumentsDirectory()).path,
          "photos",
        );
        if (!await Directory(photosPath).list().isEmpty) {
          await service.exportZip(path, data);
        } else {
          await service.exportJson(path, data);
        }
      } else {
        await service.exportJson(path, data);
      }
    } catch (e) {
      rethrow;
    }
  }
}
