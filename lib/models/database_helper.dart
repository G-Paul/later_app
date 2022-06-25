import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import './block.dart';

class DatabaseHelper {
  static final _dbName = 'laterDatabase.db';
  static final _dbVersion = 1;
  // static final _tableName = "blockTable";
  // static final _columnId = "_id";
  // static final _columnTitle = "title";
  // static final _columnUrl = "url";
  // static final _columnDate = "date";

  // Making a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await _initiateDatabase();
    return _database;
  }

  _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        ${BlockFields.id} INTEGER PRIMARY KEY AUTOINCREMENT, 
        ${BlockFields.title} TEXT NOT NULL, 
        ${BlockFields.url} TEXT NOT NULL, 
        ${BlockFields.date} TEXT NOT NULL
      ) ;
      
      ''');
  }

  Future<Block> insertBlock(Block block) async {
    final db = await instance.database;
    final id = await db!.insert(tableName, block.toRow());
    return block.copy(id: id);
  }

  Future<Block?> readSingleBlock(int id) async {
    final db = await instance.database;

    final maps = await db!.query(
      tableName,
      columns: BlockFields.values,
      where: '${BlockFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Block.fromRow(maps.first);
    } else {
      return null;
    }
  }

  Future<List<Block>> readAllBlock() async {
    final db = await instance.database;
    final orderBy = '${BlockFields.date} DESC';
    final result = await db!.query(tableName, orderBy: orderBy);
    return result.map((row) => Block.fromRow(row)).toList();
  }

  Future<int> updateBlock(Block block) async {
    final db = await instance.database;

    return db!.update(
      tableName,
      block.toRow(),
      where: '${BlockFields.id} = ?',
      whereArgs: [block.id],
    );
  }

  Future<int> deleteBlock(int id) async {
    final db = await instance.database;
    return await db!
        .delete(tableName, where: '${BlockFields.id} = ?', whereArgs: [id]);
  }

  Future closedb() async {
    final db = await instance.database;
    db?.close();
  }
}
