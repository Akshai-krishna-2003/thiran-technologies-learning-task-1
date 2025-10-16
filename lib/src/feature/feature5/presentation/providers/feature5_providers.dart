import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:practiceapp/src/app/global_items.dart';
import 'package:practiceapp/src/feature/feature5/data/services/feature5_dao.dart';
import 'package:practiceapp/src/feature/feature5/data/services/feature5api_service.dart';
import 'package:practiceapp/src/feature/feature5/domain/model/feature5.dart';

/// DAO provider for Feature5
final feature5DaoProvider = Provider<Feature5Dao>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.feature5Dao;
});

/// API provider for Feature5
final feat5ApiProvider = Provider<Feature5Api>((ref) => Feature5Api());

/// Sync provider — fetch from API and store in Drift DB
final syncFeat5Provider = FutureProvider<void>((ref) async {
  final feat5Service = ref.watch(feat5ApiProvider);
  final feat5Dao = ref.watch(feature5DaoProvider);

  // Fetch List<Feature5> from API
  final valuesFromFeat5Api = await feat5Service.getDataForFeat5();

  // Insert into local DB
  await feat5Dao.insertFunction(valuesFromFeat5Api);
});

/// Pagination notifier for Feature5 flags
class PaginatedFeat5Notifier extends StateNotifier<AsyncValue<List<Feature5>>> {
  final Feature5Dao feature5Dao;
  final int _limit = 10;
  int _offset = 0;
  bool _isFetching = false;

  PaginatedFeat5Notifier(this.feature5Dao) : super(const AsyncValue.loading()) {
    loadMore();
  }

  Future<void> loadMore() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      final rows = await feature5Dao.getFlagsPage(_offset, _limit);
      final page = rows
          .map((r) => Feature5(
                id: r.id,
                pngUrl: r.pngUrl ?? '',
                svgUrl: r.svgUrl ?? '',
                description: r.description ?? '',
                downloadedPath: r.downloadedPath ?? '',
              ))
          .toList();

      if (state.hasValue) {
        // Append new page to current data
        state = AsyncValue.data([...state.value!, ...page]);
      } else {
        // Initial load
        state = AsyncValue.data(page);
      }

      _offset += _limit;
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    } finally {
      _isFetching = false;
    }
  }

  /// Refresh data
  Future<void> refresh() async {
    _offset = 0;
    state = const AsyncValue.loading();
    await loadMore();
  }
}

/// Provider for pagination state
final paginatedFeat5Provider =
    StateNotifierProvider<PaginatedFeat5Notifier, AsyncValue<List<Feature5>>>(
        (ref) {
  final dao = ref.watch(feature5DaoProvider);
  return PaginatedFeat5Notifier(dao);
});
