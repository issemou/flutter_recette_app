import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/recette.dart';

class RecetteDatabase{

  RecetteDatabase._();

  static final RecetteDatabase instance = RecetteDatabase._();
  static Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async{
    WidgetsFlutterBinding.ensureInitialized();
    return await openDatabase(
      join(await getDatabasesPath(), 'recette.db'),
      onCreate: (db, version){
        return db.execute(
          "CREATE  TABLE IF NOT EXISTS  recette("
              "titre text PRIMARY KEY,"
              "user text,"
              "imageUrl text,"
              "description text,"
              "isFavorite int,"
              "favoriteCount int"
              ");"
        );
      },
      version: 1,
    );
  }

  void insertRecette(recette r) async{

    final Database db = await database;

    await db.insert('recette',
        r.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  void updateRecette(recette r) async{

    final Database db = await database;
    await db.update('recette',
        r.toMap(),
      where: 'titre = ?', whereArgs: [r.titre]
    );
  }

  void deleRecette(String titre) async {
    final db = await database;
    db.delete('recette', where: 'titre = ?', whereArgs: [titre]);
  }

  Future<List<recette>> recettes() async{
    final Database db = await database;
    final List<Map<String, dynamic>>maps = await db.query('recette');
    List<recette> recettes = List.generate(maps.length, (i) => recette.fromMap(maps[i]));
    print(recettes);
    if(recettes.isEmpty){
      for (recette r in defaultRecettes){
        insertRecette(r);
      }
    }
    return recettes;
  }


  List<recette> defaultRecettes = [
    recette("Pizzas Bolonaise", "ridovic", "assets/images/menu_background.jpg",
        "La pizza viande step 1", true, 3),
    recette("Pizzas Algerienne", "ridovic", "assets/images/menu_background.jpg",
        "La pizza viande step 1", true, 20),
    recette("Pizzas Italienne", "ridovic", "assets/images/menu_background.jpg",
        "La pizza viande step 1", true, 30),
    recette("Pizzas Camerounnaise", "ridovic", "assets/images/menu_background.jpg",
        "La pizza viande step 1", true, 1000),
    recette("Pizzas Vegetarienne", "ridovic", "assets/images/menu_background.jpg",
        "La pizza viande step 1", true, 1),
    recette("Pizzas polonaise", "ridovic", "assets/images/menu_background.jpg",
        "La pizza viande step 1", true, 10),
    recette("Pizzas japonaise", "ridovic", "assets/images/menu_background.jpg",
        "La pizza viande step 1", true, 10),
    recette("Pizzas canadienne", "ridovic", "assets/images/menu_background.jpg",
        "La pizza viande step 1", true, 10)
  ];
}