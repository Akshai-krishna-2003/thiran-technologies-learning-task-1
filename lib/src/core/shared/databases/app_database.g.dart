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

class $Feature3TableTable extends Feature3Table
    with TableInfo<$Feature3TableTable, Feature3TableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Feature3TableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feature3_table';
  @override
  VerificationContext validateIntegrity(Insertable<Feature3TableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Feature3TableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Feature3TableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
    );
  }

  @override
  $Feature3TableTable createAlias(String alias) {
    return $Feature3TableTable(attachedDatabase, alias);
  }
}

class Feature3TableData extends DataClass
    implements Insertable<Feature3TableData> {
  final int id;
  final String title;
  final String description;
  const Feature3TableData(
      {required this.id, required this.title, required this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    return map;
  }

  Feature3TableCompanion toCompanion(bool nullToAbsent) {
    return Feature3TableCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
    );
  }

  factory Feature3TableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Feature3TableData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
    };
  }

  Feature3TableData copyWith({int? id, String? title, String? description}) =>
      Feature3TableData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
      );
  Feature3TableData copyWithCompanion(Feature3TableCompanion data) {
    return Feature3TableData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Feature3TableData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Feature3TableData &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description);
}

class Feature3TableCompanion extends UpdateCompanion<Feature3TableData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> description;
  const Feature3TableCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
  });
  Feature3TableCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String description,
  })  : title = Value(title),
        description = Value(description);
  static Insertable<Feature3TableData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
    });
  }

  Feature3TableCompanion copyWith(
      {Value<int>? id, Value<String>? title, Value<String>? description}) {
    return Feature3TableCompanion(
      id: id ?? this.id,
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
    return (StringBuffer('Feature3TableCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $Feature4TableTable extends Feature4Table
    with TableInfo<$Feature4TableTable, Feature4TableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Feature4TableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _webUrlMeta = const VerificationMeta('webUrl');
  @override
  late final GeneratedColumn<String> webUrl = GeneratedColumn<String>(
      'web_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, webUrl];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feature4_table';
  @override
  VerificationContext validateIntegrity(Insertable<Feature4TableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('web_url')) {
      context.handle(_webUrlMeta,
          webUrl.isAcceptableOrUnknown(data['web_url']!, _webUrlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Feature4TableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Feature4TableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      webUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}web_url']),
    );
  }

  @override
  $Feature4TableTable createAlias(String alias) {
    return $Feature4TableTable(attachedDatabase, alias);
  }
}

class Feature4TableData extends DataClass
    implements Insertable<Feature4TableData> {
  final String id;
  final String? name;
  final String? webUrl;
  const Feature4TableData({required this.id, this.name, this.webUrl});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || webUrl != null) {
      map['web_url'] = Variable<String>(webUrl);
    }
    return map;
  }

  Feature4TableCompanion toCompanion(bool nullToAbsent) {
    return Feature4TableCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      webUrl:
          webUrl == null && nullToAbsent ? const Value.absent() : Value(webUrl),
    );
  }

  factory Feature4TableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Feature4TableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      webUrl: serializer.fromJson<String?>(json['webUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'webUrl': serializer.toJson<String?>(webUrl),
    };
  }

  Feature4TableData copyWith(
          {String? id,
          Value<String?> name = const Value.absent(),
          Value<String?> webUrl = const Value.absent()}) =>
      Feature4TableData(
        id: id ?? this.id,
        name: name.present ? name.value : this.name,
        webUrl: webUrl.present ? webUrl.value : this.webUrl,
      );
  Feature4TableData copyWithCompanion(Feature4TableCompanion data) {
    return Feature4TableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      webUrl: data.webUrl.present ? data.webUrl.value : this.webUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Feature4TableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('webUrl: $webUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, webUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Feature4TableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.webUrl == this.webUrl);
}

class Feature4TableCompanion extends UpdateCompanion<Feature4TableData> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> webUrl;
  final Value<int> rowid;
  const Feature4TableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.webUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  Feature4TableCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.webUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Feature4TableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? webUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (webUrl != null) 'web_url': webUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  Feature4TableCompanion copyWith(
      {Value<String>? id,
      Value<String?>? name,
      Value<String?>? webUrl,
      Value<int>? rowid}) {
    return Feature4TableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      webUrl: webUrl ?? this.webUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (webUrl.present) {
      map['web_url'] = Variable<String>(webUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Feature4TableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('webUrl: $webUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $Feature5TableTable extends Feature5Table
    with TableInfo<$Feature5TableTable, Feature5TableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Feature5TableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pngUrlMeta = const VerificationMeta('pngUrl');
  @override
  late final GeneratedColumn<String> pngUrl = GeneratedColumn<String>(
      'png_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _svgUrlMeta = const VerificationMeta('svgUrl');
  @override
  late final GeneratedColumn<String> svgUrl = GeneratedColumn<String>(
      'svg_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, pngUrl, svgUrl, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'feature5_table';
  @override
  VerificationContext validateIntegrity(Insertable<Feature5TableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('png_url')) {
      context.handle(_pngUrlMeta,
          pngUrl.isAcceptableOrUnknown(data['png_url']!, _pngUrlMeta));
    }
    if (data.containsKey('svg_url')) {
      context.handle(_svgUrlMeta,
          svgUrl.isAcceptableOrUnknown(data['svg_url']!, _svgUrlMeta));
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
  Feature5TableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Feature5TableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      pngUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}png_url']),
      svgUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}svg_url']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  $Feature5TableTable createAlias(String alias) {
    return $Feature5TableTable(attachedDatabase, alias);
  }
}

class Feature5TableData extends DataClass
    implements Insertable<Feature5TableData> {
  final String id;
  final String? pngUrl;
  final String? svgUrl;
  final String? description;
  const Feature5TableData(
      {required this.id, this.pngUrl, this.svgUrl, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || pngUrl != null) {
      map['png_url'] = Variable<String>(pngUrl);
    }
    if (!nullToAbsent || svgUrl != null) {
      map['svg_url'] = Variable<String>(svgUrl);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  Feature5TableCompanion toCompanion(bool nullToAbsent) {
    return Feature5TableCompanion(
      id: Value(id),
      pngUrl:
          pngUrl == null && nullToAbsent ? const Value.absent() : Value(pngUrl),
      svgUrl:
          svgUrl == null && nullToAbsent ? const Value.absent() : Value(svgUrl),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Feature5TableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Feature5TableData(
      id: serializer.fromJson<String>(json['id']),
      pngUrl: serializer.fromJson<String?>(json['pngUrl']),
      svgUrl: serializer.fromJson<String?>(json['svgUrl']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pngUrl': serializer.toJson<String?>(pngUrl),
      'svgUrl': serializer.toJson<String?>(svgUrl),
      'description': serializer.toJson<String?>(description),
    };
  }

  Feature5TableData copyWith(
          {String? id,
          Value<String?> pngUrl = const Value.absent(),
          Value<String?> svgUrl = const Value.absent(),
          Value<String?> description = const Value.absent()}) =>
      Feature5TableData(
        id: id ?? this.id,
        pngUrl: pngUrl.present ? pngUrl.value : this.pngUrl,
        svgUrl: svgUrl.present ? svgUrl.value : this.svgUrl,
        description: description.present ? description.value : this.description,
      );
  Feature5TableData copyWithCompanion(Feature5TableCompanion data) {
    return Feature5TableData(
      id: data.id.present ? data.id.value : this.id,
      pngUrl: data.pngUrl.present ? data.pngUrl.value : this.pngUrl,
      svgUrl: data.svgUrl.present ? data.svgUrl.value : this.svgUrl,
      description:
          data.description.present ? data.description.value : this.description,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Feature5TableData(')
          ..write('id: $id, ')
          ..write('pngUrl: $pngUrl, ')
          ..write('svgUrl: $svgUrl, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, pngUrl, svgUrl, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Feature5TableData &&
          other.id == this.id &&
          other.pngUrl == this.pngUrl &&
          other.svgUrl == this.svgUrl &&
          other.description == this.description);
}

class Feature5TableCompanion extends UpdateCompanion<Feature5TableData> {
  final Value<String> id;
  final Value<String?> pngUrl;
  final Value<String?> svgUrl;
  final Value<String?> description;
  final Value<int> rowid;
  const Feature5TableCompanion({
    this.id = const Value.absent(),
    this.pngUrl = const Value.absent(),
    this.svgUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  Feature5TableCompanion.insert({
    required String id,
    this.pngUrl = const Value.absent(),
    this.svgUrl = const Value.absent(),
    this.description = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Feature5TableData> custom({
    Expression<String>? id,
    Expression<String>? pngUrl,
    Expression<String>? svgUrl,
    Expression<String>? description,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pngUrl != null) 'png_url': pngUrl,
      if (svgUrl != null) 'svg_url': svgUrl,
      if (description != null) 'description': description,
      if (rowid != null) 'rowid': rowid,
    });
  }

  Feature5TableCompanion copyWith(
      {Value<String>? id,
      Value<String?>? pngUrl,
      Value<String?>? svgUrl,
      Value<String?>? description,
      Value<int>? rowid}) {
    return Feature5TableCompanion(
      id: id ?? this.id,
      pngUrl: pngUrl ?? this.pngUrl,
      svgUrl: svgUrl ?? this.svgUrl,
      description: description ?? this.description,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pngUrl.present) {
      map['png_url'] = Variable<String>(pngUrl.value);
    }
    if (svgUrl.present) {
      map['svg_url'] = Variable<String>(svgUrl.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Feature5TableCompanion(')
          ..write('id: $id, ')
          ..write('pngUrl: $pngUrl, ')
          ..write('svgUrl: $svgUrl, ')
          ..write('description: $description, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NewsTableTable newsTable = $NewsTableTable(this);
  late final $Feature2TableTable feature2Table = $Feature2TableTable(this);
  late final $Feature3TableTable feature3Table = $Feature3TableTable(this);
  late final $Feature4TableTable feature4Table = $Feature4TableTable(this);
  late final $Feature5TableTable feature5Table = $Feature5TableTable(this);
  late final NewsDao newsDao = NewsDao(this as AppDatabase);
  late final Feature2Dao feature2Dao = Feature2Dao(this as AppDatabase);
  late final Feature3Dao feature3Dao = Feature3Dao(this as AppDatabase);
  late final Feature4Dao feature4Dao = Feature4Dao(this as AppDatabase);
  late final Feature5Dao feature5Dao = Feature5Dao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [newsTable, feature2Table, feature3Table, feature4Table, feature5Table];
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
typedef $$Feature3TableTableCreateCompanionBuilder = Feature3TableCompanion
    Function({
  Value<int> id,
  required String title,
  required String description,
});
typedef $$Feature3TableTableUpdateCompanionBuilder = Feature3TableCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> description,
});

class $$Feature3TableTableFilterComposer
    extends Composer<_$AppDatabase, $Feature3TableTable> {
  $$Feature3TableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
}

class $$Feature3TableTableOrderingComposer
    extends Composer<_$AppDatabase, $Feature3TableTable> {
  $$Feature3TableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $$Feature3TableTableAnnotationComposer
    extends Composer<_$AppDatabase, $Feature3TableTable> {
  $$Feature3TableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
}

class $$Feature3TableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $Feature3TableTable,
    Feature3TableData,
    $$Feature3TableTableFilterComposer,
    $$Feature3TableTableOrderingComposer,
    $$Feature3TableTableAnnotationComposer,
    $$Feature3TableTableCreateCompanionBuilder,
    $$Feature3TableTableUpdateCompanionBuilder,
    (
      Feature3TableData,
      BaseReferences<_$AppDatabase, $Feature3TableTable, Feature3TableData>
    ),
    Feature3TableData,
    PrefetchHooks Function()> {
  $$Feature3TableTableTableManager(_$AppDatabase db, $Feature3TableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$Feature3TableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$Feature3TableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$Feature3TableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> description = const Value.absent(),
          }) =>
              Feature3TableCompanion(
            id: id,
            title: title,
            description: description,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String description,
          }) =>
              Feature3TableCompanion.insert(
            id: id,
            title: title,
            description: description,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$Feature3TableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $Feature3TableTable,
    Feature3TableData,
    $$Feature3TableTableFilterComposer,
    $$Feature3TableTableOrderingComposer,
    $$Feature3TableTableAnnotationComposer,
    $$Feature3TableTableCreateCompanionBuilder,
    $$Feature3TableTableUpdateCompanionBuilder,
    (
      Feature3TableData,
      BaseReferences<_$AppDatabase, $Feature3TableTable, Feature3TableData>
    ),
    Feature3TableData,
    PrefetchHooks Function()>;
typedef $$Feature4TableTableCreateCompanionBuilder = Feature4TableCompanion
    Function({
  required String id,
  Value<String?> name,
  Value<String?> webUrl,
  Value<int> rowid,
});
typedef $$Feature4TableTableUpdateCompanionBuilder = Feature4TableCompanion
    Function({
  Value<String> id,
  Value<String?> name,
  Value<String?> webUrl,
  Value<int> rowid,
});

class $$Feature4TableTableFilterComposer
    extends Composer<_$AppDatabase, $Feature4TableTable> {
  $$Feature4TableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get webUrl => $composableBuilder(
      column: $table.webUrl, builder: (column) => ColumnFilters(column));
}

class $$Feature4TableTableOrderingComposer
    extends Composer<_$AppDatabase, $Feature4TableTable> {
  $$Feature4TableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get webUrl => $composableBuilder(
      column: $table.webUrl, builder: (column) => ColumnOrderings(column));
}

class $$Feature4TableTableAnnotationComposer
    extends Composer<_$AppDatabase, $Feature4TableTable> {
  $$Feature4TableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get webUrl =>
      $composableBuilder(column: $table.webUrl, builder: (column) => column);
}

class $$Feature4TableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $Feature4TableTable,
    Feature4TableData,
    $$Feature4TableTableFilterComposer,
    $$Feature4TableTableOrderingComposer,
    $$Feature4TableTableAnnotationComposer,
    $$Feature4TableTableCreateCompanionBuilder,
    $$Feature4TableTableUpdateCompanionBuilder,
    (
      Feature4TableData,
      BaseReferences<_$AppDatabase, $Feature4TableTable, Feature4TableData>
    ),
    Feature4TableData,
    PrefetchHooks Function()> {
  $$Feature4TableTableTableManager(_$AppDatabase db, $Feature4TableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$Feature4TableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$Feature4TableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$Feature4TableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> webUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              Feature4TableCompanion(
            id: id,
            name: name,
            webUrl: webUrl,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> name = const Value.absent(),
            Value<String?> webUrl = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              Feature4TableCompanion.insert(
            id: id,
            name: name,
            webUrl: webUrl,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$Feature4TableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $Feature4TableTable,
    Feature4TableData,
    $$Feature4TableTableFilterComposer,
    $$Feature4TableTableOrderingComposer,
    $$Feature4TableTableAnnotationComposer,
    $$Feature4TableTableCreateCompanionBuilder,
    $$Feature4TableTableUpdateCompanionBuilder,
    (
      Feature4TableData,
      BaseReferences<_$AppDatabase, $Feature4TableTable, Feature4TableData>
    ),
    Feature4TableData,
    PrefetchHooks Function()>;
typedef $$Feature5TableTableCreateCompanionBuilder = Feature5TableCompanion
    Function({
  required String id,
  Value<String?> pngUrl,
  Value<String?> svgUrl,
  Value<String?> description,
  Value<int> rowid,
});
typedef $$Feature5TableTableUpdateCompanionBuilder = Feature5TableCompanion
    Function({
  Value<String> id,
  Value<String?> pngUrl,
  Value<String?> svgUrl,
  Value<String?> description,
  Value<int> rowid,
});

class $$Feature5TableTableFilterComposer
    extends Composer<_$AppDatabase, $Feature5TableTable> {
  $$Feature5TableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pngUrl => $composableBuilder(
      column: $table.pngUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get svgUrl => $composableBuilder(
      column: $table.svgUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));
}

class $$Feature5TableTableOrderingComposer
    extends Composer<_$AppDatabase, $Feature5TableTable> {
  $$Feature5TableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pngUrl => $composableBuilder(
      column: $table.pngUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get svgUrl => $composableBuilder(
      column: $table.svgUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));
}

class $$Feature5TableTableAnnotationComposer
    extends Composer<_$AppDatabase, $Feature5TableTable> {
  $$Feature5TableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pngUrl =>
      $composableBuilder(column: $table.pngUrl, builder: (column) => column);

  GeneratedColumn<String> get svgUrl =>
      $composableBuilder(column: $table.svgUrl, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);
}

class $$Feature5TableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $Feature5TableTable,
    Feature5TableData,
    $$Feature5TableTableFilterComposer,
    $$Feature5TableTableOrderingComposer,
    $$Feature5TableTableAnnotationComposer,
    $$Feature5TableTableCreateCompanionBuilder,
    $$Feature5TableTableUpdateCompanionBuilder,
    (
      Feature5TableData,
      BaseReferences<_$AppDatabase, $Feature5TableTable, Feature5TableData>
    ),
    Feature5TableData,
    PrefetchHooks Function()> {
  $$Feature5TableTableTableManager(_$AppDatabase db, $Feature5TableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$Feature5TableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$Feature5TableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$Feature5TableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> pngUrl = const Value.absent(),
            Value<String?> svgUrl = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              Feature5TableCompanion(
            id: id,
            pngUrl: pngUrl,
            svgUrl: svgUrl,
            description: description,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> pngUrl = const Value.absent(),
            Value<String?> svgUrl = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              Feature5TableCompanion.insert(
            id: id,
            pngUrl: pngUrl,
            svgUrl: svgUrl,
            description: description,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$Feature5TableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $Feature5TableTable,
    Feature5TableData,
    $$Feature5TableTableFilterComposer,
    $$Feature5TableTableOrderingComposer,
    $$Feature5TableTableAnnotationComposer,
    $$Feature5TableTableCreateCompanionBuilder,
    $$Feature5TableTableUpdateCompanionBuilder,
    (
      Feature5TableData,
      BaseReferences<_$AppDatabase, $Feature5TableTable, Feature5TableData>
    ),
    Feature5TableData,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NewsTableTableTableManager get newsTable =>
      $$NewsTableTableTableManager(_db, _db.newsTable);
  $$Feature2TableTableTableManager get feature2Table =>
      $$Feature2TableTableTableManager(_db, _db.feature2Table);
  $$Feature3TableTableTableManager get feature3Table =>
      $$Feature3TableTableTableManager(_db, _db.feature3Table);
  $$Feature4TableTableTableManager get feature4Table =>
      $$Feature4TableTableTableManager(_db, _db.feature4Table);
  $$Feature5TableTableTableManager get feature5Table =>
      $$Feature5TableTableTableManager(_db, _db.feature5Table);
}
