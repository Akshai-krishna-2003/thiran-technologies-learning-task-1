import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practiceapp/model/news.dart';
import 'package:practiceapp/services/news_service.dart';
import 'package:practiceapp/services/db_service.dart';

// Service providers both news and sqlite3 here
final newsServiceProvider = Provider<NewsService>((ref) => NewsService());
final dbServiceProvider = Provider<DbService>((ref) => DbService());

// FutureProvider that coordinates API -> DB -> UI (with the name of object as articlesProvider)
final articlesProvider = FutureProvider<List<News>>((ref) async {
  final newsService = ref.watch(newsServiceProvider);
  final dbService = ref.watch(dbServiceProvider);

  // 1. Fetch from API
  final fetchedArticles = await newsService.fetchArticles(); 

  // 2. Save to local DB
  await dbService.insertArticles(fetchedArticles);

  // 3. Get all from DB
  final allArticles = await dbService.getAllArticles(); 

  return allArticles;
});
