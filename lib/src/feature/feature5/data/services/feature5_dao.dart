import 'dart:isolate';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:practiceapp/src/app/global_items.dart';
import 'package:practiceapp/src/core/shared/databases/app_database.dart';
import 'package:practiceapp/src/feature/feature5/domain/model/feature5.dart';

part 'feature5_dao.g.dart';

@DriftAccessor(tables: [Feature5Table])
class Feature5Dao extends DatabaseAccessor<AppDatabase>
    with _$Feature5DaoMixin {
  Feature5Dao(AppDatabase db) : super(db);

  /// Insert list of Feature5 objects in a background isolate
  Future<void> insertFunction(List<Feature5> feat5List) async {
    final receivePort = ReceivePort();

    final isolate = await Isolate.spawn(
      _insertFunctionVal,
      [rootIsolateToken, feat5List, receivePort.sendPort],
    );

    await receivePort.first; // Wait for isolate completion
    isolate.kill();
  }

  /// Fetch paginated flags (for lazy loading / infinite scroll)
  Future<List<Feature5TableData>> getFlagsPage(int offset, int limit) async {
    return await (select(feature5Table)
          ..limit(limit, offset: offset)
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.id)]))
        .get();
  }

  /// Delete all flags (for resync)
  Future<void> clearAll() async {
    await delete(feature5Table).go();
  }
}

/// Background isolate function for inserting data efficiently
void _insertFunctionVal(List<dynamic> args) async {
  final RootIsolateToken rit = args[0];
  final List<Feature5> feat5List = args[1];
  final SendPort sendPort = args[2];

  // Initialize background isolate communication
  BackgroundIsolateBinaryMessenger.ensureInitialized(rit);

  final db = AppDatabase();

  await db.batch((batch) {
    batch.insertAll(
      db.feature5Table,
      feat5List
          .map(
            (a) => Feature5TableCompanion.insert(
              id: a.id,
              pngUrl: Value(a.pngUrl),
              svgUrl: Value(a.svgUrl),
              description: Value(a.description),
              downloadedPath: Value(a.downloadedPath),
            ),
          )
          .toList(),
      mode: InsertMode.insertOrReplace,
    );
    print("Feature5 data inserted!");
  });

  await db.close();
  sendPort.send(true);
}
