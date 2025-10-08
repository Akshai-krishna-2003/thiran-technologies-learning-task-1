// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:practiceapp/src/feature/domain/model/news.dart';
import 'dart:convert';

class NewsService {
  // final String? apiKey = dotenv.env['API_KEY'];
  final String apiUri =
      "https://script.google.com/macros/s/AKfycbyYadozyP0xcKCwEJ8Yc8B1-odZTpNSiGMiCkeaK1l627jkrzsddnVAmOIs2x8nPIW7/exec";
  // final String location = "pizza";

  Future<List<News>> fetchArticles() async {
    try {
      final uri = Uri.parse(apiUri);
      print("Fetching from: $uri");
      final response = await http.get(uri);
      print("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        return data.map<News>((item) {
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
