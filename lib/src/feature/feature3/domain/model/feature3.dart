import 'package:drift/drift.dart';

class Feature3 {
  final int id;
  final String title;
  final String description;

  Feature3({required this.id, required this.title, required this.description});

  // Converting JSON to Feature3
  factory Feature3.fromJson(Map<String, dynamic> json) {
    return Feature3(
        id: int.parse(json['id']),
        title: json['title'].toString(),
        description: json['description'].toString());
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'description': description};
  }
}

class Feature3Table extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get description => text()();

  @override
  Set<Column> get primaryKey => {id};
}
