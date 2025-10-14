// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NewsTableTable extends NewsTable
    with TableInfo<$NewsTableTable, NewsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NewsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, author, title, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'news_table';
  @override
  VerificationContext validateIntegrity(Insertable<NewsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NewsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NewsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $NewsTableTable createAlias(String alias) {
    return $NewsTableTable(attachedDatabase, alias);
  }
}

class NewsTableData extends DataClass implements Insertable<NewsTableData> {
  final int id;
  final String? author;
  final String? title;
  final String? description;
  const NewsTableData(
      {required this.id, this.author, this.title, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || author != null) {
      map['author'] = Variable<String>(author);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  NewsTableCompanion toCompanion(bool nullToAbsent) {
    return NewsTableCompanion(
      id: Value(id),
      author:
          author == null && nullToAbsent ? const Value.absent() : Value(author),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory NewsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NewsTableData(
      id: serializer.fromJson<int>(json['id']),
      author: serializer.fromJson<String?>(json['author']),
      title: serializer.fromJson<String?>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'author': serializer.toJson<String?>(author),
      'title': serializer.toJson<String?>(title),
      'description': serializer.toJson<String?>(description),
    };
  }

  NewsTableData copyWith(
          {int? id,
          Value<String?> author = const Value.absent(),
          Value<String?> title = const Value.absent(),
          Value<String?> description = const Value.absent()}) =>
      NewsTableData(
        id: id ?? this.id,
        author: author.present ? author.value : this.author,
        title: title.present ? title.value : this.title,
        description: description.present ? description.value : this.description,
      );
  NewsTableData copyWithCompanion(NewsTableCompanion data) {
    return NewsTableData(
      id: data.id.present ? data.id.value : this.id,
      author: data.author.present ? data.author.value : this.author,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NewsTableData(')
          ..write('id: $id, ')
          ..write('author: $author, ')
          ..write('title: $title, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, author, title, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NewsTableData &&
          other.id == this.id &&
          other.author == this.author &&
          other.title == this.title &&
          other.description == this.description);
}

class NewsTableCompanion extends UpdateCompanion<NewsTableData> {
  final Value<int> id;
  final Value<String?> author;
  final Value<String?> title;
  final Value<String?> description;
  const NewsTableCompanion({
    this.id = const Value.absent(),
    this.author = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
  });
  NewsTableCompanion.insert({
    this.id = const Value.absent(),
    this.author = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
  });
  static Insertable<NewsTableData> custom({
    Expression<int>? id,
    Expression<String>? author,
    Expression<String>? title,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (author != null) 'author': author,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
    });
  }

  NewsTableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? author,
      Value<String?>? title,
      Value<String?>? description}) {
    return NewsTableCompanion(
      id: id ?? this.id,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NewsTableCompanion(')
          ..write('id: $id, ')
          ..write('author: $author, ')
          ..write('title: $title, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $Feature2TableTable extends Feature2Table
    with TableInfo<$Feature2TableTable, Feature2TableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Feature2TableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nicknameMeta =
      const VerificationMeta('nickname');
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
      'nickname', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _gProfileMeta =
      const VerificationMeta('gProfile');
  @override
  late final GeneratedColumn<String> gProfile = GeneratedColumn<String>(
      'g_profile', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, nickname, gProfile, link];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feature2_table';
  @override
  VerificationContext validateIntegrity(Insertable<Feature2TableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nickname')) {
      context.handle(_nicknameMeta,
          nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta));
    }
    if (data.containsKey('g_profile')) {
      context.handle(_gProfileMeta,
          gProfile.isAcceptableOrUnknown(data['g_profile']!, _gProfileMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Feature2TableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Feature2TableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nickname: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nickname']),
      gProfile: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}g_profile']),
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link']),
    );
  }

  @override
  $Feature2TableTable createAlias(String alias) {
    return $Feature2TableTable(attachedDatabase, alias);
  }
}

class Feature2TableData extends DataClass
    implements Insertable<Feature2TableData> {
  final int id;
  final String? nickname;
  final String? gProfile;
  final String? link;
  const Feature2TableData(
      {required this.id, this.nickname, this.gProfile, this.link});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    if (!nullToAbsent || gProfile != null) {
      map['g_profile'] = Variable<String>(gProfile);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    return map;
  }

  Feature2TableCompanion toCompanion(bool nullToAbsent) {
    return Feature2TableCompanion(
      id: Value(id),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      gProfile: gProfile == null && nullToAbsent
          ? const Value.absent()
          : Value(gProfile),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
    );
  }

  factory Feature2TableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Feature2TableData(
      id: serializer.fromJson<int>(json['id']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      gProfile: serializer.fromJson<String?>(json['gProfile']),
      link: serializer.fromJson<String?>(json['link']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nickname': serializer.toJson<String?>(nickname),
      'gProfile': serializer.toJson<String?>(gProfile),
      'link': serializer.toJson<String?>(link),
    };
  }

  Feature2TableData copyWith(
          {int? id,
          Value<String?> nickname = const Value.absent(),
          Value<String?> gProfile = const Value.absent(),
          Value<String?> link = const Value.absent()}) =>
      Feature2TableData(
        id: id ?? this.id,
        nickname: nickname.present ? nickname.value : this.nickname,
        gProfile: gProfile.present ? gProfile.value : this.gProfile,
        link: link.present ? link.value : this.link,
      );
  Feature2TableData copyWithCompanion(Feature2TableCompanion data) {
    return Feature2TableData(
      id: data.id.present ? data.id.value : this.id,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      gProfile: data.gProfile.present ? data.gProfile.value : this.gProfile,
      link: data.link.present ? data.link.value : this.link,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Feature2TableData(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('gProfile: $gProfile, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nickname, gProfile, link);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Feature2TableData &&
          other.id == this.id &&
          other.nickname == this.nickname &&
          other.gProfile == this.gProfile &&
          other.link == this.link);
}

class Feature2TableCompanion extends UpdateCompanion<Feature2TableData> {
  final Value<int> id;
  final Value<String?> nickname;
  final Value<String?> gProfile;
  final Value<String?> link;
  const Feature2TableCompanion({
    this.id = const Value.absent(),
    this.nickname = const Value.absent(),
    this.gProfile = const Value.absent(),
    this.link = const Value.absent(),
  });
  Feature2TableCompanion.insert({
    this.id = const Value.absent(),
    this.nickname = const Value.absent(),
    this.gProfile = const Value.absent(),
    this.link = const Value.absent(),
  });
  static Insertable<Feature2TableData> custom({
    Expression<int>? id,
    Expression<String>? nickname,
    Expression<String>? gProfile,
    Expression<String>? link,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nickname != null) 'nickname': nickname,
      if (gProfile != null) 'g_profile': gProfile,
      if (link != null) 'link': link,
    });
  }

  Feature2TableCompanion copyWith(
      {Value<int>? id,
      Value<String?>? nickname,
      Value<String?>? gProfile,
      Value<String?>? link}) {
    return Feature2TableCompanion(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      gProfile: gProfile ?? this.gProfile,
      link: link ?? this.link,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (gProfile.present) {
      map['g_profile'] = Variable<String>(gProfile.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Feature2TableCompanion(')
          ..write('id: $id, ')
          ..write('nickname: $nickname, ')
          ..write('gProfile: $gProfile, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NewsTableTable newsTable = $NewsTableTable(this);
  late final $Feature2TableTable feature2Table = $Feature2TableTable(this);
  late final NewsDao newsDao = NewsDao(this as AppDatabase);
  late final Feature2Dao feature2Dao = Feature2Dao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [newsTable, feature2Table];
}

typedef $$NewsTableTableCreateCompanionBuilder = NewsTableCompanion Function({
  Value<int> id,
  Value<String?> author,
  Value<String?> title,
  Value<String?> description,
});
typedef $$NewsTableTableUpdateCompanionBuilder = NewsTableCompanion Function({
  Value<int> id,
  Value<String?> author,
  Value<String?> title,
  Value<String?> description,
});

class $$NewsTableTableFilterComposer
    extends Composer<_$AppDatabase, $NewsTableTable> {
  $$NewsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
}

class $$NewsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NewsTableTable> {
  $$NewsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get author => $composableBuilder(
      column: $table.author, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $$NewsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NewsTableTable> {
  $$NewsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get author =>
      $composableBuilder(column: $table.author, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
}

class $$NewsTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $NewsTableTable,
    NewsTableData,
    $$NewsTableTableFilterComposer,
    $$NewsTableTableOrderingComposer,
    $$NewsTableTableAnnotationComposer,
    $$NewsTableTableCreateCompanionBuilder,
    $$NewsTableTableUpdateCompanionBuilder,
    (
      NewsTableData,
      BaseReferences<_$AppDatabase, $NewsTableTable, NewsTableData>
    ),
    NewsTableData,
    PrefetchHooks Function()> {
  $$NewsTableTableTableManager(_$AppDatabase db, $NewsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NewsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NewsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NewsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> author = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
          }) =>
              NewsTableCompanion(
            id: id,
            author: author,
            title: title,
            description: description,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> author = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
          }) =>
              NewsTableCompanion.insert(
            id: id,
            author: author,
            title: title,
            description: description,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$NewsTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $NewsTableTable,
    NewsTableData,
    $$NewsTableTableFilterComposer,
    $$NewsTableTableOrderingComposer,
    $$NewsTableTableAnnotationComposer,
    $$NewsTableTableCreateCompanionBuilder,
    $$NewsTableTableUpdateCompanionBuilder,
    (
      NewsTableData,
      BaseReferences<_$AppDatabase, $NewsTableTable, NewsTableData>
    ),
    NewsTableData,
    PrefetchHooks Function()>;
typedef $$Feature2TableTableCreateCompanionBuilder = Feature2TableCompanion
    Function({
  Value<int> id,
  Value<String?> nickname,
  Value<String?> gProfile,
  Value<String?> link,
});
typedef $$Feature2TableTableUpdateCompanionBuilder = Feature2TableCompanion
    Function({
  Value<int> id,
  Value<String?> nickname,
  Value<String?> gProfile,
  Value<String?> link,
});

class $$Feature2TableTableFilterComposer
    extends Composer<_$AppDatabase, $Feature2TableTable> {
  $$Feature2TableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gProfile => $composableBuilder(
      column: $table.gProfile, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnFilters(column));
}

class $$Feature2TableTableOrderingComposer
    extends Composer<_$AppDatabase, $Feature2TableTable> {
  $$Feature2TableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nickname => $composableBuilder(
      column: $table.nickname, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gProfile => $composableBuilder(
      column: $table.gProfile, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnOrderings(column));
}

class $$Feature2TableTableAnnotationComposer
    extends Composer<_$AppDatabase, $Feature2TableTable> {
  $$Feature2TableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get gProfile =>
      $composableBuilder(column: $table.gProfile, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);
}

class $$Feature2TableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $Feature2TableTable,
    Feature2TableData,
    $$Feature2TableTableFilterComposer,
    $$Feature2TableTableOrderingComposer,
    $$Feature2TableTableAnnotationComposer,
    $$Feature2TableTableCreateCompanionBuilder,
    $$Feature2TableTableUpdateCompanionBuilder,
    (
      Feature2TableData,
      BaseReferences<_$AppDatabase, $Feature2TableTable, Feature2TableData>
    ),
    Feature2TableData,
    PrefetchHooks Function()> {
  $$Feature2TableTableTableManager(_$AppDatabase db, $Feature2TableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$Feature2TableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$Feature2TableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$Feature2TableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> nickname = const Value.absent(),
            Value<String?> gProfile = const Value.absent(),
            Value<String?> link = const Value.absent(),
          }) =>
              Feature2TableCompanion(
            id: id,
            nickname: nickname,
            gProfile: gProfile,
            link: link,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String?> nickname = const Value.absent(),
            Value<String?> gProfile = const Value.absent(),
            Value<String?> link = const Value.absent(),
          }) =>
              Feature2TableCompanion.insert(
            id: id,
            nickname: nickname,
            gProfile: gProfile,
            link: link,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$Feature2TableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $Feature2TableTable,
    Feature2TableData,
    $$Feature2TableTableFilterComposer,
    $$Feature2TableTableOrderingComposer,
    $$Feature2TableTableAnnotationComposer,
    $$Feature2TableTableCreateCompanionBuilder,
    $$Feature2TableTableUpdateCompanionBuilder,
    (
      Feature2TableData,
      BaseReferences<_$AppDatabase, $Feature2TableTable, Feature2TableData>
    ),
    Feature2TableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NewsTableTableTableManager get newsTable =>
      $$NewsTableTableTableManager(_db, _db.newsTable);
  $$Feature2TableTableTableManager get feature2Table =>
      $$Feature2TableTableTableManager(_db, _db.feature2Table);
}
