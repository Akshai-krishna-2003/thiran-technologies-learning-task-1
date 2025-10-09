import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:practiceapp/src/app/shell_screen.dart';
import 'package:practiceapp/src/feature/news/presentation/screens/home_screen.dart';
import 'package:practiceapp/src/othertasks/page4_screen.dart';
import 'package:practiceapp/src/othertasks/page3_screen.dart';
import 'package:practiceapp/src/feature/feature2/presentation/screens/page2_screen.dart';
import 'package:practiceapp/src/othertasks/page5_screen.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    ShellRoute(
      builder: (context, state, child) => ShellScreen(child: child),
      routes: [
        GoRoute(
          path: '/home',
          builder: (_, __) => const HomeScreen(),
        ),
        GoRoute(
          path: '/page2',
          builder: (_, __) => const Page2Screen(),
        ),
        GoRoute(
          path: '/page3',
          builder: (_, __) => const Page3Screen(),
        ),
        GoRoute(
          path: '/page4',
          builder: (_, __) => const Page4Screen(),
        ),
        GoRoute(
          path: '/page5',
          builder: (_, __) => const Page5Screen(),
        ),
      ],
    ),
  ],
);
