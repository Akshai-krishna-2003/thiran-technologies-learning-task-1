import 'dart:isolate';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:practiceapp/src/app/global_items.dart';
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
    // final rootIsolateToken = RootIsolateToken.instance!;  // Now this is global right no need to create this again and again

    // Spawn isolate and pass token + articles
    final defIsolate = await Isolate.spawn(_insertInBackground,
        [receivePort.sendPort, rootIsolateToken, articles]);

    // Wait until isolate confirms completion
    await receivePort.first;

    defIsolate.kill();
  }

  /// Fetch all articles
  Future<List<NewsTableData>> getAllArticles() async {
    return await select(newsTable).get();
  }

  /// Paginated fetch
  Future<List<NewsTableData>> getArticlesPage(int offset, int limit) async {
    return await (select(newsTable)..limit(limit, offset: offset)).get();
  }

  /// Paginated sorted articles --> This function will be invoked when I click the button for title
  Future<List<NewsTableData>> getSortedPaginatedForTitle(
      int offset, int limit) async {
    return await (select(newsTable)
          ..limit(limit, offset: offset)
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.title)]))
        .get();
  }

  /// Paginated sorted articles --> Same but only for description
  Future<List<NewsTableData>> getSortedPaginatedForDescription(
      int offset, int limit) async {
    return await (select(newsTable)
          ..limit(limit, offset: offset)
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.description)]))
        .get();
  }

  Future<List<NewsTableData>> getSortedPaginated(
    String column, {
    required bool ascending,
    required int offset,
    required int limit,
  }) async {
    List<OrderClauseGenerator<NewsTable>> orderByClause;

    switch (column) {
      case 'title':
        orderByClause = [
          (tbl) => ascending
              ? OrderingTerm.asc(tbl.title.collate(Collate.noCase))
              : OrderingTerm.desc(tbl.title.collate(Collate.noCase))
        ];
        break;
      case 'description':
        orderByClause = [
          (tbl) => ascending
              ? OrderingTerm.asc(tbl.description.collate(Collate.noCase))
              : OrderingTerm.desc(tbl.description.collate(Collate.noCase))
        ];
        break;

      default:
        orderByClause = [(tbl) => OrderingTerm.asc(tbl.id)];
    }

    return await (select(newsTable)
          ..limit(limit, offset: offset)
          ..orderBy(orderByClause))
        .get();
  }

  /// Clear all records
  Future<void> clearAll() async {
    await delete(newsTable).go();
  }

  /// Searching data inside the database for title
  Future<List<NewsTableData>> getSearchArticleTitle(String sTitle) async {
    final abcd = await (select(newsTable)
          ..where((u) => u.title.collate(Collate.noCase).like("%$sTitle%")))
        .get();
    for (var a in abcd) {
      print(a.title);
    }
    print(abcd.length);
    return abcd;
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
