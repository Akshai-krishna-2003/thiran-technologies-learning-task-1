import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practiceapp/src/feature/feature5/domain/model/feature5.dart';
import 'package:practiceapp/src/feature/feature5/presentation/providers/feature5_providers.dart';

class Page5Screen extends ConsumerStatefulWidget {
  const Page5Screen({super.key});

  @override
  ConsumerState<Page5Screen> createState() => _Page5ScreenState();
}

class _Page5ScreenState extends ConsumerState<Page5Screen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(syncFeat5Provider.future);
      await ref.read(paginatedFeat5Provider.notifier).refresh();
    });

    // Trigger load more when reaching end of list
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        ref.read(paginatedFeat5Provider.notifier).loadMore();
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
    final syncState = ref.watch(syncFeat5Provider);
    final asyncFeat5 = ref.watch(paginatedFeat5Provider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Country Flags",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              await ref.refresh(syncFeat5Provider.future);
              ref.read(paginatedFeat5Provider.notifier).refresh();
            },
          ),
        ],
      ),
      body: syncState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text("Sync error: $err")),
        data: (_) {
          return asyncFeat5.when(
            data: (flags) {
              if (flags.isEmpty) {
                return const Center(child: Text("No flags found"));
              }

              return ListView.builder(
                controller: _scrollController,
                itemCount: flags.length,
                itemBuilder: (context, index) {
                  final Feature5 flag = flags[index];
                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Flag Image
                          if (flag.downloadedPath.isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                File(flag.downloadedPath),
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.flag_outlined,
                                        size: 100, color: Colors.grey),
                              ),
                            )
                          else
                            const Icon(Icons.flag_outlined,
                                size: 100, color: Colors.grey),

                          const SizedBox(height: 10),

                          // Flag Description
                          Text(
                            flag.description.isNotEmpty
                                ? flag.description
                                : 'No description available',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            loading: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            error: (err, _) => Center(child: Text("DB error: $err")),
          );
        },
      ),
    );
  }
}
