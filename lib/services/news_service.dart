import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:practiceapp/model/news.dart';
import 'dart:convert';

class NewsService {
  final String? apiKey = dotenv.env['API_KEY'];
  final String apiUri = "https://newsdata.io/api/1/latest";
  final String location = "China";

  Future<List<News>> fetchArticles() async {
    try {
      final uri = Uri.parse("$apiUri?apikey=${apiKey!}&q=$location");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List articles = data['results'] ?? [];

        return articles.map<News>((item) {
          return News.fromJson(item);
        }).toList();
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
