import 'package:comic_vine_app/data/exeption.dart';

import 'package:comic_vine_app/data/model/issues_model.dart';
import 'package:comic_vine_app/domain/entities/comic_entity.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatasource {
  static final LocalDatasource _instance = LocalDatasource._();
  static Database? _database;

  LocalDatasource._();

  factory LocalDatasource() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'comics.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
  await db.execute('''
    CREATE TABLE comics(
      id INTEGER PRIMARY KEY,
      name TEXT,
      issue_number TEXT,
      store_date TEXT,
      volume TEXT,
      image TEXT,
      character_credits TEXT,
      concept_credits TEXT,
      location_credits TEXT,
      person_credits TEXT,
      team_credits TEXT
    )
  ''');
}

//function to insert comic

  Future<int> insertComic({required Comic comic}) async {
    final db = await database;
    return await db.insert(
      'comics',
      comic.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

//function to update comic

  Future<int> updateComic({required Comic comic}) async {
  final db = await database;
  return await db.update(
    'comics',
    comic.toJson(),
    where: 'id = ?',
    whereArgs: [comic.id],
  );
}

//function to find comic by Id.

  Future<ComicsModel> getComicById({required int id}) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'comics',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      return ComicsModel.fromJson(result.first);
    } else {
      throw LocalExeption();
    }
  }

//function to delete register with id 

  Future<int> deleteComic({required int id}) async {
  final db = await database;
  return await db.delete(
    'comics',
    where: 'id = ?',
    whereArgs: [id],
  );
}


}
