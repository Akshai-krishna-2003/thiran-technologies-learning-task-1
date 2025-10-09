import 'package:path/path.dart';
import 'package:practiceapp/src/feature/domain/model/news.dart';
import 'package:sqflite/sqflite.dart';

class DbService {
  Future<Database> openMyDatabase() async {
    final dataBasePath = await getDatabasesPath();
    print(dataBasePath);

    const databaseName = 'news.db';
    const createcmd =
        "CREATE TABLE news(author TEXT, title TEXT, description TEXT);";

    return openDatabase(join(dataBasePath, databaseName), version: 1,
        onCreate: (db, version) async {
      await db.execute(createcmd);
    });
  }

  Future<void> insertArticles(List<News> articles) async {
    final db = await openMyDatabase();
    final batch = db.batch();

    for (var article in articles) {
      batch.insert(
        'news',
        {
          'author': article.author,
          'title': article.title,
          'description': article.description,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
    await db.close();
  }

  Future<List<News>> getAllArticles() async {
    final db = await openMyDatabase();
    final result = await db.query('news', orderBy: 'author ASC');
    await db.close();

    return result.map((row) => News.fromJson(row)).toList();
  }

  // Paginated
  Future<List<News>> getArticlesPage(int offset, int limit) async {
    final db = await openMyDatabase();
    final result = await db.query(
      'news',
      orderBy: 'author ASC',
      limit: limit,
      offset: offset,
    );
    await db.close();

    return result.map((row) => News.fromJson(row)).toList();
  }
}
