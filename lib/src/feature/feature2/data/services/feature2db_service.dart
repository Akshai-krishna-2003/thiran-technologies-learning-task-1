import 'dart:async';

import 'package:path/path.dart';
import 'package:practiceapp/src/feature/feature2/domain/model/feature2.dart';
import 'package:sqflite/sqflite.dart';

class Feature2dbService {
  Future<Database> openMyDatabase() async {
    final databasePath = await getDatabasesPath();
    const databaseName = "akshai.db";
    const createcmd =
        "CREATE TABLE Feature2 nickname TEXT, github_profile TEXT, link TEXT";

    return openDatabase(join(databasePath, databaseName), version: 1,
        onCreate: (db, version) async {
      await db.execute(createcmd);
    });
  }

  Future<void> insertArticles(List<Feature2> feature2) async {
    final db = await openMyDatabase();
    final batch = db.batch();

    
  }
}
