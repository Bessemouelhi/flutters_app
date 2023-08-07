import 'dart:io';
import 'package:ma_rando/models/parcours_list.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  Database? _database;

  Future<Database> get database async {
    print('get database');
    if (_database != null) return _database!;
    return await createDatabase();
  }

  Future<Database> createDatabase() async {
    print('create db');
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'database.db');
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  onCreate(Database database, int version) async {
    print('onCreate');
    await database.execute('''
    CREATE TABLE list (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL)
    ''');

    await database.execute('''
    CREATE TABLE parcours(
      id INTEGER PRIMARY KEY,
      nom TEXT NOT NULL,
      distance REAL,
      depart_lat REAL,
      depart_lng REAL,
      duree REAL,
      difficulte INTEGER,
      note INTEGER,
      date INTEGER,
      image TEXT,
      list INTEGER
    )
    ''');
  }

  Future<List<ParcoursList>> allList() async {
    print('allLists');
    Database db = await database;
    const query = 'SELECT * FROM list';
    List<Map<String, dynamic>> mapList = await db.rawQuery(query);
    return mapList.map((map) => ParcoursList.fromMap(map)).toList();
  }

  //Ajouter des données
  Future<bool> addItemList(String text) async {
    Database db = await database;
    await db.insert('list', {"nom": text});
    return true;
  }

  //Supprimer liste
  Future<bool> removeItem(ParcoursList itemList) async {
    Database db = await database;
    await db.delete('list', where: 'id = ?', whereArgs: [itemList.id]);
    //Supprimer aussi tous les articles liés.
    //await db.delete('article', where: 'list = ?', whereArgs: [itemList.id]);
    return true;
  }
}
