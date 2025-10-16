import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practiceapp/src/core/shared/databases/app_database.dart';

///  Get root isolate token from the main Flutter isolate
final rootIsolateToken = RootIsolateToken.instance!;

/// Database provider
final appDatabaseProvider = Provider<AppDatabase>((ref) => appDatabase);

Future<Directory> documentDirectory = getApplicationDocumentsDirectory();
