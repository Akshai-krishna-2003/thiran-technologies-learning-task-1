import 'package:drift/drift.dart';
import '../../../../core/shared/databases/app_database.dart';
import '../../domain/model/news.dart'; 

part 'news_dao.g.dart';

@DriftAccessor(tables: [NewsTable])
class NewsDao extends DatabaseAccessor<AppDatabase> with _$NewsDaoMixin {
  NewsDao(AppDatabase db) : super(db);

  /// Insert multiple articles into local DB
  Future<void> insertArticles(List<News> articles) async {
    await batch((batch) {
      batch.insertAll(
        newsTable, 
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
