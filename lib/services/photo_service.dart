import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class PhotoService {
  late final Directory _directory;

  // Singleton pattern -->
  static final PhotoService instance = PhotoService._internal();

  factory PhotoService() => instance;

  PhotoService._internal();
  // <-- Singleton pattern

  Future<void> init() async {
    _directory = await getApplicationDocumentsDirectory();
    if (!await Directory(join(_directory.path, "photos")).exists()) {
      await Directory(join(_directory.path, "photos")).create();
    }
  }

  String getPath(int id, PhotoType type) => join(
    _directory.path,
    "photos",
    "${id.toString()}_${type == PhotoType.front ? "front.jpg" : "rear.jpg"}",
  );

  Future<File?> get(int id, PhotoType type) async {
    final String path = getPath(id, type);
    if (await File(path).exists()) {
      return File(path);
    }
    return null;
  }

  Future<void> save(int id, PhotoType type, File photo) async {
    final String path = getPath(id, type);
    await photo.copy(path);
  }

  Future<void> delete(int id, PhotoType type) async {
    final String path = getPath(id, type);
    if (await File(path).exists()) {
      await File(path).delete();
    }
  }
}

enum PhotoType { front, rear }
