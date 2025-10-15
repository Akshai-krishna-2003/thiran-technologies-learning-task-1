import 'package:drift/drift.dart';

class Feature5 {
  final String id;
  final String pngUrl;
  final String svgUrl;
  final String description;

  Feature5({
    required this.id,
    required this.pngUrl,
    required this.svgUrl,
    required this.description,
  });

  // Convert JSON → Model
  factory Feature5.fromJson(Map<String, dynamic> json) {
    final flags = json['flags'] ?? {};
    return Feature5(
      id: flags['svg']?.toString() ?? '', // unique enough
      pngUrl: flags['png']?.toString() ?? '',
      svgUrl: flags['svg']?.toString() ?? '',
      description: flags['alt']?.toString() ?? 'No description available',
    );
  }

  // Convert Model → JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'pngUrl': pngUrl,
        'svgUrl': svgUrl,
        'description': description,
      };
}

class Feature5Table extends Table {
  TextColumn get id => text()(); 
  TextColumn get pngUrl => text().nullable()();
  TextColumn get svgUrl => text().nullable()();
  TextColumn get description => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
