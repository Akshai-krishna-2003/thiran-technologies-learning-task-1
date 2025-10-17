import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:practiceapp/src/app/global_items.dart';
import 'package:practiceapp/src/feature/feature4/data/services/feature4_dao.dart';
import 'package:practiceapp/src/feature/feature4/data/services/feature4api_service.dart';
import 'package:practiceapp/src/feature/feature4/domain/model/feature4.dart';

/// This is the DAO provider for Feature4
final feature4DaoProvider = Provider<Feature4Dao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.feature4Dao;
});

/// API provider for Feature4
final feat4ApiProvider = Provider<Feature4Api>((ref) => Feature4Api());

/// Sync provider (data from Api to database)
final syncFeat4Provider = FutureProvider<void>((ref) async {
  final feat4Service = ref.watch(feat4ApiProvider);
  final feat4Dao = ref.watch(feature4DaoProvider);

  final localArticles = await feat4Dao.getArticlesPage(0, 1);

  if (localArticles.isNotEmpty) {
    return;
  }

  // get the List<Feature4> from api
  final valuesFromFeat4Api = await feat4Service.getDataForFeat4();

  // Store it in local Drift DB
  await feat4Dao.insertFunction(valuesFromFeat4Api);
});

/// Paginated provider
class PaginatedFeat4Notifier extends StateNotifier<AsyncValue<List<Feature4>>> {
  final Feature4Dao feature4Dao;
  final int _limit = 10;
  int _offset = 0;
  bool _isFetching = false;

  PaginatedFeat4Notifier(this.feature4Dao) : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final rows = await feature4Dao.getArticlesPage(_offset, _limit);
      final page = rows
          .map((r) =>
              Feature4(id: r.id, name: r.name ?? '', webUrl: r.webUrl ?? ''))
          .toList();
      if (state.hasValue) {
        state = AsyncValue.data([...state.value!, ...page]);
      } else {
        state = AsyncValue.data(page);
      }

      _offset += _limit;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
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

/// To check for pagination changes
final paginatedFeat4Provider =
    StateNotifierProvider<PaginatedFeat4Notifier, AsyncValue<List<Feature4>>>(
        (ref) {
  final dao = ref.watch(feature4DaoProvider);
  return PaginatedFeat4Notifier(dao);
});
