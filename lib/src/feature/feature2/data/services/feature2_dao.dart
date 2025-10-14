import 'dart:isolate';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:practiceapp/src/app/global_items.dart';
import 'package:practiceapp/src/core/shared/databases/app_database.dart';
import 'package:practiceapp/src/feature/feature2/domain/model/feature2.dart';

part 'feature2_dao.g.dart';

@DriftAccessor(tables: [Feature2Table])
class Feature2Dao extends DatabaseAccessor<AppDatabase>
    with _$Feature2DaoMixin {
  Feature2Dao(AppDatabase db) : super(db);

  Future<void> insertFunction(List<Feature2> feat2) async {
    final recievePort = ReceivePort();

    final ghiIsolate = await Isolate.spawn(
        _insertFunctionVal, [rootIsolateToken, feat2, recievePort.sendPort]);

    await recievePort.first;
    ghiIsolate.kill();
  }

  // Fetching only paginated articles
  Future<List<Feature2TableData>> getArticlesPage(int offset, int limit) async {
    return await (select(feature2Table)
          ..limit(limit, offset: offset)
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.nickname)]))
        .get();
  }


  // Clear feature 2
  Future<void> clearAll() async {
    await delete(feature2Table).go();
  }
}

void _insertFunctionVal(List<dynamic> args) async {
  final RootIsolateToken rit = args[0];
  final List<Feature2> feat2 = args[1];
  final SendPort sp = args[2];

  // This ensures the engine can communicate with isolates
  BackgroundIsolateBinaryMessenger.ensureInitialized(rit);

  final db = AppDatabase();

  await db.batch((batch) {
    batch.insertAll(
      db.feature2Table,
      feat2
          .map(
            (a) => Feature2TableCompanion.insert(
              nickname: Value(a.nickname),
              gProfile: Value(a.gProfile),
              link: Value(a.link), 
            ),
          )
          .toList(),
      mode: InsertMode.insertOrReplace,
    );
    print("Data inserted! ");
  });

  await db.close();
  sp.send(true); // hence the isolate is ded when it reaches here
}
