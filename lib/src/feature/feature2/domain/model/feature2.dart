import 'package:drift/drift.dart';

// This is the table that we use to do things
class Feature2Table extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nickname => text().nullable()();
  TextColumn get gProfile => text().nullable()();
  TextColumn get link => text().nullable()();

  @override
  Set<Column> get primaryKey => {nickname};
}

class Feature2 {
  final String nickname;
  final String gProfile;
  final String link;

  Feature2({
    required this.nickname,
    required this.gProfile,
    required this.link,
  });

  // Converting JSON to Feature2
  factory Feature2.fromJson(Map<String, dynamic> json) {
    return Feature2(
        nickname: json['nickname'].toString(),
        gProfile: json['github_profile'].toString(),
        link: json['link'].toString());
  }

  // Lazy enough to make it a function
  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'github_profile': gProfile,
      'link': link,
    };
  }
}
