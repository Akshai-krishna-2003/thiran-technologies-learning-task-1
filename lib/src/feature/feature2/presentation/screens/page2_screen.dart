import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practiceapp/src/feature/feature2/domain/model/feature2.dart';
import 'package:practiceapp/src/feature/feature2/presentation/providers/feature2_providers.dart';

class Page2Screen extends ConsumerStatefulWidget {
  const Page2Screen({super.key});

  @override
  ConsumerState<Page2Screen> createState() => _Page2ScreenState();
}

class _Page2ScreenState extends ConsumerState<Page2Screen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(syncFeat2Provider.future);
      await ref.read(paginatedFeat2Provider.notifier).refresh();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        ref.read(paginatedFeat2Provider.notifier).loadMore();
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
    final syncState = ref.watch(syncFeat2Provider);
    final asyncFeat2 = ref.watch(paginatedFeat2Provider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Developer Team",
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
              await ref.refresh(syncFeat2Provider.future);
              ref.read(paginatedFeat2Provider.notifier).refresh();
            },
          ),
        ],
      ),
      body: syncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Sync error: $err")),
        data: (_) {
          return asyncFeat2.when(
            data: (articles) {
              if (articles.isEmpty) {
                return const Center(child: Text("No data found"));
              }
              print("Length is: ${articles.length}");
              return ListView.builder(
                controller: _scrollController,
                itemCount: articles.length,
                itemBuilder: (context, index) {
                  final Feature2 article = articles[index];
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
                            article.nickname.isNotEmpty
                                ? article.nickname
                                : 'No Nick Name',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            article.gProfile.isNotEmpty
                                ? article.gProfile
                                : 'No Github Profile',
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
