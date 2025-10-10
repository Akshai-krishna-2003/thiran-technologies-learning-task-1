import 'package:http/http.dart' as http;
import 'package:practiceapp/src/feature/feature2/data/services/feature2_service.dart';
import 'package:practiceapp/src/feature/news/domain/model/news.dart';
import 'dart:convert';
import 'dart:isolate';

class NewsService {
  final String apiUri =
      "https://newsapi.org/v2/everything?q=apple&from=2025-10-01&to=2025-10-08&sortBy=popularity&apiKey=564ac3ddcebb40cba711379825a852cd";

  Future<List<News>> fetchArticles() async {
    try {
      final uri = Uri.parse(apiUri);
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        // Create a receive port to listen for messages
        final receivePort = ReceivePort();

        // Spawn an isolate and send both the SendPort + response.body
        final abcIsolate = await Isolate.spawn(
            _parseNewsData, [receivePort.sendPort, res.body]);

        // Wait for the isolate to send the parsed list
        final List<News> articles = await receivePort.first as List<News>;

        Feature2API().getFromApi();

        abcIsolate.kill();

        print("Total articles parsed: ${articles.length}");
        return articles;
      } else {
        throw Exception('Failed to fetch data: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  // Function that runs inside the isolate
  static void _parseNewsData(List<dynamic> args) {
    final SendPort sendPort = args[0];
    final String responseBody = args[1];
    print("News response: $responseBody");

    try {
      final Map<String, dynamic> data = jsonDecode(responseBody);
      final List<dynamic> articlesJson = data['articles'] ?? [];

      // Convert JSON list → List<News>
      final List<News> newsList =
          articlesJson.map((item) => News.fromJson(item)).toList();

      // Send the result back to main isolate
      sendPort.send(newsList);
    } catch (e) {
      // If parsing fails, send empty list or error
      sendPort.send([]);
    }
  }
}
