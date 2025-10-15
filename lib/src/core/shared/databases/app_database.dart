import 'package:drift/drift.dart';
import 'package:practiceapp/src/feature/feature2/data/services/feature2_dao.dart';
import 'package:practiceapp/src/feature/feature2/domain/model/feature2.dart';
import 'package:practiceapp/src/feature/feature3/data/services/feature3_dao.dart';
import 'package:practiceapp/src/feature/feature3/domain/model/feature3.dart';
import 'package:practiceapp/src/feature/feature4/data/services/feature4_dao.dart';
import 'package:practiceapp/src/feature/feature4/domain/model/feature4.dart';
import 'drift_database.dart';
import '../../../feature/news/domain/model/news.dart';
import '../../../feature/news/data/services/news_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [NewsTable, Feature2Table, Feature3Table, Feature4Table],
  daos: [NewsDao, Feature2Dao, Feature3Dao, Feature4Dao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(connect());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async => await m.createAll(),
      );
}

// Single global instance to use everywhere
final appDatabase = AppDatabase();
