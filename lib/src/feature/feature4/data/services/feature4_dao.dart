import 'dart:isolate';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:practiceapp/src/app/global_items.dart';
import 'package:practiceapp/src/core/shared/databases/app_database.dart';
import 'package:practiceapp/src/feature/feature4/domain/model/feature4.dart';

part 'feature4_dao.g.dart';

@DriftAccessor(tables: [Feature4Table])

class Feature4Dao extends DatabaseAccessor<AppDatabase>
    with _$Feature4DaoMixin {
  Feature4Dao(AppDatabase db) : super(db);

  Future<void> insertFunction(List<Feature4> feat4) async {
    final recievePort = ReceivePort();

    final ghiIsolate = await Isolate.spawn(
        _insertFunctionVal, [rootIsolateToken, feat4, recievePort.sendPort]);

    await recievePort.first;
    ghiIsolate.kill();
  }

  // Fetching only paginated articles
  Future<List<Feature4TableData>> getArticlesPage(int offset, int limit) async {
    return await (select(feature4Table)
          ..limit(limit, offset: offset)
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.id)]))
        .get();
  }

  // Clear feature 4
  Future<void> clearAll() async {
    await delete(feature4Table).go();
  }
}

void _insertFunctionVal(List<dynamic> args) async {
  final RootIsolateToken rit = args[0];
  final List<Feature4> feat4 = args[1];
  final SendPort sp = args[2];

  // This ensures the engine can communicate with isolates
  BackgroundIsolateBinaryMessenger.ensureInitialized(rit);

  final db = AppDatabase();

  await db.batch((batch) {
    batch.insertAll(
      db.feature4Table,
      feat4
          .map(
            (a) => Feature4TableCompanion.insert(
              id: a.id,
              name: Value(a.name),
              webUrl: Value(a.webUrl),
            ),
          )
          .toList(),
      mode: InsertMode.insertOrReplace,
    );
    print("Data inserted! ");
  });

  await db.close();
  sp.send(true);
}
