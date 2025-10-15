import 'package:flutter/material.dart';
import 'package:practiceapp/src/feature/feature3/data/services/feature3_api.dart';

class Page3Screen extends StatelessWidget {
  const Page3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    Feature3Api().getDataForFeat3();
    return const Scaffold(
      body: Center(
        child: Text(
          'Page 3',
          style: TextStyle(
            fontSize: 20,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
