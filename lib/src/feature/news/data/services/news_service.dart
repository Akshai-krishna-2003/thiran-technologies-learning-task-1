import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:practiceapp/src/feature/news/domain/model/news.dart';

class NewsService {
  final String apiUri =
      "https://newsapi.org/v2/everything?q=apple&from=2025-10-01&to=2025-10-08&sortBy=popularity&apiKey=564ac3ddcebb40cba711379825a852cd";

  /// Fetch news from API and return parsed list (no DB operations)
  Future<List<News>> fetchArticles() async {
    try {
      final uri = Uri.parse(apiUri);
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final receivePort = ReceivePort();

        // Offload heavy JSON parsing to a background isolate
        final abcIsolate = await Isolate.spawn(
            _parseNewsData, [receivePort.sendPort, res.body]);
        final List<News> articles = await receivePort.first as List<News>;
        abcIsolate.kill();

        return articles;
      } else {
        throw Exception('Failed to fetch data: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  /// Runs in background isolate
  static void _parseNewsData(List<dynamic> args) {
    final SendPort sendPort = args[0];
    final String responseBody = args[1];

    try {
      final Map<String, dynamic> data = jsonDecode(responseBody);
      final List<dynamic> articlesJson = data['articles'] ?? [];

      final List<News> newsList =
          articlesJson.map((item) => News.fromJson(item)).toList();

      sendPort.send(newsList);
    } catch (_) {
      sendPort.send(<News>[]);
    }
  }
}
