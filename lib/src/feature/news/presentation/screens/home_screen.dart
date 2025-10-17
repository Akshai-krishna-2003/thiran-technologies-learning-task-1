import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practiceapp/src/feature/news/domain/model/news.dart';
import 'package:practiceapp/src/feature/news/presentation/providers/news_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

enum MenuItems {
  none,
  titleAsc,
  titleDesc,
  descriptionAsc,
  descriptionDesc,
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Run sync first, then refresh articles after it completes -- LETS TRY
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(syncArticlesProvider.future);
      await ref.read(paginatedArticlesProvider.notifier).refresh();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        ref.read(paginatedArticlesProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final syncState = ref.watch(syncArticlesProvider);
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
              await ref.refresh(syncArticlesProvider.future);
              ref.read(paginatedArticlesProvider.notifier).refresh();
            },
          ),
          PopupMenuButton<SortOption>(
            onSelected: (SortOption option) {
              ref.read(selectedSortProvider.notifier).state = option;

              ref
                  .read(paginatedArticlesProvider.notifier)
                  .refresh(newSort: option);
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                  value: SortOption.titleAsc, child: Text('Title asc')),
              PopupMenuItem(
                  value: SortOption.titleDesc, child: Text('Title desc')),
              PopupMenuItem(
                  value: SortOption.descriptionAsc,
                  child: Text('Description asc')),
              PopupMenuItem(
                  value: SortOption.descriptionDesc,
                  child: Text('Description desc')),
            ],
          )
        ],
      ),
      body: syncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Sync error: $err")),
        data: (_) {
          return asyncArticles.when(
            data: (articles) {
              if (articles.isEmpty) {
                return const Center(child: Text("No articles found"));
              }
              print("Length is: ${articles.length}");
              return ListView.builder(
                controller: _scrollController,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final News article = articles[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            article.description.isNotEmpty
                                ? article.description
                                : 'No Description',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
