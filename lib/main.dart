import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practiceapp/screens/home_screen.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(ProviderScope(
      child:
          const MyApp())); // I use ProviderScope here so I can access the riverpod anywhere in my app lol
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
