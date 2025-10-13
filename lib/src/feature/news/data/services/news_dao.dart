import 'dart:isolate';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import '../../../../core/shared/databases/app_database.dart';
import '../../domain/model/news.dart';

part 'news_dao.g.dart';

@DriftAccessor(tables: [NewsTable])
class NewsDao extends DatabaseAccessor<AppDatabase> with _$NewsDaoMixin {
  NewsDao(AppDatabase db) : super(db);

  /// Insert multiple articles into local DB using a background isolate
  Future<void> insertArticles(List<News> articles) async {
    final receivePort = ReceivePort();

    //  Get root isolate token from the main Flutter isolate
    final rootIsolateToken = RootIsolateToken.instance!;

    // Spawn isolate and pass token + articles
    await Isolate.spawn(_insertInBackground, [receivePort.sendPort, rootIsolateToken, articles]);

    // Wait until isolate confirms completion
    await receivePort.first;
  }

  /// Fetch all articles
  Future<List<NewsTableData>> getAllArticles() async {
    return await select(newsTable).get();
  }

  /// Paginated fetch
  Future<List<NewsTableData>> getArticlesPage(int offset, int limit) async {
    return await (select(newsTable)
          ..limit(limit, offset: offset)
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.author)]))
        .get();
  }

  /// Clear all records
  Future<void> clearAll() async {
    await delete(newsTable).go();
  }
}

/// Runs inside the background isolate
Future<void> _insertInBackground(List<dynamic> args) async {
  final SendPort sendPort = args[0];
  final RootIsolateToken rootToken = args[1];
  final List<News> articles = args[2];

  //  Initialize Flutter engine communication in this isolate
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootToken);

  //  Now plugin calls (like path_provider) will work
  final db = AppDatabase();

  await db.batch((batch) {
    batch.insertAll(
      db.newsTable,
      articles
          .map(
            (a) => NewsTableCompanion.insert(
              author: Value(a.author),
              title: Value(a.title),
              description: Value(a.description),
            ),
          )
          .toList(),
      mode: InsertMode.insertOrReplace,
    );
  });

  await db.close();
  sendPort.send(true);
}
