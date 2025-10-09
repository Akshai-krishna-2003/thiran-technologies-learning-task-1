import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShellScreen extends StatelessWidget {
  final Widget child;
  const ShellScreen({super.key, required this.child});

  static const List<String> _tabs = [
    '/home',
    '/page2',
    '/page3',
    '/page4',
    '/page5',
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return _tabs
        .indexWhere((tab) => location.startsWith(tab))
        .clamp(0, _tabs.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _currentIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => context.go(_tabs[index]),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: 'page2'),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: 'page3'),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: 'page4'),
          BottomNavigationBarItem(
              icon: Icon(Icons.article_outlined), label: 'page5'),
        ],
      ),
    );
  }
}
