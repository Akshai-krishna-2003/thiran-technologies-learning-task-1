import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practiceapp/src/app/global_items.dart';
import '../../../news/data/services/news_dao.dart';
import 'package:practiceapp/src/feature/news/data/services/news_service.dart';
import 'package:practiceapp/src/feature/news/domain/model/news.dart';
import 'package:flutter_riverpod/legacy.dart';

/// DAO provider
final newsDaoProvider = Provider<NewsDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.newsDao;
});

/// API service provider
final newsServiceProvider = Provider<NewsService>((ref) => NewsService());

/// Sync provider — Fetch from API → Insert into Drift
final syncArticlesProvider = FutureProvider<void>((ref) async {
  final newsService = ref.watch(newsServiceProvider);
  final newsDao = ref.watch(newsDaoProvider);

  final localArticles = await newsDao.getArticlesPage(0, 1);

  if (localArticles.isNotEmpty) {
    return;
  }

  // 1. Fetch from API (no DB logic in service)
  final fetchedArticles = await newsService.fetchArticles();

  // 2. Save into local Drift DB
  await newsDao.insertArticles(fetchedArticles);

  print("Synced ${fetchedArticles.length} articles into Drift DB");
});

/// Paginated provider — reads from Drift DB
class PaginatedArticlesNotifier extends StateNotifier<AsyncValue<List<News>>> {
  final NewsDao newsDao;
  int _offset = 0;
  final int _limit = 10;
  bool _isFetching = false;

  PaginatedArticlesNotifier(this.newsDao) : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final rows = await newsDao.getArticlesPage(_offset, _limit);
      final page = rows
          .map((r) => News(
                author: r.author ?? '',
                title: r.title ?? '',
                description: r.description ?? '',
              ))
          .toList();

      if (state.hasValue) {
        state = AsyncValue.data([...state.value!, ...page]);
      } else {
        state = AsyncValue.data(page);
      }

      _offset += _limit;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    } finally {
      _isFetching = false;
    }
  }

  Future<void> refresh() async {
    _offset = 0;
    state = const AsyncValue.loading();
    await loadMore();
  }
}

final paginatedArticlesProvider =
    StateNotifierProvider<PaginatedArticlesNotifier, AsyncValue<List<News>>>(
  (ref) {
    final dao = ref.watch(newsDaoProvider);
    return PaginatedArticlesNotifier(dao);
  },
);
