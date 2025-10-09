import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:practiceapp/src/feature/news/domain/model/news.dart';
import 'package:practiceapp/src/feature/news/data/services/news_service.dart';
import 'package:practiceapp/src/feature/news/data/services/db_service.dart';

// Services
final newsServiceProvider = Provider<NewsService>((ref) => NewsService());
final dbServiceProvider = Provider<DbService>((ref) => DbService());

final syncArticlesProvider = FutureProvider<void>((ref) async {
  final newsService = ref.watch(newsServiceProvider);
  final dbService = ref.watch(dbServiceProvider);

  // 1. Fetch from API
  final fetchedArticles = await newsService.fetchArticles();

  // 2. Save all into DB
  await dbService.insertArticles(fetchedArticles);
});

class PaginatedArticlesNotifier extends StateNotifier<AsyncValue<List<News>>> {
  final DbService dbService;
  int _offset = 0;
  final int _limit = 10;
  bool _isFetching = false;

  PaginatedArticlesNotifier(this.dbService)
      : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final page = await dbService.getArticlesPage(_offset, _limit);

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
  final dbService = ref.watch(dbServiceProvider);
  return PaginatedArticlesNotifier(dbService);
});
