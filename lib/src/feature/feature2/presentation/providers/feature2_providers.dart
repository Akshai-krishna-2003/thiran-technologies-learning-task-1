import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:practiceapp/src/app/global_items.dart';
import 'package:practiceapp/src/feature/feature2/data/services/feature2_dao.dart';
import 'package:practiceapp/src/feature/feature2/data/services/feature2api_service.dart';
import 'package:practiceapp/src/feature/feature2/domain/model/feature2.dart';

/// This is the DAO provider for Feature2
final feature2DaoProvider = Provider<Feature2Dao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.feature2Dao;
});

/// API provider for Feature2
final feat2ApiProvider = Provider<Feature2API>((ref) => Feature2API());

/// Sync provider (data from Api to database)
final syncFeat2Provider = FutureProvider<void>((ref) async {
  final feat2Service = ref.watch(feat2ApiProvider);
  final feat2Dao = ref.watch(feature2DaoProvider);

  // get the List<Feature2> from api
  final valuesFromFeat2Api = await feat2Service.getFromApi();

  // Store it in local Drift DB
  await feat2Dao.insertFunction(valuesFromFeat2Api);
});

/// Paginated provider -->  To show inside the UI (May be 10-10)
class PaginatedFeat2Notifier extends StateNotifier<AsyncValue<List<Feature2>>> {
  final Feature2Dao feature2Dao;
  final int _limit = 10;
  int _offset = 0;
  bool _isFetching = false;

  PaginatedFeat2Notifier(this.feature2Dao) : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final rows = await feature2Dao.getArticlesPage(_offset, _limit);
      final page = rows
          .map((r) => Feature2(
              nickname: r.nickname ?? '',
              gProfile: r.gProfile ?? '',
              link: r.link ?? ''))
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
final paginatedFeat2Provider =
    StateNotifierProvider<PaginatedFeat2Notifier, AsyncValue<List<Feature2>>>(
        (ref) {
  final dao = ref.watch(feature2DaoProvider);
  return PaginatedFeat2Notifier(dao);
});
