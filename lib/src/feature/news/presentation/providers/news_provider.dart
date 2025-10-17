import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practiceapp/src/app/global_items.dart';
import 'package:practiceapp/src/core/shared/databases/app_database.dart';
import '../../../news/data/services/news_dao.dart';
import 'package:practiceapp/src/feature/news/data/services/news_service.dart';
import 'package:practiceapp/src/feature/news/domain/model/news.dart';
import 'package:flutter_riverpod/legacy.dart';

/// DAO provider
final newsDaoProvider = Provider<NewsDao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.newsDao;
});

enum SortOption {
  none,
  titleAsc,
  titleDesc,
  descriptionAsc,
  descriptionDesc,
}

/// API service provider
final newsServiceProvider = Provider<NewsService>((ref) => NewsService());

/// Sort option selector
final selectedSortProvider =
    StateProvider<SortOption>((ref) => SortOption.none);

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
  SortOption sortOption;

  PaginatedArticlesNotifier(this.newsDao, {required this.sortOption})
      : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      List<NewsTableData> rows;

      //  Pick DAO query depending on sort option
      switch (sortOption) {
        case SortOption.titleAsc:
          rows = await newsDao.getSortedPaginated('title',
              ascending: true, offset: _offset, limit: _limit);
          break;
        case SortOption.titleDesc:
          rows = await newsDao.getSortedPaginated('title',
              ascending: false, offset: _offset, limit: _limit);
          break;
        case SortOption.descriptionAsc:
          rows = await newsDao.getSortedPaginated('description',
              ascending: true, offset: _offset, limit: _limit);
          break;
        case SortOption.descriptionDesc:
          rows = await newsDao.getSortedPaginated('description',
              ascending: false, offset: _offset, limit: _limit);
          break;
        default:
          rows = await newsDao.getArticlesPage(_offset, _limit);
      }

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

  Future<void> refresh({SortOption? newSort}) async {
    _offset = 0;
    if (newSort != null) sortOption = newSort;
    state = const AsyncValue.loading();
    await loadMore();
  }
}

final paginatedArticlesProvider =
    StateNotifierProvider<PaginatedArticlesNotifier, AsyncValue<List<News>>>(
  (ref) {
    final dao = ref.watch(newsDaoProvider);
    final sortOption = ref.watch(selectedSortProvider);
    return PaginatedArticlesNotifier(dao, sortOption: sortOption);
  },
);
