import 'dart:io';
import 'package:ma_rando/models/parcours.dart';
import 'package:ma_rando/models/parcours_list.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseClient {
  Database? _database;

  // Cette méthode permet de récupérer ou de créer la base de données
  Future<Database> get database async {
    print('get database');
    if (_database != null) return _database!;
    return await createDatabase();
  }

  // Cette méthode crée la base de données et les tables
  Future<Database> createDatabase() async {
    print('create db');
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'database.db');

    // Ouvre la base de données en utilisant le chemin et la version
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  // Cette méthode est appelée lors de la création de la base de données
  onCreate(Database database, int version) async {
    print('onCreate');
    // Crée la table 'list' pour les listes de parcours
    await database.execute('''
    CREATE TABLE list (
    id INTEGER PRIMARY KEY,
    nom TEXT NOT NULL)
    ''');

    // Crée la table 'parcours' pour stocker les détails des parcours
    await database.execute('''
    CREATE TABLE parcours (
      id INTEGER PRIMARY KEY,
      nom TEXT NOT NULL,
      distance REAL,
      depart_lat REAL,
      depart_lng REAL,
      duree REAL,
      difficulte INTEGER,
      note INTEGER,
      date INTEGER NOT NULL DEFAULT (cast(strftime('%s','now') as int)),
      image TEXT,
      list INTEGER
    )
    ''');
  }

  // Cette méthode récupère toutes les listes de parcours
  Future<List<ParcoursList>> allList() async {
    print('allLists');
    Database db = await database;
    const query = 'SELECT * FROM list';
    List<Map<String, dynamic>> mapList = await db.rawQuery(query);
    return mapList.map((map) => ParcoursList.fromMap(map)).toList();
  }

  // Cette méthode ajoute un nouvel élément à la liste
  Future<bool> addItemList(String text) async {
    Database db = await database;
    await db.insert('list', {"nom": text});
    return true;
  }

  // Cette méthode un parcours
  Future<bool> remove(Parcours parcours) async {
    Database db = await database;
    await db.delete('parcours', where: 'id = ?', whereArgs: [parcours.id]);
    return true;
  }

  // Cette méthode ajoute ou met à jour un parcours
  Future<bool> upsert(Parcours parcours) async {
    Database db = await database;
    (parcours.id == null)
        ? parcours.id = await db.insert('parcours', parcours.toMap())
        : await db.update('parcours', parcours.toMap(),
            where: 'id = ?', whereArgs: [parcours.id]);
    return true;
  }

  // Cette méthode récupère tous les parcours d'une liste spécifique
  Future<List<Parcours>> parcoursFromId(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> mapList =
        await db.query('parcours', where: 'list = ?', whereArgs: [id]);
    return mapList.map((map) => Parcours.fromMap(map)).toList();
  }

  // Cette méthode récupère tous les parcours
  Future<List<Parcours>> parcoursAll() async {
    Database db = await database;
    List<Map<String, dynamic>> mapList = await db.query('parcours');
    return mapList.map((map) => Parcours.fromMap(map)).toList();
  }
}
