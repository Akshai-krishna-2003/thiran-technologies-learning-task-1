import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;
import 'package:practiceapp/src/feature/feature3/domain/model/feature3.dart';

class Feature3Api {
  final String link = "https://api.artic.edu/api/v1/artworks?limit=100";

  Future<List<Feature3>> getDataForFeat3() async {
    try {
      final uri = Uri.parse(link);
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final Map<String, dynamic> jvals = jsonDecode(res.body);
        final List<dynamic> data = jvals['data'];

        final receivePort = ReceivePort();

        dynamic jklIsolate = await Isolate.spawn(_parseFeat3Data, {
          'sendPort': receivePort.sendPort,
          'data': data,
        });

        // Wait for parsed data
        final result = await receivePort.first;
        final List<Feature3> theData = List<Feature3>.from(result as List);

        // // Print parsed results
        // for (var item in theData) {
        //   print("id is: ${item.id}");
        //   print("title is: ${item.title}");
        //   print("description is: ${item.description}");
        // }
        // print(theData);

        jklIsolate.kill();

        return theData;
      } else {
        throw Exception("HTTP Error: ${res.statusCode}, ${res.body}");
      }
    } catch (e) {
      throw Exception("Error in getDataForFeat3: ${e.toString()}");
    }
  }

  // Isolate entry point
  static void _parseFeat3Data(Map<String, dynamic> message) {
    final SendPort sendPort = message['sendPort'];
    final List<dynamic> decodedResponse = message['data'];

    try {
      print(decodedResponse);
      print(decodedResponse.length);
      final List<Feature3> feat3Data =
          decodedResponse.map((i) => Feature3.fromJson(i)).toList();
      sendPort.send(feat3Data);
    } catch (e) {
      print(e.toString());
      sendPort.send([]);
    }
  }
}
