import 'package:drift/drift.dart';
import 'package:practiceapp/src/feature/feature2/data/services/feature2_dao.dart';
import 'package:practiceapp/src/feature/feature2/domain/model/feature2.dart';
import 'drift_database.dart';
import '../../../feature/news/domain/model/news.dart';
import '../../../feature/news/data/services/news_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [NewsTable, Feature2Table],
  daos: [NewsDao, Feature2Dao],
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
