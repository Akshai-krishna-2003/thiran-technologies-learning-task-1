import 'package:drift/drift.dart';

class Feature4 {
  final String id;
  final String name;
  final String webUrl;

  Feature4(
      {required this.id,
      required this.name,
      required this.webUrl,
      String? description});

  // Converting JSON to Feature4
  factory Feature4.fromJson(Map<String, dynamic> json) {
    return Feature4(
      id: json['id'].toString(),
      name: json['name'].toString(),
      webUrl: json['website_url'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'webUrl': webUrl};
  }
}

class Feature4Table extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get webUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
