import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Opens a lazy connection to a local SQLite database using Drift.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'app_database.sqlite'));
    // print("Final path of database is: ${file.path}");
    return NativeDatabase.createInBackground(file);
  });
}

/// Creates a DatabaseConnection usable by Drift.
DatabaseConnection connect() =>
    DatabaseConnection.fromExecutor(_openConnection());
