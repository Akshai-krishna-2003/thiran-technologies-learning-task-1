import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:practiceapp/src/feature/feature5/domain/model/feature5.dart';

class Feature5Api {
  final String link = "https://restcountries.com/v3.1/all?fields=flags";

  Future<List<Feature5>> getDataForFeat5() async {
    try {
      final uri = Uri.parse(link);
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final List<dynamic> data = jsonDecode(res.body);

        // Use isolate for background parsing
        final receivePort = ReceivePort();
        final isolate = await Isolate.spawn(_parseFeat5Data, {
          'sendPort': receivePort.sendPort,
          'data': data,
        });

        // Wait for parsed data
        final result = await receivePort.first;
        isolate.kill();

        final List<Feature5> theData = List<Feature5>.from(result as List);

        print("Total flags fetched: ${theData.length}");
        for (var item in theData.take(5)) {
          print("🇺🇳 PNG: ${item.pngUrl}");
          print("SVG: ${item.svgUrl}");
          print("ALT: ${item.description}");
        }

        return theData;
      } else {
        throw Exception("HTTP Error: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Error in getDataForFeat5: ${e.toString()}");
    }
  }

  // Isolate entry point for parsing
  static void _parseFeat5Data(Map<String, dynamic> message) {
    final SendPort sendPort = message['sendPort'];
    final List<dynamic> decodedResponse = message['data'];

    try {
      final List<Feature5> feat5Data =
          decodedResponse.map((i) => Feature5.fromJson(i)).toList();
      sendPort.send(feat5Data);
    } catch (e) {
      print("Parsing error: $e");
      sendPort.send([]);
    }
  }
}
