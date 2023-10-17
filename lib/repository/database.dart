import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DatabaseHelper {
  static final _databaseName = 'IMCDatabase.db';
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<void> initDatabase() async {
    await _initDatabase();
  }

  _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);

    if (!kIsWeb) {
      // Initialize the database for non-web platforms
      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    }
  }

  Future _onCreate(Database db, int version) async {
    // Create the necessary tables if they don't exist
    await db.execute('''
      CREATE TABLE IMC (
        id INTEGER PRIMARY KEY,
        nome TEXT,
        peso REAL,
        altura REAL,
        resultadoIMC REAL,
        classificacao TEXT
      )
    ''');
  }

  Future<int> insertIMC(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert('IMC', row);
  }

  Future<List<Map<String, dynamic>>> queryAllIMC() async {
    Database db = await instance.database;
    return await db.query('IMC');
  }
}
