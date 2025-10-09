import 'package:flutter/material.dart';

class Page2Screen extends StatelessWidget {
  const Page2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Page 2',
        style: TextStyle(
          fontSize: 20,
          color: Colors.blue,
        ),),
      ),
    );
  }
}
