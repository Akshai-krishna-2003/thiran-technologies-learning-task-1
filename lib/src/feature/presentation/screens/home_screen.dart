import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practiceapp/src/feature/domain/model/news.dart';
import 'package:practiceapp/src/feature/presentation/providers/providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch sync state (API -> DB)
    final syncState = ref.watch(syncArticlesProvider);

    // Watch paginated state (DB -> UI)
    final asyncArticles = ref.watch(paginatedArticlesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Latest News',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              // Refresh DB from API
              await ref.refresh(syncArticlesProvider.future);
              // Reset pagination after DB update
              ref.read(paginatedArticlesProvider.notifier).refresh();
            },
          ),
        ],
      ),

      // Body
      body: syncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Sync error: $err")),
        data: (_) {
          return asyncArticles.when(
            data: (articles) {
              if (articles.isEmpty) {
                return const Center(child: Text("No articles found"));
              }

              return NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    // reached bottom -> load next page
                    ref.read(paginatedArticlesProvider.notifier).loadMore();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final News article = articles[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title.isNotEmpty
                                  ? article.title
                                  : 'No Title',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              article.thumbNail.isNotEmpty
                                  ? article.thumbNail
                                  : 'No Description',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Center(child: Text("DB error: $err")),
          );
        },
      ),
    );
  }
}
