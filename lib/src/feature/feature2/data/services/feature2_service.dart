import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class Feature2API {
  final apiUri = "https://24pullrequests.com/users.json?page=100";

  Future<void> getFromApi() async {
    print("abcd!");
    try {
      final uri = Uri.parse(apiUri);
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final body = jsonDecode(res.body);
        print("Length of response body is ${body.length}");

        if (res.statusCode == 200) {
          final recievePort = ReceivePort();
        }
      }
    } catch (e) {
      throw Exception("Error in Feature 2 API: ${e.toString()}");
    }
  }

  static void _parseFeat2Data(List<dynamic> args) {
    final SendPort sendPort = args[0];
    final String responseBody = args[1];

    try {

    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
