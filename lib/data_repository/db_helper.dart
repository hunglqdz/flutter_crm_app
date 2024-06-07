import 'dart:io';

import 'package:flutter_crm_app/models/item.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  late Database database;
  static DbHelper dbHelper = DbHelper();
  final String tableName = 'items';
  final String idColumn = 'id';
  final String nameColumn = 'name';
  final String noteColumn = 'note';
  final String imageColumn = 'image';

  initDatabase() async {
    database = await connectToDatabase();
  }

  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '$directory/items.db';
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $noteColumn TEXT, $imageColumn TEXT)');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(
            'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT, $nameColumn TEXT, $noteColumn TEXT, $imageColumn TEXT)');
      },
      onDowngrade: (db, oldVersion, newVersion) {
        db.delete(tableName);
      },
    );
  }

  Future<List<Item>> getAllItems() async {
    List<Map<String, dynamic>> tasks = await database.query(tableName);
    return tasks.map((e) => Item.fromMap(e)).toList();
  }

  addNewItem(Item item) {
    database.insert(tableName, item.toMap());
  }

  deleteItem(Item item) {
    database.delete(tableName, where: '$idColumn=?', whereArgs: [item.id]);
  }

  deleteAllItems() {
    database.delete(tableName);
  }

  updateItem(Item item) async {
    await database.update(
      tableName,
      {
        nameColumn: item.name,
        noteColumn: item.note,
        imageColumn: item.image!.path,
      },
      where: '$idColumn=?',
      whereArgs: [item.id],
    );
  }
}
