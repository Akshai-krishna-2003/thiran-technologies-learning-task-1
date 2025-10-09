class News {
  final String author;
  final String title;
  final String description;

  News({
    required this.author,
    required this.title,
    required this.description,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
    };
  }
}
