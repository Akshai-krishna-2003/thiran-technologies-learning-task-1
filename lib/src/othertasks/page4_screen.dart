import 'package:flutter/material.dart';

class Page4Screen extends StatelessWidget {
  const Page4Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Page 4',
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
