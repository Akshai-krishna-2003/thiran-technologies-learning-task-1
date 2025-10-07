import 'package:flutter/material.dart';
import 'package:practiceapp/services/db_service.dart';
import 'package:practiceapp/services/news_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DbService _dbService = DbService();
  final NewsService _newsService = NewsService();

  List<Map<String, dynamic>> _articles = [];
  bool _isLoading = false;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    _initializeNews();
  }

  Future<void> _initializeNews() async {
    setState(() => _isLoading = true);

    final fetchedArticles = await _newsService.fetchArticles();

    await _dbService.insertArticles(fetchedArticles);

    final allArticles = await _dbService.getAllArticles();

    setState(() {
      _articles = allArticles;
      _isInit = true;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInit || _isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Latest News', style: 
      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.blue, ),)),
      body: ListView.builder(
        itemCount: _articles.length,
        itemBuilder: (context, index) {
          final article = _articles[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article['title'] ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article['description'] ?? 'No Description',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
