class News {
  final String title;
  final String url;
  final String thumbNail;

  News({
    required this.title,
    required this.url,
    required this.thumbNail,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['title']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
      thumbNail: json['thumbNail']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'thumbNail': thumbNail,
    };
  }
}
