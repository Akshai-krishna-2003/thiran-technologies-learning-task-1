import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:practiceapp/src/app/global_items.dart';
import 'package:practiceapp/src/feature/feature3/data/services/feature3_api.dart';
import 'package:practiceapp/src/feature/feature3/data/services/feature3_dao.dart';
import 'package:practiceapp/src/feature/feature3/domain/model/feature3.dart';

/// This is the DAO provider for Feature3
final feature3DaoProvider = Provider<Feature3Dao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.feature3Dao;
});

/// API provider for Feature3
final feat3ApiProvider = Provider<Feature3Api>((ref) => Feature3Api());

/// Sync provider (data from Api to database)
final syncFeat3Provider = FutureProvider<void>((ref) async {
  final feat3Service = ref.watch(feat3ApiProvider);
  final feat3Dao = ref.watch(feature3DaoProvider);

  // get the List<Feature3> from api
  final valuesFromFeat3Api = await feat3Service.getDataForFeat3();

  // Store it in local Drift DB
  await feat3Dao.insertFunction(valuesFromFeat3Api);
});

/// Paginated provider
class PaginatedFeat3Notifier extends StateNotifier<AsyncValue<List<Feature3>>> {
  final Feature3Dao feature3Dao;
  final int _limit = 10;
  int _offset = 0;
  bool _isFetching = false;

  PaginatedFeat3Notifier(this.feature3Dao) : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final rows = await feature3Dao.getArticlesPage(_offset, _limit);
      final page = rows
          .map((r) =>
              Feature3(id: r.id, title: r.title, description: r.description))
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
final paginatedFeat3Provider =
    StateNotifierProvider<PaginatedFeat3Notifier, AsyncValue<List<Feature3>>>(
        (ref) {
  final dao = ref.watch(feature3DaoProvider);
  return PaginatedFeat3Notifier(dao);
});
