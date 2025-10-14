import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:practiceapp/src/feature/feature3/domain/model/feature3.dart';

class Feature3Api {
  final link = "https://api.artic.edu/api/v1/artworks?limit=100";

  Future<void> getDataForFeat3() async {
    try {
      final uri = Uri.parse(link);
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final jvals = jsonDecode(res.body);
        final List<dynamic> data = jvals['data'];
        final feat3Isolate = Isolate.spawn(_parseFeat3Data, []);
      } else {
        print("Failed: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static void _parseFeat3Data(List<dynamic> args) {
    final SendPort sendPort = args[0];
    final List<dynamic> decodedResponse = args[1];

    try {
      final List<Feature3> feat3Data =
          decodedResponse.map((i) => Feature3.fromJson(i)).toList();
      sendPort.send(feat3Data);
    } catch (e) {
      sendPort.send([]);
    }
  }
}
