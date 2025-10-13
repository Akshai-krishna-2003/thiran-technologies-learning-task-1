import 'dart:nativewrappers/_internal/vm/lib/isolate_patch.dart';

import 'package:drift/drift.dart';
import 'package:practiceapp/src/core/shared/databases/app_database.dart';
import 'package:practiceapp/src/feature/feature2/domain/model/feature2.dart';

@DriftAccessor(tables: [Feature2Table])
class Feature2Dao extends DatabaseAccessor<AppDatabase> {
  Feature2Dao(AppDatabase db) : super(db);

  Future<void> insertFunction(List<Feature2> feat2) async {
    final recievePort = ReceivePort();

    final ghiIsolate = await Isolate.spawn(_insertFunctionVal, []);
  }
}

void _insertFunctionVal(List<dynamic> args) {
  
}
