import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  Future<Database> openMyDatabase() async {
    final dataBasePath = await getDatabasesPath();
    // print(dataBasePath);

    const databaseName = 'news.db';
    const createcmd =
        "CREATE TABLE news(newsId TEXT PRIMARY KEY, title TEXT, description TEXT);";

    return openDatabase(join(dataBasePath, databaseName), version: 1,
        onCreate: (db, version) async {
      await db.execute(createcmd);
    });
  }

  Future<void> insertArticles(List<Map<String, String>> articles) async {
    final db = await openMyDatabase();
    final batch = db.batch();

    for (var article in articles) {
      batch.insert(
        'news',
        {
          'newsId': article['article_id'] ?? '',
          'title': article['title'] ?? '',
          'description': article['description'] ?? '',
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
    await db.close();
  }

  Future<List<Map<String, dynamic>>> getAllArticles() async {
    final db = await openMyDatabase();
    final result = await db.query('news', orderBy: 'newsId ASC');
    await db.close();
    return result;
  }
}
