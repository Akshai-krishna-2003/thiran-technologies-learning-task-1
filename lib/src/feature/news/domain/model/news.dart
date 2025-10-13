import 'package:drift/drift.dart';

/// Drift table used by DAO
class NewsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get author => text().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
}

/// Plain Dart model for JSON mapping
class News {
  final String author;
  final String title;
  final String description;

  News({
    required this.author,
    required this.title,
    required this.description,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        author: json['author']?.toString() ?? '',
        title: json['title']?.toString() ?? '',
        description: json['description']?.toString() ?? '',
      );

  Map<String, dynamic> toJson() => {
        'author': author,
        'title': title,
        'description': description,
      };
}
