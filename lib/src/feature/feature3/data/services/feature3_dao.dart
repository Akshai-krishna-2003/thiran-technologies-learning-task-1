import 'dart:isolate';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:practiceapp/src/app/global_items.dart';
import 'package:practiceapp/src/core/shared/databases/app_database.dart';
import 'package:practiceapp/src/feature/feature3/domain/model/feature3.dart';

part 'feature3_dao.g.dart';

@DriftAccessor(tables: [Feature3Table])
class Feature3Dao extends DatabaseAccessor<AppDatabase> with _$Feature3DaoMixin {
  Feature3Dao(AppDatabase db) : super(db);

  Future<void> insertFunction(List<Feature3> feat3) async {
    final recievePort = ReceivePort();

    final ghiIsolate = await Isolate.spawn(
        _insertFunctionVal, [rootIsolateToken, feat3, recievePort.sendPort]);

    await recievePort.first;
    ghiIsolate.kill();
  }

  // Fetching only paginated articles
  Future<List<Feature3TableData>> getArticlesPage(int offset, int limit) async {
    return await (select(feature3Table)
          ..limit(limit, offset: offset)
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.id)]))
        .get();
  }

  // Clear feature 3
  Future<void> clearAll() async {
    await delete(feature3Table).go();
  }
}

void _insertFunctionVal(List<dynamic> args) async {
  final RootIsolateToken rit = args[0];
  final List<Feature3> feat3 = args[1];
  final SendPort sp = args[2];

  // This ensures the engine can communicate with isolates
  BackgroundIsolateBinaryMessenger.ensureInitialized(rit);

  final db = AppDatabase();

  await db.batch((batch) {
    batch.insertAll(
      db.feature3Table,
      feat3
          .map(
            (a) => Feature3TableCompanion.insert(
              id: Value(a.id),
              title: a.title,
              description: a.description, 
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