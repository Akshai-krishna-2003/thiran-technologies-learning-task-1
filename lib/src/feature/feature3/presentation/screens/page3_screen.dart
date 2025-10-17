import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practiceapp/src/feature/feature3/domain/model/feature3.dart';
import 'package:practiceapp/src/feature/feature3/presentation/providers/feature3_providers.dart';

class Page3Screen extends ConsumerStatefulWidget {
  const Page3Screen({super.key});

  @override
  ConsumerState<Page3Screen> createState() => _Page3ScreenState();

}

class _Page3ScreenState extends ConsumerState<Page3Screen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(syncFeat3Provider.future);
      await ref.read(paginatedFeat3Provider.notifier).refresh();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        ref.read(paginatedFeat3Provider.notifier).loadMore();
        print("");
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
    final syncState = ref.watch(syncFeat3Provider);
    final asyncFeat3 = ref.watch(paginatedFeat3Provider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Books name",
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
              await ref.refresh(syncFeat3Provider.future);
              ref.read(paginatedFeat3Provider.notifier).refresh();
            },
          ),
        ],
      ),
      body: syncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Sync error: $err")),
        data: (_) {
          return asyncFeat3.when(
            data: (articles) {
              if (articles.isEmpty) {
                return const Center(child: Text("No data found"));
              }
              print("Length is: ${articles.length}");
              return ListView.builder(
                controller: _scrollController,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final Feature3 article = articles[index];
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
                            article.id.toString(),
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            article.title.isNotEmpty
                                ? article.title
                                : 'No title',
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
