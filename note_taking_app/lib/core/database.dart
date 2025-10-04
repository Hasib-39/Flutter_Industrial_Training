import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._();
  static Database? _database;

  AppDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String dbPath;
    if (kIsWeb) {
      dbPath = 'notes_app.db';
      final factory = databaseFactoryWeb;
      return await factory.openDatabase(dbPath);
    } else {
      final appDir = await getApplicationDocumentsDirectory();
      await appDir.create(recursive: true);
      dbPath = '${appDir.path}/notes_app.db';
      return databaseFactoryIo.openDatabase(dbPath);
    }
  }
}
