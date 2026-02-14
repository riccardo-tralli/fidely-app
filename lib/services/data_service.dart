import 'dart:convert';
import 'dart:io';

import 'package:fidely_app/models/data.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:archive/archive_io.dart';
import 'package:path_provider/path_provider.dart';

class DataService {
  Future<void> exportJson(String path, Data data) async {
    File file = File(
      join(
        path,
        "fidely_export_${DateFormat("yyyyMMdd_HHmmss").format(DateTime.now())}.json",
      ),
    );
    await file.writeAsString(jsonEncode(data.toMap()));
  }

  Future<void> exportZip(String path, Data data) async {
    String fileName = join(
      path,
      "fidely_export_${DateFormat("yyyyMMdd_HHmmss").format(DateTime.now())}",
    );
    String photosPath = join(
      (await getApplicationDocumentsDirectory()).path,
      "photos",
    );

    File jsonFile = File("$fileName.json");
    await jsonFile.writeAsString(jsonEncode(data.toMap()));

    ZipFileEncoder zipFile = ZipFileEncoder();
    zipFile.create("$fileName.zip");
    await zipFile.addFile(jsonFile);
    await zipFile.addDirectory(Directory(photosPath));
    await zipFile.close();
    await jsonFile.delete();
  }
}
