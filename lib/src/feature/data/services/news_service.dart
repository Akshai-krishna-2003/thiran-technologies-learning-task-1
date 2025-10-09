// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:practiceapp/src/feature/domain/model/news.dart';
import 'dart:convert';

class NewsService {
  // final String? apiKey = dotenv.env['API_KEY'];
  final String apiUri =
      "https://newsapi.org/v2/everything?q=apple&from=2025-10-01&to=2025-10-08&sortBy=popularity&apiKey=564ac3ddcebb40cba711379825a852cd";
  // final String location = "pizza";

  Future<List<News>> fetchArticles() async {
    try {
      final uri = Uri.parse(apiUri);
      // print("Fetching from: $uri");

      final res = await http.get(uri);
      // print("Response status: ${res.statusCode}");

      if (res.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(res.body);
        final List<dynamic> articles = data['articles']; 
        print("Total articles fetched: ${articles.length}");

        return articles.map<News>((item) => News.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch data: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
