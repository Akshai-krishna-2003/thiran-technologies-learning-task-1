class News {
  final String articleId;
  final String title;
  final String description;

  News({
    required this.articleId,
    required this.title,
    required this.description,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      articleId: json['article_id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': articleId,
      'title': title,
      'description': description,
    };
  }
}
