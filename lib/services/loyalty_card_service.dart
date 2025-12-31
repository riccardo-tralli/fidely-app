import "package:fidely_app/models/loyalty_card.dart";
import "package:fidely_app/models/requests/loyalty_card_request.dart";
import "package:fidely_app/models/settings/sort_mode.dart";
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

class LoyaltyCardService {
  static const String _dbName = "cards.db";
  static const int _dbVersion = 3;
  static const String _tableName = "cards";
  late Database _db;

  // Singleton pattern -->
  static final LoyaltyCardService instance = LoyaltyCardService._internal();

  factory LoyaltyCardService() => instance;

  LoyaltyCardService._internal();
  // <-- Singleton pattern

  Future<void> init() async {
    final String path = await getDatabasesPath();
    String dbPath = join(path, _dbName);

    _db = await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, code TEXT, type TEXT, owner TEXT, color TEXT, note TEXT, category TEXT, favorite INTEGER, usage_count INTEGER)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion == 1 && newVersion == 2) {
          await db.execute("ALTER TABLE $_tableName ADD COLUMN category TEXT");
        }
        if (oldVersion == 2 && newVersion == 3) {
          await db.execute(
            "ALTER TABLE $_tableName ADD COLUMN favorite INTEGER",
          );
          await db.execute(
            "ALTER TABLE $_tableName ADD COLUMN usage_count INTEGER",
          );
        }
      },
    );
  }

  Future<List<Map<String, dynamic>>> get(SortMode mode) async =>
      await _db.query(
        _tableName,
        orderBy: switch (mode.option) {
          SortOption.creationDate => "id ${mode.reverse ? "DESC" : "ASC"}",
          SortOption.alphabetical => "title ${mode.reverse ? "DESC" : "ASC"}",
          SortOption.category => "category ${mode.reverse ? "DESC" : "ASC"}",
        },
      );

  Future<int> create(LoyaltyCardInsertRequest request) async =>
      await _db.insert(_tableName, request.toMap());

  Future<int> update(LoyaltyCard card) async => await _db.update(
    _tableName,
    card.toMap(),
    where: "id = ?",
    whereArgs: [card.id],
  );

  Future<int> delete(LoyaltyCard card) async =>
      await _db.delete(_tableName, where: "id = ?", whereArgs: [card.id]);
}
